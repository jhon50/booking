class CreateBookinggs < ActiveRecord::Migration[5.2]
  def change
    create_table :bookinggs do |t|
      t.references :user, foreign_key: true
      t.string :desk
      t.date :from
      t.date :to

      t.timestamps
    end
  end
end
