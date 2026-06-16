require "rails_helper"

RSpec.describe TicketAssignmentService do
  describe ".least_busy_agent" do
    it "escolhe o responsável com menos chamados ativos" do
      ana = create(:agent)
      bruno = create(:agent)
      create_list(:ticket, 2, agent: ana, status: :aberto)
      create(:ticket, agent: bruno, status: :aberto)

      expect(described_class.least_busy_agent).to eq(bruno)
    end

    it "considera responsável com ZERO chamados (caso do LEFT JOIN)" do
      ana = create(:agent)
      carla = create(:agent)
      create(:ticket, agent: ana, status: :aberto)

      expect(described_class.least_busy_agent).to eq(carla)
    end

    it "ignora chamados resolvidos e fechados na contagem" do
      ana = create(:agent)
      bruno = create(:agent)
      create(:ticket, agent: ana, status: :aberto)
      create(:ticket, agent: bruno, status: :aberto)
      create(:ticket, agent: bruno, status: :resolvido)
      create(:ticket, agent: bruno, status: :fechado)

      expect(described_class.least_busy_agent).to eq(ana)
    end
  end

  describe ".assign!" do
    it "atribui o chamado ao responsável menos ocupado" do
      ocupada = create(:agent)
      livre = create(:agent)
      create(:ticket, agent: ocupada, status: :aberto)

      ticket = build(:ticket, agent: nil)
      described_class.assign!(ticket)

      expect(ticket.agent).to eq(livre)
    end
  end
end
