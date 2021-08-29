ActiveAdmin.register Idea do
  
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
      if @idea.save
        flash[:success] = "New Idea created."
      else
        flash[:success] = "New Idea createdn't."
      end
      redirect_to ENV['LOCAL_DEPLOY_URL_ADMIN'] + '/ideas'
    end

    def idea_params
      permitted_params.require(:idea).permit(:user_id, :title, :problem, :field, :region)
    end
  end

end
