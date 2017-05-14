class AddUserToProduct < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :user, index: true
  end
end
