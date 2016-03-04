class CreateContactRoles < ActiveRecord::Migration
  def change
    create_table :contact_roles do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
