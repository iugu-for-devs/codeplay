# CodePlay

CodePlay é um projeto de aulas aulas aulas
conversa com outro projeto, Iugu-Lite



## Como iniciar o projeto

------

Para executar esse projeto você deve ter um computador, preferencialmente com Linux, com a linguagem de programação Ruby na versão 3.0.1

Dentro do diretório do projeto, você deve instalar as dependências definidas no arquivo `Gemfile` com o comando `bundle [install]`.

Se preferir iniciar o ambiente de teste com dados carregados no banco de dados execute o comando `rake dev:prime`.

Com todas dependências instaladas, execute `rails server` e acesse `localhost:3000` em seu navegador.

## Executando os testes

------

Com todas dependências instaladas, como descrito na seção anterior, em seu terminal execute `rspec`.

- [Equipe](#Equipe)

## Principais Características e Funcionalidades

------

- O projeto RentalCars é focado somente nos funcionários da empresa de locação, servindo como um sistema interno e não como um site onde os clientes podem agendar locações
- O sistema administra o cadastro de filiais (subsidiaries)
- O sistema gerencia categorias de carros e modelos de carros disponíveis para locação, sem distinção de filiais
- A categoria de um carro define seu preço padrão de locação, no entanto é possívei customizar os preços de locação por filial
- Um carro da frota deve ser sempre vinculado a um a filial
- Uma locação deve ser agendada, definindo o cliente, as datas de retirada e devolução e a categoria de carro. Nesse momento é feita uma validação de que existem carros disponíveis no período escolhido.
- Ao finalizar o agendamento é gerado um código único da locação
- Ao iniciar a locação, deve ser escolhido o carro de acordo com a categoria escolhida
- Uma locação deve ser composta de ao menos um carro e 0 ou N acessórios adicionais (AddOns) além de 0 ou N coberturas de seguro



## Equipe

------

A equipe foi composta (em ordem alfabética) entre os dois projetos por: 

#### CodePlay

- [Daniel Nottingham ](https://github.com/danielnottingham) 
- [Danilo RP Silva ](https://github.com/danilorpsilva)
- [Danilo Tupinambá ](https://github.com/DanTupi)
- [Diego Morais ](https://github.com/diegormorais)
- [Guilherme Roque ](https://github.com/GuiRokk)
- [Janilson Silva ](https://github.com/Jannilsonn)
- [Jorge Borges ](https://github.com/JorgeLAB)
- [Lucas Benevides ](https://github.com/lBenevides)
- [Matheustlacerda ](https://github.com/Matheustlacerda)
- [marcosantonio0307 ](https://github.com/marcosantonio0307)

- [Samuel Batista dos Santos](https://github.com/batistasamuel) 

  

#### Iugu-Lite

  
- [Andre_Torres ](https://github.com/andre-dan)

- [Beatriz Rodrigues ](https://github.com/mntrrdrgs)

- [FelipeLTrovo ](https://github.com/FelipeLTrovo)

- [Heitor Adão Jr ](https://github.com/heitoradao)

- [gabrielsugai ](https://github.com/gabrielsugai)

- [Josue Costa ](https://github.com/J-Costa)

- [leandrohorizon ](https://github.com/leandrohorizon)

- [lucasy ](https://github.com/lucasy95)

- [Mauricio Oliveira ](https://github.com/mau-os)

- [siabreu ](https://github.com/siabreu)

#### Suporte nos dois projetos

- [João Almeida ](https://github.com/joaorsalmeida)

- [Henrique Morato ](https://github.com/HenriqueMorato)


Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
