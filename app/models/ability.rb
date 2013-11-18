class Ability
  include CanCan::Ability

  def initialize(user)
    user || User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif user.member?
      can :read,   :all
      can :manage, Repo, :author_id => user.id
      can :manage, Post, :author_id => user.id
    else
      cannot :manage, :all
      can    :read, :all
    end
  end
end
