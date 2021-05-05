class AddConfirmToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :confirm, :boolean, default: false
  end
end
