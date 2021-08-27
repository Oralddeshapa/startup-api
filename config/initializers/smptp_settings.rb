ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "gmail.com",
    :user_name => Rails.application.credentials.gmail_login,
    :password => Rails.application.credentials.gmail_pass,
    :authentication => "plain",
    #:enable_starttls_auto => true
}
