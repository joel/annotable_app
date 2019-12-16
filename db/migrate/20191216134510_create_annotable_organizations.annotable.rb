# This migration comes from annotable (originally 20191216112504)
class CreateAnnotableOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :annotable_organizations, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
