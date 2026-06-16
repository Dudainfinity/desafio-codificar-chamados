class Ticket < ApplicationRecord
  belongs_to :agent

  enum :priority, { baixa: 0, media: 1, alta: 2 }, default: :media
  enum :status,   { aberto: 0, em_andamento: 1, resolvido: 2, fechado: 3 }, default: :aberto

  validates :title, presence: true

  # Item 4.3: define o que é "em aberto".
  # Um chamado pesa na carga de trabalho enquanto NÃO está concluído.
  # resolvido/fechado já saíram da fila, então não contam.
  scope :active, -> { where(status: %i[aberto em_andamento]) }
end
