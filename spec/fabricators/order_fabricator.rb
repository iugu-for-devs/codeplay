Fabricator(:order) do
  user
 
  pay_type { PayType.all.last }
  status { 'approved' }
  token { Faker::Alphanumeric.alphanumeric(number: 10) }
end
