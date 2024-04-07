class AddParentTaskToTasks < ActiveRecord::Migration[6.0]
  def change
    # Add the parent_task_id column to tasks
    add_column :tasks, :parent_task_id, :integer, null: true
    # Manually add the foreign key constraint to ensure it points to the tasks table itself
    add_foreign_key :tasks, :tasks, column: :parent_task_id
  end
end

