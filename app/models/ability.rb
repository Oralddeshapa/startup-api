# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Idea, active: true
    can [:read, :create, :update, :destroy], Post, user_id: user.id
  end
end
