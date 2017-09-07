Antes de começar a escrever sua aplicação Ember, é muito importante ter uma visão geral de como funciona.

![ember core concepts](../../images/ember-core-concepts/ember-core-concepts.png)

## Gerenciamento de Rotas (Router)
Imagine que estamos escrevendo uma aplicação web para um site que permite o usuário listar seus imóveis para alugar.
A qualquer momento, devemos ser capazes de responder a perguntas sobre o estado atual, como _que imóvel o usuário está visualizando?_ e _o usuário está editando o imóvel?_ Em Ember, a resposta dessas perguntas é determinada pela URL.
A URL pode ser definida de algumas maneiras:


* O usuário carrega a aplicação pela primeira vez.
* O usuário altera a URL manualmente, por exemplo clicando no botão voltar ou editando a barra de endereços.
* O usuário clica em um botão ou link dentro da aplicação.
* Algum outro evento na aplicação que faz mudar a URL.

Não importa como a URL foi definida, a primeira coisa que acontece é que o router do Ember mapeia a URL para um gerenciador de rotas.

O gerenciador de rotas normalmente faz duas coisas:

* Ele renderiza um template.
* Ele carrega um model que estará disponível no template.

## Templates

Ember usa templates para organizar o layout HTML da aplicação.

A maioria das templates em um projeto Ember são familiares e se parecem com qualquer fragmento de HTML. Por exemplo:

```handlebars
<div>Hi, this is a valid Ember template!</div>
```

Os templates Ember usam a sintaxe do [Handlebars](http://handlebarsjs.com).
Toda sintaxe do Handlebars é aceita no Ember.

Templates também podem exibir as propriedades fornecidas a eles através de seu contexto, que podem ser tanto um component ou quanto um controller. Por exemplo:

```handlebars
<div>Hi {{name}}, this is a valid Ember template!</div>
```

Aqui, `{{name}}` é uma propriedade proveniente do contexto do template.

Além de propriedades, chaves duplas (`{{}}`) podem conter também
helpers e components, que discutiremos mais tarde.

## Models

Models representam um estado persistente.

Por exemplo, uma aplicação de aluguel de imóveis irá querer salvar os detalhes de uma locação quando um usuário publicá-lo e então uma locação teria um model definindo seus detalhes, talvez chamando o model de _rental_.

Um model normalmente persiste informações para um servidor web, apesar dos models poderem ser configurados para salvar em qualquer outro lugar, como no armazenamento local do navegador (Local Storage).

## Components

Enquanto os templates descrevem a aparência de uma interface de usuário, os components controlam como a interface se _comporta_.

Componentes consistem em duas partes: um template escrito em Handlebars e um conjunto de código escrito em JavaScript que define o seu comportamento.
Por exemplo, nossa aplicação de aluguel de imóveis pode ter um component para exibir todas as locações chamado de `all-rentals` e outro component para exibir uma locação individual chamado de `rental-tile`.
O component `rental-tile` pode definir um comportamento que permite ao usuário ocultar e mostrar a imagem do imóvel.

Vamos ver estes conceitos básicos em ação através da construção de uma aplicação de aluguel de imóveis na próxima lição.
