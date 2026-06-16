# Responsável por escolher AUTOMATICAMENTE o agente que vai
# atender um chamado, conforme o item 4.0 do desafio:
# "atribuir ao responsável com menos chamados em aberto".
#
# Regra de "em aberto": definida no scope Ticket.active
# (status aberto ou em_andamento). A lógica vive lá, este
# service só a consome — mudou a regra, muda só no model.
class TicketAssignmentService
  # Retorna o agente com a MENOR carga ativa no momento.
  # Empate: o primeiro encontrado (ordem estável por id).
  def self.least_busy_agent
    Agent
      .left_joins(:tickets)
      .where(tickets: { status: Ticket.statuses.values_at(:aberto, :em_andamento) })
      .or(Agent.where(tickets: { id: nil }))
      .group(:id)
      .order(Arel.sql("COUNT(tickets.id) ASC"), :id)
      .first
  end

  # Atribui o chamado ao agente menos ocupado e salva.
  def self.assign!(ticket)
    ticket.agent = least_busy_agent
    ticket
  end
end
