# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.creator?
      can :read, Idea, active: true
      can :get_fields, Idea
      can :create, Idea
      can :show, Idea
    end
    if user.investor?
      can :read, Idea
      can :show, Idea #change later
      #byebug
    end
    #can :read, Idea, active: true
    #can [:read, :create, :update, :destroy], Idea, user_id: user.id
  end
end
