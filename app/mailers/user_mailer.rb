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
   @sub_link = ENV['FRONT_URL'] + '/subscribe/' + @idea.id.to_s + '/' + params[:token].to_s  
   mail(to: @user.email, subject: 'New idea was posted')
 end
end
