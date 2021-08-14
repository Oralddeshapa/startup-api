# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.creator?
      can :read, Idea, active: true
      can :get_fields, Idea
      can :create, Idea
    end
    if user.investor?
      #byebug
    end
    #can :read, Idea, active: true
    #can [:read, :create, :update, :destroy], Idea, user_id: user.id
  end
end
