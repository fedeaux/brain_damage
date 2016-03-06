class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :title
      t.belongs_to :contact_role, index: true, foreign_key: true
      t.string :ac_info

      t.timestamps null: false
    end
  end
end
