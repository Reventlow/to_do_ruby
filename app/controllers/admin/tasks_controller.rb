class Admin::TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_solved]

  # GET /admin/tasks
  def index
    @tasks = Task.all
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
    if @task.update(task_params)
      redirect_to admin_task_path(@task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/tasks/:id
  def destroy
    @task.destroy
    redirect_to admin_tasks_url, notice: 'Task was successfully destroyed.'
  end

  def toggle_solved
    @task.solved = !@task.solved
    if @task.save
      redirect_back(fallback_location: admin_tasks_url, notice: 'Task status was successfully updated.')
    else
      redirect_back(fallback_location: admin_tasks_url, alert: 'There was a problem updating the task status.')
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :solved, :parent_task_id, child_task_ids: [], user_ids: [])
  end

end
