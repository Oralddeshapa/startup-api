ActiveAdmin.register Idea do
  permit_params :user_id, :title, :field, :region, :problem

  form do |f|
    inputs "Details" do
      input :user
      input :title
      input :problem
      input :field
      input :region
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

    def idea_params
      permitted_params.require(:idea).permit(:user_id, :title, :problem, :field, :region)
    end
  end

end
