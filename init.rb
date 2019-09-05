class Init
  def install
    update_cron
  end

  def clear_cron
    new_cron = read_crontab.gsub(/.*TeachBase Reminder\n/, '')
    write_crontab(new_cron)
  end

  private

  def write_crontab(contents)
    IO.popen('crontab', 'r+') do |crontab|
      crontab.write(contents)
      crontab.close_write
    end
  end

  def read_crontab
    %x[crontab -l]
  end

  def update_cron
    crontab = read_crontab
    new_cron = crontab.gsub(/.*TeachBase Reminder\n/, '')

    new_cron += prepare

    write_crontab(new_cron)
  end

  def prepare
    "\n*/5 * * * * /bin/bash -l -c 'cd #{__dir__} && ruby main.rb' # TeachBase Reminder\n"
  end
end

Init.new.install
