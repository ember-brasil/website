[![Build Status](https://travis-ci.org/ember-brasil/website.svg?branch=master)](https://travis-ci.org/ember-brasil/website)

## Projeto de tradução da documentação do ember
> Projeto não oficial

Quer falar sobre o projeto? Estamos no Telegram. [Aqui](https://t.me/EmberBR).
<hr>

> Esta é uma tradução em Português do [Ember Guides](http://guides.emberjs.com). 

## Fique por dentro

A corrente tradução é iniciada por [Aurélio Saraiva](http://github.com/aureliosaraiva). A tradução é em caráter voluntário e tem como único objetivo disponibilizar à comunidade o conteúdo em português.

> Você concorda que:

* Ao contribuir com as traduções, você estará de acordo com a divulgação livre do conteúdo traduzido por você no GitHub. 
* O conteúdo __não__ pode ser disponibilizado fora deste ambiente sob qualquer forma, incluíndo sua venda/redistribuição.
* Todos os direitos são reservados ao Comunidade Ember.

## Entendi! Quero contribuir com a tradução, como eu faço?

Se você sabe inglês ou leu alguma parte já traduzida e achou algum erro, nós queremos nos juntar a você!

* [Aqui um guia incrível de como você pode nos ajudar](CONTRIBUTING.md)
* [Dúvidas com o projeto? Estamos no Telegram](https://t.me/EmberBR)

> "Comece de onde você está. Use o que você tiver. Faça o que você puder" – Arthur Ashe

## Sincronizando seu fork
Para sincronizar seu repositório (fork), siga essas instruções: 
https://help.github.com/articles/syncing-a-fork/

## Executando o site

### Dependências

O site é criado com Middleman e executado em Ruby 1.9.3 or newer (2.0.0 recommended).

Os usuários de Mac devem instalar Ruby usando rbenv:

```
brew install rbenv
```
Siga as [instruções de instalação do rbenv](https://github.com/rbenv/rbenv) para instalar a versão do Ruby especificada [aqui](.Ruby-version).

Depois de instalar o Ruby, você precisará do `bundler` e do Middleman:

```
gem install bundler middleman
```

Após a instalação do ambiente, você pode iniciar o projeto:

``` sh
git clone git://github.com/ember-brasil/website.git
cd website
bundle
bundle exec middleman
```

Então acesse [http://localhost:4567/](http://localhost:4567/).

## Rodando com Docker

Para rodar com o Docker você precisa ter Docker e Docker Compose instalado na maquina.
Siga essas instruções para instalar o docker e docker-compose: 
- https://docs.docker.com/engine/installation/
- https://docs.docker.com/compose/install/


``` sh
git clone git://github.com/ember-brasil/website.git
cd website
docker-compose up
```


