class CreatePasswords < ActiveRecord::Migration[5.1]
  def change
    create_table :passwords, id: false do |t|
      t.string :id, null: false
      t.string :user_id, null: false
      t.string :app, null: false
      t.string :cipher, null: false

      t.timestamps
    end
    
    add_index :passwords, :app
    add_index :passwords, [:user_id, :app], unique: true
    execute "ALTER TABLE passwords ADD PRIMARY KEY (id);"
  end
end
