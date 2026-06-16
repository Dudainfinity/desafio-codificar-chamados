require "rails_helper"

RSpec.describe Ticket, type: :model do
  describe "validações" do
    it "exige título" do
      expect(build(:ticket, title: nil)).not_to be_valid
    end

    it "exige um responsável" do
      expect(build(:ticket, agent: nil)).not_to be_valid
    end
  end

  describe ".active (item 4.3: o que conta como 'em aberto')" do
    it "inclui chamados abertos e em andamento" do
      aberto = create(:ticket, status: :aberto)
      andamento = create(:ticket, status: :em_andamento)
      expect(Ticket.active).to include(aberto, andamento)
    end

    it "exclui chamados resolvidos e fechados" do
      resolvido = create(:ticket, status: :resolvido)
      fechado = create(:ticket, status: :fechado)
      expect(Ticket.active).not_to include(resolvido, fechado)
    end
  end
end
