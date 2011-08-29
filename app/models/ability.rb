class Ability
  include CanCan::Ability
  
  def initialize(user)    
    alias_action :read, :create, :update, :destroy, :view_stats, :to => :administer

    can :read, :all
    can :manage, Profile do |profile|
      profile.try(:user) == user
    end
    can :remove_from_friends, User do |target|
      Friendship.where(:user_id => user.id, :target_id => target.id).exists?
    end
    can :accept_friendship_from, User do |target|
      Friendship.unaccepted.where(:user_id => target.id, :target_id => user.id).exists?
    end
    can :manage_unaccepted_friends_of, User do |target|
      target == user && Friendship.unaccepted.where(:target_id => target.id).exists?
    end
    can :manage, Album do |album|
      album.try(:user) == user
    end
    can :manage, Photo do |photo|
      photo.try(:album).try(:user) == user
    end

    if user.admin?
      can :administer, User
      can :update, Profile
    else
      cannot :read, User
    end

  end
end