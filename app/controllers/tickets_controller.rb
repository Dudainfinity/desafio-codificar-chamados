class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy assign_auto]

  def index
    @tickets = Ticket.includes(:agent).order(created_at: :desc)
    @tickets = @tickets.where(status: params[:status]) if params[:status].present?
    @tickets = @tickets.where(priority: params[:priority]) if params[:priority].present?
    @tickets = @tickets.where(agent_id: params[:agent_id]) if params[:agent_id].present?
    @agents = Agent.order(:name)
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to @ticket, notice: "Chamado criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: "Chamado atualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path, notice: "Chamado removido."
  end

  def assign_auto
    TicketAssignmentService.assign!(@ticket)
    if @ticket.save
      redirect_to @ticket, notice: "Atribuido automaticamente a #{@ticket.agent.name}."
    else
      redirect_to @ticket, alert: "Nao foi possivel atribuir."
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :priority, :status, :agent_id)
  end
end
