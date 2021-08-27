ActiveAdmin.register User do
  permit_params :username, :email, :role, :password

  form do |f|
    inputs "Details" do
      input :username
      input :email
      input :role
      input :password
    end
    actions
  end

  controller do
    def new
      @user = User.new
    end

    def create
      @user = User.find_by(email: permitted_params[:email]) || User.find_by(username: permitted_params[:username])
      unless @user
        @user = User.new(user_params)
        if @user.save
          flash[:success] = "New User created."
        else
          flash[:success] = "New User createdn't."
        end
      else
        flash[:success] = "New User createdn't."
      end
      redirect_to (ENV['LOCAL_DEPLOY_URL_ADMIN'] + '/users')
    end

    def user_params
      permitted_params.require(:user).permit(:username, :email, :role, :password)
    end
  end
end
