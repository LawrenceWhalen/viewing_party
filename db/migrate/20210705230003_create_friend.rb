class CreateFriend < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :friender, references: :users, foreign_key: { to_table: :users}
      t.references :friendee, references: :users, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
