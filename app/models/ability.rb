class Ability
  include CanCan::Ability
  
  def initialize(user)    
    if user.admin?
      can :manage, User
      can :manage, Profile
      can :manage, WallMessage
      can :manage, Friendship
    else
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
    end
  end
end