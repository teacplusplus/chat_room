class Communication < ActiveRecord::Migration
  def change
    create_table(:communications , :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8') do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.timestamps
    end

    add_index :communications, [:from_user_id, :to_user_id]
  end
end
