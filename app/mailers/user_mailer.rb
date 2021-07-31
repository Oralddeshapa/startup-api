class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

 def succ_registered
   @user = params[:user]
   @url  = 'http://localhost:3000'
   mail(to: @user.email, subject: 'Welcome to My Awesome Site')
 end
end
