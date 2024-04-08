class Task < ApplicationRecord
  # If the tasks can belong to many users through a join table
  has_and_belongs_to_many :users

  # Self-referential associations for parent/child tasks
  belongs_to :parent_task, class_name: "Task", optional: true
  has_many :child_tasks, class_name: "Task", foreign_key: "parent_task_id", dependent: :destroy
end
