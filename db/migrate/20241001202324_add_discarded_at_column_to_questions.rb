class AddDiscardedAtColumnToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :discarded_at, :datetime
  end
end
