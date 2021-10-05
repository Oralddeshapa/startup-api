class AnnouncerWorker
  include Sidekiq::Worker

  def perform
    send_notification(User.all)
  end

  def send_notification()
    ideas = Idea.where(is_active: true)
    ideas.each { |idea|
      if idea.close_date < Time.now
        idea.update(is_active: false)
        puts idea
      end
    }
  end
end
