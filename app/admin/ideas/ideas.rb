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
    def new
      @idea = Idea.new
    end

    def create
      @idea = Idea.new(idea_params)
      @idea.rating = 0
      if @idea.save
        flash[:success] = "New Idea created."
      else
        flash[:success] = "New Idea createdn't."
      end
      redirect_to request.fullpath
    end

    def update
      @idea = Idea.find(params[:id])
      byebug
      @idea.update(idea_params)
      redirect_to request.fullpath
    end

    def idea_params
      permitted_params.require(:idea).permit(:user_id, :title, :problem, :field, :region, :close_date)
    end
  end

end
