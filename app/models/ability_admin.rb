class AbilityAdmin
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all
    can :create, :all
    can :delet, :all
    can :update, :all
  end
end
