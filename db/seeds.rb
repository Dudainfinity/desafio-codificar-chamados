agents = ["Maria Eduarda", "Bruno Lima", "Carla Mendes", "Diego Rocha"].map do |name|
  Agent.find_or_create_by!(name: name)
end

if Ticket.none?
  exemplos = [
    { title: "Computador travando",    priority: :alta,  status: :aberto,       description: "Maquina reinicia sozinha." },
    { title: "Solicitacao de cadeira", priority: :baixa, status: :aberto,       description: "Cadeira quebrada." },
    { title: "Impressora nao imprime", priority: :media, status: :em_andamento, description: "Erro de fila no financeiro." },
    { title: "Sem acesso ao e-mail",   priority: :alta,  status: :em_andamento, description: "Nao loga desde ontem." },
    { title: "Troca de monitor",       priority: :baixa, status: :resolvido,    description: "Monitor substituido." },
    { title: "VPN nao conecta",        priority: :media, status: :fechado,      description: "Resolvido apos update." },
    { title: "Mouse com defeito",      priority: :baixa, status: :aberto,       description: "Botao esquerdo falhando." },
    { title: "Lentidao no sistema",    priority: :alta,  status: :aberto,       description: "ERP travando." }
  ]

  exemplos.each_with_index do |attrs, i|
    Ticket.create!(attrs.merge(agent: agents[i % agents.size]))
  end
end

puts "Seed concluido: #{Agent.count} responsaveis, #{Ticket.count} chamados."
