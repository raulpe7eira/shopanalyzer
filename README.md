# Shopanalyzer (vlab for [http://nexaas.com/](http://nexaas.com/))

Um pequeno projeto para testar minhas habilidades.

![frontend-scshot](../master/scshot/frontend-scshot.png)

## Desafio

> ...
>
> Construir um sistema que possa receber um arquivo texto com os dados de vendas da empresa. Será preciso criar a maneira que os dados são importados para um banco de dados. Sua tarefa é criar uma interface web que aceite upload de arquivos, normalize os dados e armazene-os. A aplicação deve:
>
> - [X] Aceitar (via um formulário) o upload de arquivos text, com dados separados por TAB testar o aplicativo usando o arquivo fornecido. A primeira linha do arquivo tem o nome das colunas. Você pode assumir que as colunas estarão sempre nesta ordem, e que sempre haverá uma linha de cabeçalho. Um arquivo de exemplo chamado [data.txt](../master/spec/fixtures/files/data.txt) está incluído neste repositório.
> - [X] Interpretar ("parsear") o arquivo recebido, normalizar os dados, e salvar corretamente a informação em um banco de dados relacional.
> - [ ] Exibir todos os registros importados, bem como a receita bruta total dos registros contidos no arquivo enviado após o upload + parser. (**Faltou exibir a receita bruta total**) :disappointed_relieved:
> - [ ] Ser escrita obrigatoriamente em Ruby 2.1+ Rails 4 e SQLite (**Feito c/ [Rails 5.0.2](http://weblog.rubyonrails.org/2017/3/1/Rails-5-0-2-has-been-released/)**) :disappointed_relieved:
> - [X] Ser simples de configurar e rodar a partir das instruções fornecidas, funcionando em ambiente compatível com Unix (Linux ou Mac OS X) para Ruby On Rails e Windows para .Net. Ela deve utilizar apenas linguagens e bibliotecas livres ou gratuitas.
> - [X] Ter um teste de model e controller automatizado para a funcionalidade pedida.
> - [X] Ter uma boa aparência e ser fácil de usar.
>
> ...

## Solução

### Instalação

#### Pré-requisitos

Ter instalado localmente (apenas p/ Desenvolvimento e Teste):
- [Git](https://git-scm.com/)
- [Ruby](https://ruby-lang.org)
- [Bundle](http://bundler.io/)
- [RubyGems](https://rubygems.org/)
- [Rake](https://github.com/ruby/rake)
- [Rails](http://rubyonrails.org/)

#### Instalando dependências

```bash
$ git clone https://github.com/raulpereira/shopanalyzer.git
$ cd shopanalyzer
$ bundle install --without production
```

### Subir & Rodar

#### Ambiente de desenvolvimento

```bash
$ bin/rails db:environment:set RAILS_ENV=development
$ rake db:migrate RAILS_ENV=development
$ rails s
```
![dsv-scshot](../master/scshot/dsv-scshot.png)

#### Ambiente de teste

```bash
$ bin/rails db:environment:set RAILS_ENV=test
$ rake db:migrate RAILS_ENV=test
$ rspec .
```
![tst-scshot](../master/scshot/tst-scshot.png)

#### Ambiente de produção

Acesse => *[https://shopanalyzer-rp.herokuapp.com/](https://shopanalyzer-rp.herokuapp.com/)* :clap:

### Considerações

#### Plataforma

**[Rails](http://rubyonrails.org/)**: Foi uma escolha determinada pelo desafio, decidi encarar pois essa plataforma faz parte dos meus estudos atuais.

#### Backend

##### Web Server

**[Puma.io](http://puma.io/)**: É a escolha padrão da plataforma, na versão utilizada ([5.0.2](http://weblog.rubyonrails.org/2017/3/1/Rails-5-0-2-has-been-released/)), além de ser indicado pelo local que será hospedado em produção.

##### Banco de dados

**[SQLite](https://sqlite.org/)**: Utilizado por já vir embarcado na plataforma e facilitar o desenvolvimento local. 

**[PostgreSQL](https://www.postgresql.org/)**: Escolhido por ser indicado pelo local que será hospedado em produção.

##### Segurança

**[Devise](https://github.com/plataformatec/devise)**: Foi utilizado esta biblioteca de módulos para solucionar questões de segurança aos serviços que a aplicação possui. Hoje a aplicação permite o cadastro de novos usuários e apenas o usuário autenticado pode acessar os seus registros cadastrados por ele na aplicação.

#### Frontend

**[HTML](https://w3.org/html/)** + **[CSS](https://w3.org/Style/CSS/)** (c/ **[Bootstrap](http://getbootstrap.com/)**) + **[JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript)** (c/ **[CoffeeScript](http://coffeescript.org/)** + **[jQuery](https://jquery.com/)**): Não usei nenhuma plataforma para implementar esta camada, apenas bibliotecas facilitadoras.

#### Testes

**[RSpec](http://rspec.info/)**: Toda a estrutura do modelo e controle foi coberta - backend, ficou pendente realizar os testes para os helpers e os cenários das features - frontend. A finalização de todos os testes é mais do que necessário para orquestrar todo processo de implantação em ambiente de produção com mais segurança.

#### Servidores de produção

**[Heroku](https://heroku.com)** (PAAS): Escolhido por ter suporte grátis para aplicações [Rails](http://rubyonrails.org/), além de ter uma boa integração com o [GitHub](https://github.com/).

## Conclusão

Mais um desafio usando [Rails](http://rubyonrails.org/), fiquei feliz com o resultado final, a solução esta bem funcional, porém, precisava de um pouco mais de tempo para averiguar toda parte de segurança relativa a manipulação do arquivo enviado tirando isso, faltou efetuar os testes do frontend, enfim, entrou no backlog de melhorias para próxima versão.

**AVANTE!** :muscle:
