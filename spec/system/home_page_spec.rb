require 'rails_helper'

describe 'Home page' do
  describe 'Unauthenticated user' do
    context 'header' do
      it 'can see link buttons' do
        visit root_path

        expect(page).to have_link('Home', href: root_path)
        expect(page).to have_link('Cursos', href: courses_path)
        expect(page).to have_link('Assinaturas', href: subscriptions_path)
      end

      it 'can see login button' do
        visit root_path

        click_on 'Entrar'
        expect(current_path).to eq(new_user_session_path)
      end

      it 'can see sign up button' do
        visit root_path

        click_on 'Nova Conta'
        expect(current_path).to eq(new_user_registration_path)
      end
    end

    context 'intro content' do
      it 'can see call text' do
        visit root_path

        within '.intro-content' do
          expect(page).to have_content('Junte-se à Milhares, Aprenda a Codar com a CodePlay.')
          expect(page).to have_content('Aprender de verdade é aqui! Escolhe entre vários Cursos e Assinaturas.')
        end
      end

      it 'can see button to see some courses' do
        visit root_path

        within '.intro-content' do
          expect(page).to have_link('Veja alguns cursos')
          click_on('Veja alguns cursos')
        end
        expect(current_path).to eq(courses_path)
      end
    end

    context 'courses section' do
      let!(:courses) { Fabricate.times(6, :course) }

      it 'can see buttons control carousel' do
        visit root_path

        page.execute_script 'window.scrollBy(0,10000)'

        within '.courses-section' do
          expect(page).to have_content('Anterior')
          expect(page).to have_content('Próximo')
        end
      end

      it 'can be seen a carousel with some courses' do
        visit root_path

        page.execute_script 'window.scrollBy(0,1000)'

        within '.courses-section' do
          courses.each do |course|
            expect(page).to have_content(course.name)
            click_on('Próximo')
          end

          expect(page).to have_css('.course', count: 3)
        end
      end

      it 'can see prices' do
        visit root_path

        page.execute_script 'window.scrollBy(0,1000)'

        within '.courses-section' do
          courses.each do |course|
            expect(page).to have_content(course.price)
            click_on('Próximo')
          end
        end
      end

      it 'can see names and descriptions' do
        visit root_path

        page.execute_script 'window.scrollBy(0,1000)'

        within '.courses-section' do
          courses.each do |course|
            expect(page).to have_content(course.name)
            expect(page).to have_content(course.description)
            click_on('Próximo')
          end
        end
      end

      it 'can see number of lessons' do
        courses.each do |course|
          Fabricate.times(7, :lesson, course: course)
        end

        visit root_path

        page.execute_script 'window.scrollBy(0,1000)'

        within '.courses-section' do
          courses.each do |course|
            expect(page).to have_content("#{course.lessons.size} Aulas")
            click_on('Próximo')
          end
        end
      end
    end

    context 'programs section' do
      it 'can see title program' do
        visit root_path

        page.execute_script 'window.scrollBy(0,10000)'

        within '#programs-section' do
          expect(page).to have_content('Nossa forma de Fazer você aprender!')
        end
      end

      it 'can see the first section' do
        courses = Fabricate.times(20, :course)
        clients = Fabricate.times(20, :user)

        visit root_path

        page.execute_script 'window.scrollBy(0,10000)'

        within '#programs-section' do
          expect(page).to have_content('Diga a nós o que você quer aprender, Que nós mostraremos como!')
          expect(page).to have_content('Nossa plataforma utiliza de curso em '\
                                       'vídeo e textos para passar o melhor conteúdo que se encontre no mercado.')
          expect(page).to have_content("São #{courses.size} cursos de várias linguagens.")
          expect(page).to have_content("São mais de #{clients.size} alunos em nosso plataforma.")
        end
      end

      it 'can see the second section' do
        subscriptions = Fabricate.times(20, :subscription)

        visit root_path

        page.execute_script 'window.scrollBy(0,10000)'

        within '#programs-section' do
          expect(page).to have_content('A estrutura que você merece!')
          expect(page).to have_content('Nosso maior desejo é proporcionar conhecimento e conteúdo de qualidade.')
          expect(page).to have_content("São #{subscriptions.size} assinaturas só para clicar e aproveitar.")
        end
      end

      it 'can see the third section' do
        visit root_path

        page.execute_script 'window.scrollBy(0,10000)'

        within '#programs-section' do
          expect(page).to have_content('Ensinar para à vida!')
          expect(page).to have_content('Somos apaixonados pelo ensino, lutamos, portanto, '\
                                       'por uma sociedade na qual todo indivíduo tenha acesso '\
                                       'ao ensino online de forma completa e qualitativa.')
        end
      end
    end

    context 'testimonial section' do
      it 'can see testimony of a student' do
        visit root_path

        page.execute_script 'window.scrollBy(0,1000)'

        within '#testimonial-section' do
          expect(page).to have_content('Yukihiro Matsumoto')
          expect(page).to have_content('Ter realizado os cursos na CodePlay ... '\
                                       'bem sem palavras foi uma ótima experiência '\
                                       'Não só recomendo como espero que você já seja um Code. ;)')
        end
      end
    end

    context 'why choose' do
      it 'can see platform qualities' do
        visit root_path

        page.execute_script 'window.scrollBy(0,1000000)'

        within '#why_choose' do
          expect(page).to have_content('Por que nos escolher!??')
          expect(page).to have_content('Somos os melhores profissionais deste mundo')
          expect(page).to have_content('Expandir seu conhecimento')
          expect(page).to have_content('Melhor ensino à distância disponível no mercado')
          expect(page).to have_content('Melhores Professores')
        end
      end
    end

    context 'footer' do
      it 'can see footer' do
        visit root_path

        page.execute_script 'window.scrollBy(0,1000000)'

        within '.footer-section' do
          expect(page).to have_content('SOBRE À CODEPLAY')
          expect(page).to have_content('Nossa missão é propiciar educação online de qualidade')
          expect(page).to have_content('DEIXE SEU EMAIL')
          expect(page).to have_content('Para receber avisos e notícias por email')
          expect(page).to have_link('Home', href: root_path)
          expect(page).to have_link('Cursos', href: courses_path)
          expect(page).to have_link('Assinaturas', href: subscriptions_path)
        end
      end
    end
  end
end
