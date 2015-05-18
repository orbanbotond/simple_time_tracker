module Features
  module SessionHelpers
    def sign_in(user = nil, pwd = nil)
      default_pwd = 'Passw0rd'
      visitor = user || create( :user, email: 'orbanbotond@gmail.com', password: default_pwd, password_confirmation: default_pwd)
      password = pwd || default_pwd
      visit new_user_session_path
      fill_in "user_email", with: visitor.email
      fill_in 'user_password', with: password
      click_on 'Log in'
    end
  end
end

module Features
  module DateTimeHelpers
    def select_by_value(value, options = {})
      field = options[:from]
      option_xpath = "//*[@id='#{field}']/option[#{value}]"
      option_text = find(:xpath, option_xpath).text
      select option_text, :from => field
    end

    def select_date(date, options)
      field = options[:from]
      select date.year.to_s,   :from => "#{field}_1i"
      select_by_value date.month, :from => "#{field}_2i"
      select date.day.to_s,    :from => "#{field}_3i"  
    end

    def select_time(time, options)
      field = options[:from]
      hour = sprintf('%02d',time.hour)
      select hour,   :from => "#{field}_4i"
      minute = sprintf('%02d',time.min)
      select minute, :from => "#{field}_5i"
    end
  end
end

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::DateTimeHelpers, type: :feature
end
