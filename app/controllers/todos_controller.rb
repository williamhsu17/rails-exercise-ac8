class TodosController < ApplicationController

  before_action :authenticate_user!
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  def v1
  end

  def index
    @todos = current_user.todos.all

    render :json => @todos.map{ |t|
      { :id => t.id,
        :title => t.title
      }
    }
  end

  def create
    @todo = current_user.todos.new( :title => params[:title] )

    @todo.save!

    render :json => { :id => @todo.id, :title => @todo.title }
  end

  def destroy
    @todo.destroy

    render :json => { :id => @todo.id }
  end

  private

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end

end
