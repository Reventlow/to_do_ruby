class Admin::TasksController < ApplicationController
  before_action :authenticate_user! # Ensures user is logged in
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_solved, :remove_assignee]
  load_and_authorize_resource except: :toggle_solved # CanCanCan

  # GET /admin/tasks
  def index
    @tasks_unsolved = Task.where(solved: false).order(:due_date).includes(:child_tasks)
    @tasks_solved = Task.where(solved: true).order(:due_date).includes(:child_tasks)
  end

  # GET /admin/tasks/:id
  def show
  end

  # GET /admin/tasks/new
  def new
    @task = Task.new
  end

  # GET /admin/tasks/:id/edit
  def edit
  end

  # POST /admin/tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to admin_task_path(@task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/tasks/:id
  def update
    # Safely handle the possibility of no child tasks being selected
    submitted_child_task_ids = params[:task][:child_task_ids]&.reject(&:blank?)&.map(&:to_i) || []
    existing_child_task_ids = @task.child_tasks.pluck(:id)

    tasks_to_remove = existing_child_task_ids - submitted_child_task_ids
    tasks_to_add = submitted_child_task_ids - existing_child_task_ids

    # Begin a transaction to ensure data integrity
    ActiveRecord::Base.transaction do
      # Remove unselected child tasks
      @task.child_tasks.where(id: tasks_to_remove).each do |child|
        child.update(parent_task_id: nil)
      end

      # Add newly selected child tasks
      Task.where(id: tasks_to_add).each do |child|
        child.update(parent_task_id: @task.id)
      end

      # Proceed to update the task with any other submitted attributes
      if @task.update(task_params.except(:child_task_ids))
        redirect_to admin_task_path(@task), notice: 'Task was successfully updated.'
      else
        render :edit
      end
    end
  rescue => e
    # Log the error or handle it as you see fit
    logger.error "Error updating task: #{e.message}"
    render :edit, alert: 'There was a problem updating the task.'
  end



  # DELETE /admin/tasks/:id
  def destroy
    @task.destroy
    redirect_to admin_tasks_url, notice: 'Task was successfully destroyed.'
  end

  # PATCH /admin/tasks/:id/toggle_solved
  def toggle_solved
    @task.solved = !@task.solved
    if @task.save
      redirect_back(fallback_location: admin_tasks_url, notice: 'Task status was successfully updated.')
    else
      render :edit, alert: 'There was a problem updating the task status.'
    end
  end

  # DELETE /admin/tasks/:id/remove_assignee/:user_id
  def remove_assignee
    user = User.find(params[:user_id])
    if @task.users.delete(user)
      flash[:notice] = "#{user.name} was successfully removed from the task."
    else
      flash[:alert] = "There was a problem removing #{user.name} from the task."
    end
    redirect_to admin_tasks_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :solved, user_ids: []).tap do |whitelisted|
      whitelisted[:child_task_ids] = params[:task][:child_task_ids] || []
    end
  end
end
