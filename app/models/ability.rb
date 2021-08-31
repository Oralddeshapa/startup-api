# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:authorize, :create], User
    if user.creator?
      can [:read, :update], Idea, active: true, user: user
      can [:get_fields, :create, :show], Idea
      can :update, User
    end
    if user.investor?
      can :update, User
      can [:read, :get_fields, :show], Idea
    end
  end
end
