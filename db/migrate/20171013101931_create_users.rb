class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: false do |t|
      t.string :id, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :password_hash, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    execute "ALTER TABLE results ADD PRIMARY KEY (id);"
  end
end
