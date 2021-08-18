class AddWebsiteToBand < ActiveRecord::Migration[6.0]
  def change
    add_column :bands, :website, :string
  end
end
