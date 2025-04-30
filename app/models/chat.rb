class Chat < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'
  
    has_many :messages, dependent: :destroy
  
    validates :sender_id, :receiver_id, presence: true
    validate :sender_and_receiver_are_different
  
    def sender_and_receiver_are_different
      errors.add(:receiver_id, "must be different from sender") if sender_id == receiver_id
    end
  end
  