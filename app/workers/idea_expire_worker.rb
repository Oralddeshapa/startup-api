class IdeaExpireWorker
  include Sidekiq::Worker

  def perform
    ideas = Idea.where(is_active: true)
    ideas.each do |idea|
      if idea.close_date < Time.now
        idea.update(is_active: false)
      end
    end
  end
end
