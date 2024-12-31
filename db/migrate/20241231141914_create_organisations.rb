class CreateOrganisations < ActiveRecord::Migration[7.0]
  def change
    create_table :organisations do |t|

      t.timestamps
    end
  end
end
