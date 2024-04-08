class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    else
      can :read, :all # You might want to adjust this
      can :solve, Task do |task|
        task.users.include?(user)
      end
    end
  end
end
