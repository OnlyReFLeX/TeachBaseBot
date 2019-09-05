class Client
  attr_reader :cookie, :slack

  def initialize(slack)
    @slack = slack
    @cookie = File.read('cookie.txt')
    authenticate if @cookie.empty?
  end

  def authenticate
    response = faraday.get('/login')
    html = Nokogiri::HTML response.body
    authenticity_token = html.at('input[@name="authenticity_token"]')['value']
    @cookie = response.headers['set-cookie']

    response = faraday.post '/user_sessions' do |req|
      req.headers = req.headers.merge({ 'Cookie' => @cookie })
      req.body = {
        'utf8' => '✓',
        'authenticity_token' => authenticity_token,
        'user_login_form[login]' => USER_LOGIN,
        'user_login_form[password]' => USER_PASSWORD,
        'user_login_form[remember_me]' => 1
      }.map { |param| param.join('=') }.join('&')
    end

    if response.status != 401
      @cookie = response.headers['set-cookie']
      File.write('cookie.txt', @cookie)
    end
  end

  def parse_course(course)
    try = 0
    begin
      response = faraday.get("api/course_sessions/#{course[:course_session_id]}/results.json") do |req|
        req.headers['Cookie'] = cookie
        req.params = course[:params]
      end
      raise 'Невозможно авторизоваться, проверьте данные' if response.status == 401

      response
    rescue => e
      if try > 3
        cannot_authorize(course, e.message)
        exit
      end
      try += 1
      authenticate
      retry
    end
  end

  def cannot_authorize(course, message)
    slack.chat_postMessage(channel: course[:channel], text: message, as_user: true)
  end

  def faraday
    @faraday ||= Faraday.new(url: 'https://go.teachbase.ru') do |builder|
      builder.adapter Faraday.default_adapter
    end
  end
end
