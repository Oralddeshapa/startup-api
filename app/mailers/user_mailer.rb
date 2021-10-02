class UserMailer < ApplicationMailer

 def successfully_registered
   @user = params[:user]
   @url  = ENV['DEPLOY_URL']
   mail(to: @user.email, subject: 'Welcome to My Awesome Site')
 end

 def new_idea_posted
   @user = params[:user]
   @creator = params[:creator]
   @idea = params[:idea]
   @url  = params[:url]
   mail(to: @user.email, subject: 'New idea was posted')
 end
end
