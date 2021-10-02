class ActiveWorker
  include Sidekiq::Worker

  def perform
    ideas = Idea.where(is_active: true)
    ideas.each { |idea|
      if idea.close_date < Time.now
        idea.update(is_active: false)
        puts idea
      end
    }
    puts 'checked for old ideas'
  end
end
