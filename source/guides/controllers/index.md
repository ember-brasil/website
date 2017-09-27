## Controllers

Controllers comportam-se como um tipo específico de Component que é renderizado pelo
router quando entra em uma Route.

O Controller recebe uma unica propriedade da Route – `model` – que é
o valor de retorno do método `model` da Route.

Para criar um Controller, execute em seu terminal:

```shell
ember generate controller my-controller-name
```

O valor de `my-controller-name` deve corresponder ao nome da Route que o renderiza.
Então uma Route denominada `blog-post` teria um Controller correspondente chamado
`blog-post`.

Você só precisa gerar um Controller, se você quer customizar suas propriedades ou
fornecer quaisquer `actions`. Se você não tiver customizações, o Ember irá fornecer uma
instância do Controller para você em tempo de execução (run time).

Vamos explorar esses conceitos usando um exemplo de uma Route exibindo um post de blog.
Supondo que exista um model `BlogPost` que é exibido em um Template `blog-post`.

O model `BlogPost` teria propriedades como:

* `title`
* `intro`
* `body`
* `author`

Seu template deve vincular (bind) essas propriedades no template
de `blog-post`:

```app/templates/blog-post.hbs
<h1>{{model.title}}</h1>
<h2>by {{model.author}}</h2>

<div class="intro">
  {{model.intro}}
</div>
<hr>
<div class="body">
  {{model.body}}
</div>
```

Neste exemplo simples, ainda não temos nenhuma propriedade de exibição específica
ou actions. Por enquanto, a propriedade `model` do nosso Controller atua como uma
passagem (ou "proxy") para as propriedades do Model. (Lembre-se que um Controller
recebe o Model que ele representa a partir do seu gerenciador de rotas).

Digamos que nós queremos adicionar uma feature que permita que o usuário
alterne a exibição de uma div com class body. Para implementar isso, nós devemos
primeiro modificar nosso template para mostrar a div com class body somente se o
valor da propriedade `isExpanded` for true.

```app/templates/blog-post.hbs
<h1>{{model.title}}</h1>
<h2>by {{model.author}}</h2>

<div class='intro'>
  {{model.intro}}
</div>
<hr>

{{#if isExpanded}}
  <button {{action "toggleBody"}}>Hide Body</button>
  <div class="body">
    {{model.body}}
  </div>
{{else}}
  <button {{action "toggleBody"}}>Show Body</button>
{{/if}}
```

Você pode então definir o que a action faz dentro do hook de `actions`
do Controller, como você faria com um Component:

```app/controllers/blog-post.js
import Ember from 'ember';

export default Ember.Controller.extend({
  isExpanded: false,

  actions: {
    toggleBody() {
      this.toggleProperty('isExpanded');
    }
  }
});
```

### Dúvidas comuns

<div class="common-question">
  <h4>Eu deveria usar Controllers nas minhas aplicações Ember? Eu ouvi por aí que elas serão removidas!</h4>

  <p>Sim! Controllers ainda são parte integral da arquitetura de uma aplicação Ember, e são geradas pelo framework mesmo se você não declarar um módulo do Controller explicitamente.</p>
  <p>Para entender melhor, por favor, acompanhe <a href="https://github.com/emberjs/rfcs/pull/38" title="Routable Components RFC">essa RFC </a></p>
</div>
