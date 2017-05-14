class AddUserToSupplier < ActiveRecord::Migration[5.0]
  def change
    add_reference :suppliers, :user, index: true
  end
end
