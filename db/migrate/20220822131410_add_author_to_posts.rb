class AddAuthorToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :author, null: false, references: :users, foreign_key: {to_table: :users}
  end
end
