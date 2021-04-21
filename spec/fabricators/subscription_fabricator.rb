Fabricator(:subscription) do
  name { sequence(:name) { |i| "Subscription-##{i + 1}" } }
  description 'Esta assinatura ira abranger todos os cursos de Ruby e Rails'
  price 25
end
