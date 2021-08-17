class AddLinkToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :link, :string
  end
end
