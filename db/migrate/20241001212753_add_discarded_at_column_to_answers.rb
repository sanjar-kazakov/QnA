class AddDiscardedAtColumnToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :discarded_at, :datetime
  end
end
