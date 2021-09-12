# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:authorize, :create], User
    can [:read], Comment
    if user.creator?
      can [:read, :update, :destroy], Idea, user: user
      can [:get_fields, :create, :show], Idea
      can :update, User
    end
    if user.investor?
      can :update, User
      can [:read, :get_fields, :show], Idea
      can [:create], Comment
    end
  end
end
