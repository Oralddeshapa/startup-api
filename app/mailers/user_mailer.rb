class UserMailer < ApplicationMailer

 def successfully_registered
   @user = params[:user]
   @url  = ENV['DEPLOY_URL']
   mail(to: @user.email, subject: 'Welcome to My Awesome Site')
 end
end
