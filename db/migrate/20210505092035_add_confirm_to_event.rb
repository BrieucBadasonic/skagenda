class AddConfirmToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :comfirm, :boolean, default: false
  end
end
