class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :author
      t.string :comment
      t.string :date
      t.string :rating

      t.timestamps
    end
  end
end
