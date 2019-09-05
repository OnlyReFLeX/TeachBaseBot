# rubocop:disable Metrics/AbcSize
class Bot
  attr_reader :client, :results, :timestamps

  def initialize
    @timestamps = parse_timestamps
    @client = Client.new(slack)
  end

  def run
    parse
    publish
  end

  def parse_timestamps
    JSON.parse(File.read('timestamps.txt'))
  rescue JSON::ParserError
    {}
  end

  def parse
    @courses = []
    COURSES.each do |course|
      response = @client.parse_course(course)

      timestamp = timestamps[course[:course_session_id]] || 0
      fix_timestamps(course[:course_session_id])

      json = JSON.parse(response.body, symbolize_names: true)
      @courses << {
        name: course[:name],
        channel: course[:channel],
        results: json[:results].select { |result| result[:finished_at] > timestamp }
      }
    end
  end

  private

  def fix_timestamps(course_id)
    @timestamps[course_id] = Time.now.to_i
    File.write('timestamps.txt', @timestamps.to_json)
  end

  def publish
    @courses.each do |course|
      next if course[:results].empty?
      prepare_text = "\n*==#{course[:name]}==*\n"
      course[:results].each do |result|
        prepare_text += result_template(result)
      end
      slack.chat_postMessage(channel: course[:channel], text: prepare_text, as_user: true)
    end
  end

  def result_template(result)
    "*#{result[:username]}*\n#{result[:task_name]}\n#{result[:finished_time]} | Попытка: #{result[:attempt]}\n"
  end

  def slack
    return @slack if @slack

    Slack.configure do |config|
      config.token = SLACK_BOT_TOKEN
    end
    @slack = Slack::Web::Client.new
  end
end
