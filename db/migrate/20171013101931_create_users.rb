class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: false do |t|
      t.string :id, null: false
      t.string :host_id, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_cipher, null: false

      # internal user can access Yuza admin panel
      t.boolean :is_internal, null: false, default: false

      t.timestamps
    end

    add_index :users, [:host_id, :email], unique: true
    add_index :users, :password_cipher 
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end
