ActiveAdmin.register Idea do
  permit_params :user_id, :title, :field, :region, :problem, :close_date

  form do |f|
    inputs "Details" do
      input :user
      input :title
      input :problem
      input :field
      input :region
      input :close_date, as: :datepicker, datepicker_options: { dateFormat: "mm/dd/yy" }
    end
    actions
  end

  controller do

    def create
      @idea = ActiveRecord::Base.conenction.exec_quert(`INSERT INTO "ideas" VALUES(#{idea_params.join(', ')})`)
      if @idea
        flash[:success] = "New Idea created."
      else
        flash[:success] = "New Idea createdn't."
      end
      redirect_to request.fullpath
    end

    def idea_params
      permitted_params.require(:idea).permit(:user_id, :title, :problem, :field, :region, :close_date)
    end
  end

end
