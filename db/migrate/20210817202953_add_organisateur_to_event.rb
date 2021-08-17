class AddOrganisateurToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :organisateur, :string
  end
end
