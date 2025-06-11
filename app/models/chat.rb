class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :owner, class_name: 'User'
  has_and_belongs_to_many :users

  has_many :messages, dependent: :destroy

  validates :sender_id, :receiver_id, presence: true
  validate :sender_and_receiver_are_different

  scope :for_user, ->(user) {
    left_outer_joins(:users)
    .where(
      "chats.sender_id = :id OR chats.receiver_id = :id OR chats.owner_id = :id OR users.id = :id",
      id: user.id
    )
    .distinct
  }

  def sender_and_receiver_are_different
    errors.add(:receiver_id, "must be different from sender") if sender_id == receiver_id
  end

  def other_participant(current_user)
    if sender == current_user
      receiver
    elsif receiver == current_user
      sender
    else
      (users - [current_user]).first || sender
    end
  end
end
