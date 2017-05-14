class AddUserToShopper < ActiveRecord::Migration[5.0]
  def change
    add_reference :shoppers, :user, index: true
  end
end
