# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
john_doe = User.create(
  #full_name: 'John Doe',
  email: 'user01@iugu.com.br',
  password: 'Iugu@1234',
  password_confirmation: 'Iugu@1234',
  # cpf: '00000000353',
  # birthdate: '08/08/1990',
  # address: {
  #   zipcode: '09060650',
  #   street: 'Joaquim Nabuco',
  #   number: '100',
  #   complement: 'Casa 2',
  #   state: 'SP',
  #   city: 'São Paulo'
  # }
) #do |resource|
  #resource.skip_confirmation!
#end

bob_doe = User.create(
  # full_name: 'Bob Doe',
  email: 'user02@iugu.com.br',
  password: 'Iugu@1234',
  password_confirmation: 'Iugu@1234',
  # cpf: '00000000353',
  # birthdate: '08/08/1990',
  # address: {
  #   zipcode: '09060650',
  #   street: 'Rua Joaquim Nabuco',
  #   number: '100',
  #   complement: 'Casa 1',
  #   state: 'SP',
  #   city: 'São Paulo'
  # }
)

admin_adamastor = Admin.create(
    name: 'Adamastor',
    email: 'admin1@codeplay.com.br',
    password: '123456'
)

rails_course = Course.create(
  name: 'Curso de Rails',
  description:  'Curso de especialização em Rudby on Rails 7.0',
  price: 50.00,
  admin_id: admin_adamastor.id
)

sql_course = Course.create(
  name: 'Curso de SQL',
  description:  'Curso de especialização em Sql',
  price: 70.00,
  admin_id: admin_adamastor.id
)

first_lesson = Lesson.create(
  name: 'Aula-01',
  description: 'Isso é uma aula',
  course: rails_course,
  video_code: '139407849'
)

monthly_subscription = Subscription.create(
  name: 'Jornada Mensal',
  description:  'Plano com cobrança mensal que cobre todos os cursos da plataforma',
  price: 30.00
)

subscription_rails = SubscriptionCourse.create(
  course: rails_course,
  subscription: monthly_subscription
)
