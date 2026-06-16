class Agent < ApplicationRecord
  has_many :tickets, dependent: :restrict_with_error

  validates :name, presence: true

  # Quantos chamados ativos este responsável tem na fila agora.
  # Usado pela distribuição automática (item 4.0).
  def active_tickets_count
    tickets.active.count
  end
end
