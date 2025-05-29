class AddOwnerToChats < ActiveRecord::Migration[8.0]
  def change
    add_column :chats, :owner_id, :integer
  end
end
