class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :title
      t.integer :contact_role_id
      t.string :ac_info

      t.timestamps null: false
    end
  end
end
