class Api::V1::VacationsController < ApplicationController
  before_action :set_vacation, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  SORTABLE_FIELDS = %w[created_at updated_at start_date end_date vacation_days].freeze

  def index
    @q = Vacation.ransack(params[:q])
    
    order = sanitize_order(params[:order])
    @vacations = @q.result.includes(:collaborator).page(params[:page]).per(params[:per_page] || 10).order(order)

    render json: {
      vacations: @vacations.as_json(include: { collaborator: { only: [:id, :name] } }),
      meta: {
        current_page: @vacations.current_page,
        next_page: @vacations.next_page,
        prev_page: @vacations.prev_page,
        total_pages: @vacations.total_pages,
        total_count: @vacations.total_count
      }
    }
  end

  def show
    render json: @vacation.as_json(include: { collaborator: { only: [:id, :name] } })
  end

  def create
    @vacation = Vacation.new(vacation_params)
    if @vacation.save
      render json: @vacation.as_json(include: { collaborator: { only: [:id, :name] } }), status: :created
    else
      render json: @vacation.errors, status: :unprocessable_entity
    end
  end

  def update
    if @vacation.update(vacation_params)
      render json: @vacation.as_json(include: { collaborator: { only: [:id, :name] } })
    else
      render json: @vacation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vacation.destroy
  end

  private

  def set_vacation
    @vacation = Vacation.find(params[:id])
  end

  def vacation_params
    params.require(:vacation).permit(:collaborator_id, :start_date, :end_date, :vacation_type, :reason, :status)
  end

  def sanitize_order(order_params)
    return 'created_at desc' unless order_params

    field, direction = order_params['field'], order_params['direction']

    if SORTABLE_FIELDS.include?(field) && %w[asc desc].include?(direction)
      "#{field} #{direction}"
    else
      'created_at desc'
    end
  end
end
