class IdeaExpireWorker
  include Sidekiq::Worker

  def perform
    ideas = Idea.where(is_active: true)
    ideas.each do |idea|
      if idea.close_date < Time.now
        query = `UPDATE "ideas" SET "#{param.to_sym}" = #{param.value}, `
        end
        query += `WHERE "users"."id" = #{@user.id} AND "ideas"."id" = #{idea.id}`
        update_complete = ActiveRecord::Base.conenction.exec_quert(query)
      end
    end
  end
end
