class Api::V1::CollaboratorsController < ApplicationController
  before_action :set_collaborator, only: [:show, :update, :destroy]

  def index
    @collaborators = Collaborator.all
    render json: @collaborators
  end

  def show
    render json: @collaborator
  end

  def create
    @collaborator = Collaborator.new(collaborator_params)
    if @collaborator.save
      render json: @collaborator, status: :created
    else
      render json: @collaborator.errors, status: :unprocessable_entity
    end
  end

  def update
    if @collaborator.update(collaborator_params)
      render json: @collaborator
    else
      render json: @collaborator.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @collaborator.destroy
  end

  private

  def set_collaborator
    @collaborator = Collaborator.find(params[:id])
  end

  def collaborator_params
    params.require(:collaborator).permit(:name, :email, :leader_id)
  end
end
