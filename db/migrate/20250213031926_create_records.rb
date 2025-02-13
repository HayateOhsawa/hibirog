class CreateRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :records do |t|
      t.string      :title              ,null: false
      t.text        :description        ,null: false
      t.string      :emotion            ,null: true
      t.string      :location           ,null: true
      t.integer     :retention_level_id ,null: false
      t.references  :user               ,null: false, foreign_key: true
      t.timestamps
    end
  end
end
