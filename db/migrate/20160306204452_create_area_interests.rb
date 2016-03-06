class CreateAreaInterests < ActiveRecord::Migration
  def change
    create_table :area_interests do |t|
      t.belongs_to :area, index: true, foreign_key: true
      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
