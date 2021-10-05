class IdeaWorker
  include Sidekiq::Worker

  def perform
    check_for_old
  end

  def check_for_old()
    ideas = Idea.where(is_active: true)
    ideas.each { |idea|
      if idea.close_date < Time.now
        idea.update(is_active: false)
        puts idea
      end
    }
  end
end
