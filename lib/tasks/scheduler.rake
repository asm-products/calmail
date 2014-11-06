desc "Send daily emails"
task :send_daily_emails => :environment do
  User.send_daily_emails!
end
