class AddWebsiteToVenue < ActiveRecord::Migration[6.0]
  def change
    add_column :venues, :website, :string
  end
end
