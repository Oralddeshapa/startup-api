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
      @user = ActiveRecord::Base.conenction.exec_quert(`INSERT INTO "users" VALUES(#{user_params.join(', ')})`)
    end

    def create
      @user = ActiveRecord::Base.conenction.exec_quert(`SELECT "users".* FROM "users" WHERE "users"."email" = #{params[:email]}`)  || ActiveRecord::Base.conenction.exec_quert(`SELECT "users".* FROM "users" WHERE "users"."username" = #{params[:username]}`)
      unless @user
        @user = ActiveRecord::Base.conenction.exec_quert(`INSERT INTO "users" VALUES(#{user_params.join(', ')})`)
        if @user
          #UserMailer.with(user: @user).succ_registered.deliver_later
          flash[:success] = "New User created."
        else
          flash[:success] = "New User createdn't."
        end
      else
        flash[:success] = "New User createdn't."
      end
      redirect_to request.fullpath
    end

    def user_params
      permitted_params.require(:user).permit(:username, :email, :role, :password)
    end
  end
end
