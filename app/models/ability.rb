# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
  
    if user.admin?
      can :manage, :all   
    else
      can :read, User, id: user.id
      can [:update, :destroy], User, id: user.id

      can :read, :all
      can :create, Message
      can [:update, :destroy], Message, user_id: user.id


      can :create, Chat


      can :read, Chat do |chat|
        chat.sender_id == user.id ||
        chat.receiver_id == user.id ||
        chat.owner_id == user.id ||
        chat.users.exists?(user.id)
      end


      can [:update, :destroy], Chat, owner_id: user.id
      end
    end
end
