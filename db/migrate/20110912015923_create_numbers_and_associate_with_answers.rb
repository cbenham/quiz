class CreateNumbersAndAssociateWithAnswers < ActiveRecord::Migration
  def change
    create_table :answers_numbers, :id => false do |t|
      t.integer :answer_id
      t.integer :number_id
      t.timestamps
    end

    add_index :answers_numbers, :answer_id, :name => 'by_answer'
    add_index :answers_numbers, :number_id, :name => 'by_number'

    create_table :numbers do |t|
      t.string :number
      t.timestamps
    end
  end
end
