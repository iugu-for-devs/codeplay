# CodePlay
logo roxinho
------

 [Descrição do projeto](#descrição-do-projeto)

 [Funcionalidades](#funcionalidades)

 [Como iniciar o projeto](#como-iniciar-o-projeto)

 [Requisições API](#requisições-api)

 [Equipe](#equipe)


## Descrição do Projeto
------

CodePlay é uma plataforma de aulas de programação. Nesta plataforma temos dois tipo de acesso, de um lado funcionários da própria CodePlay que cadastram aulas, administram preços e pacotes de assinatura de cursos e do outro lado os clientes, alunos que poderão ver suas aulas adquiridas por compras avulsas ou assinaturas que liberarão uma série de cursos e aulas. 
As aulas podem ser aulas em vídeo ou em texto, podem possuir valor R$ 0,00 (gratuíto), porém o visitante terá de se cadastrar em nossa plataforma e executar a compra.


## Funcionalidades

 - A confirmação de pagamento de aulas e assinatura será passada via API para outro projeto parceiro, a [Iugu-Lite](https://github.com/iugu-for-devs/iugu-lite).
 - Todo cliente cadastrado na plataforma CodePlay enviará uma requisição API enviando formas de pagamento, e token de 20 caracteres referentes à sua identidade. 
 - Na hora da compra de um curso ou assinatura a ação de compra gerará uma requisição API nova para a Iugu-Lite com token de usuário, produto e forma de pagamento.
 - Os funcionários só poderão ser adicionados para a plataforma por outro funcionário já cadastrado, os funcionários deverão acessar o site direto pelo url `/admin` e de lá seguir sua navegação natural de funcionário.

## Como iniciar o projeto

------

Para executar esse projeto você deve ter um computador, preferencialmente com Linux, com a linguagem de programação Ruby na versão 3.0.1.

No terminal de seu computador, clone o projeto:  ```$ git clone https://github.com/iugu-for-devs/codeplay```. Dentro do diretório do projeto(`$ cd  codeplay`), você deve instalar as dependências definidas no arquivo `\Gemfile` com o comando `bundle [install]`.

Se preferir iniciar o ambiente de teste com dados carregados no banco de dados execute o comando `rake dev:prime`.

Com todas dependências instaladas, execute `rails server` e acesse `localhost:3000` em seu navegador.

## Executando os testes

------

Com todas dependências instaladas, como descrito na seção anterior,
Nossa ferramenta de teste utiliza o Google Chrome, certifique-se de que este navegador está instalado em seu computador e em seu terminal execute `rspec`, a lista de funcionalidades e testes estão na pasta `\spec`.

## Layout da aplicação
------

prints das capas

## Requisições API
------
#### Cadastro de Usuário

#### Compra


## Equipe

------

A equipe foi composta (em ordem alfabética) entre os dois projetos por: 

### CodePlay

| [<img src="https://avatars.githubusercontent.com/u/54644738?v=4" width=115><br><sub>Daniel Nottingham</sub>](https://github.com/danielnottingham) |  [<img src="https://avatars.githubusercontent.com/u/51976242?v=4" width=115><br><sub>Danilo RP Silva</sub>](https://github.com/danilorpsilva) |  [<img src="https://avatars.githubusercontent.com/u/56041076?v=4" width=115><br><sub>Danilo Tupinambá</sub>](https://github.com/DanTupi) |  [<img src="https://avatars.githubusercontent.com/u/14100453?v=4" width=115><br><sub>Diego Morais</sub>](https://github.com/diegormorais) |  [<img src="https://avatars.githubusercontent.com/u/32024550?v=4" width=115><br><sub>Guilherme Roque</sub>](https://github.com/GuiRokk) |  [<img src="https://avatars.githubusercontent.com/u/47226735?v=4" width=115><br><sub>Janilson Silva</sub>](https://github.com/Jannilsonn) |  [<img src="https://avatars.githubusercontent.com/u/41846128?v=4" width=115><br><sub>Jorge Borges</sub>](https://github.com/JorgeLAB) |  [<img src="https://avatars.githubusercontent.com/u/58781731?v=4" width=115><br><sub>Lucas Benevides</sub>](https://github.com/lBenevides) |  [<img src="https://avatars.githubusercontent.com/u/64924139?v=4" width=115><br><sub>Matheus T Lacerda</sub>](https://github.com/Matheustlacerda) |  [<img src="https://avatars.githubusercontent.com/u/42424774?v=4" width=115><br><sub>Marcos Antonio</sub>](https://github.com/marcosantonio0307) |  [<img src="https://avatars.githubusercontent.com/u/59203134?v=4" width=115><br><sub>Samuel Santos</sub>](https://github.com/batistasamuel) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |  :---: | 

### Iugu-Lite

| [<img src="https://avatars.githubusercontent.com/u/15835917?v=4" width=115><br><sub>Felipe Leal Trovo</sub>](https://github.com/FelipeLTrovo) |  [<img src="https://avatars.githubusercontent.com/u/26432843?v=4" width=115><br><sub>Gabriel Sugai</sub>](https://github.com/gabrielsugai) |  [<img src="https://avatars.githubusercontent.com/u/44443163?v=4" width=115><br><sub>Josue Costa</sub>](https://github.com/J-Costa) |  [<img src="https://avatars.githubusercontent.com/u/56566907?v=4" width=115><br><sub>Mauricio Oliveira</sub>](https://github.com/mau-os) |  [<img src="https://avatars.githubusercontent.com/u/14550093?v=4" width=115><br><sub>Andre Torres</sub>](https://github.com/andre-dan) |  [<img src="https://avatars.githubusercontent.com/u/67444676?v=4" width=115><br><sub>Leandro Couto</sub>](https://github.com/leandrohorizon) |  [<img src="https://avatars.githubusercontent.com/u/55258258?v=4" width=115><br><sub>Ana Beatriz Rodrigues</sub>](https://github.com/mntrrdrgs) |  [<img src="https://avatars.githubusercontent.com/u/77302037?v=4" width=115><br><sub>Lucas Yoiti</sub>](https://github.com/lucasy95) |  [<img src="https://avatars.githubusercontent.com/u/15333889?v=4" width=115><br><sub>Simone Abreu</sub>](https://github.com/siabreu) |  [<img src="https://avatars.githubusercontent.com/u/2307388?v=4" width=115><br><sub>Heitor Adão</sub>](https://github.com/heitoradao) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | 

### Mentoria, orientações e suporte

| [<img src="https://avatars.githubusercontent.com/u/441456?v=4" width=115><br><sub>João Almeida</sub>](https://github.com/joaorsalmeida) |  [<img src="https://avatars.githubusercontent.com/u/9326123?v=4" width=115><br><sub>Henrique Morato</sub>](https://github.com/gabrielsugai) | 
| :---: | :---: |
