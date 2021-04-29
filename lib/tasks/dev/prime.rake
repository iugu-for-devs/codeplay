require 'faker'

if Rails.env.development? || Rails.env.test?

  namespace :dev do
    desc 'Sample data for local development environment'
    task prime: [:environment, 'db:setup'] do
      puts "\n=== Criando Admins ===\n"

      admins = Fabricate.times(20, :admin)

      puts "   #{admins.size} admins foram gerados. \n"

      puts "\n=== Criando Usuários ===\n"

      users = Fabricate.times(20, :user)

      puts "   #{users.size} usuários foram gerados. \n"

      puts "=== Criando cursos ===\n"

      courses = Fabricate.times(30, :course)

      puts "   #{courses.size} cursos foram gerados. \n"

      puts "=== Criando assinaturas ===\n"

      subscriptions = Fabricate.times(30, :subscription)

      subscriptions.each do |subs|
        subs.courses << courses[0..3]
      end
      
      puts "   #{subscriptions.size} assinaturas foram gerados. \n"
    end
  end
end
