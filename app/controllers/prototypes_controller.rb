class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
 
  def index
    @prototypes = Prototype.all
   
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path 
    else
      render :new, status: :unprocessable_entity
   end
 end

  def show
   @prototype = Prototype.find(params[:id])
   @comment = Comment.new
   @comments = @prototype.comments.includes(:user)
   
  end

  def edit
   @prototype = Prototype.find(params[:id])
   
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to @prototype 

    else
      render :edit, status: :unprocessable_entity
   end
   
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end



  private

  def prototype_params
  params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def ensure_correct_user
    @prototype = Prototype.find(params[:id])
    unless @prototype.user_id == current_user.id
      redirect_to root_path
    end
  end
end
