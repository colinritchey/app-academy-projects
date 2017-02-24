class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    create_table :postsubs do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false
    end


    add_index :postsubs, :sub_id
    add_index :postsubs, :post_id
    add_index :postsubs, [:post_id, :sub_id], unique: true

    add_index :posts, :user_id
  end
end
