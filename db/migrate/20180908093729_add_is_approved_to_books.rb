class AddIsApprovedToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :is_approved, :boolean, default: false
  end
end
