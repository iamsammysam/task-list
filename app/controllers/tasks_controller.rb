class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:created_at)
  end 
  
  # Wave 2 - shows task
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      # head :not_found
      redirect_to tasks_path
      return
    end
  end
  
  # Wave 2 - create new task
  def new
    @task = Task.new
  end
  
  def create 
    @task = Task.new(
    name: params[:task][:name],
    description: params[:task][:description],
    completion_date: nil
    ) #instantiates a new task
    
    if @task.save #save returns true if the database insert succeeds
      redirect_to task_path(@task.id)  #go to the index so we can see the task in the list
      return
    else #save failed
      render :new #show the new task form view again
      return
    end
  end
  
  # Wave 3 - edit task
  def edit
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      # head :not_found
      redirect_to tasks_path
      return
    end
  end
  
  # Wave 3 - update task
  def update
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      # head :not_found
      redirect_to tasks_path
      return
    end
    
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    @task.completion_date = params[:task][:completion_date]
    
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end
  
  # Wave 4 - delete task
  def destroy
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to tasks_path
      return
    end
    
    @task.destroy
    redirect_to tasks_path
    return
  end
  
  # Wave 4 - mark task as complete
  def complete
    @task = Task.find_by(id: params[:id])
    
    if @task.completion_date == nil
      @task.update(completion_date: DateTime.now.to_date)
      redirect_to root_path
      return
    else 
      @task.update(completion_date: nil)
      redirect_to root_path
      return
    end 
  end
end 
