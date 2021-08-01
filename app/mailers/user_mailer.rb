class UserMailer < ApplicationMailer

 def succ_registered
   @user = params[:user]
   @url  = ENV['LOCAL_DEPLOY_URL']
   mail(to: @user.email, subject: 'Welcome to My Awesome Site')
 end
end
