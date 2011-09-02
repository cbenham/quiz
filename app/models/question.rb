class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :choice, :class_name => 'Answer', :foreign_key => :choice_id
end
