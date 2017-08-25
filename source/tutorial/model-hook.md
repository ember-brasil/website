Agora, vamos adicionar uma lista de aluguéis disponíveis para a página inicial que acabamos de criar.

Ember mantém os dados para uma página em um objeto chamado `model`.
Para manter as coisas simples em primeiro lugar, vamos preencher o `model` com informações fixas para construir a listagem de aluguéis.

Mais tarde vamos voltar e alterar esses dados para usar [Ember Data](https://github.com/emberjs/data), uma biblioteca robusta para manipular os dados em nosso aplicativo.

Essa será nossa página inicial quando terminarmos:

![super rentals homepage with rentals list](../../images/model-hook/super-rentals-index-with-list.png)

Em Ember, os manipuladores de routes são responsáveis por carregar o template com os dados na página.
Ele carrega os dados em uma função chamada [`model`](http://emberjs.com/api/classes/Ember.Route.html#method_model).
A função `model` atua como **hook**, o que significa que o Ember vai chamá-lo para nós durante diferentes etapas de execução em nosso aplicativo.
A função `model` que adicionamos ao nosso manipulador de routes `rentals` será chamada quando um usuário visitar a URL `http://localhost:4200` ou `http://localhost:4200/rentals`.

Vamos abrir `app/routes/rentals.js` e retornar uma série de objetos de aluguel na função` model`:

```app/routes/rentals.js{+4,+5,+6,+7,+8,+9,+10,+11,+12,+13,+14,+15,+16,+17,+18,+19,+20,+21,+22,+23,+24,+25,+26,+27,+28,+29,+30,+31,+32,+33,+34,+35}
import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return [{
      id: 'grand-old-mansion',
      title: 'Grand Old Mansion',
      owner: 'Veruca Salt',
      city: 'San Francisco',
      propertyType: 'Estate',
      bedrooms: 15,
      image: 'https://upload.wikimedia.org/wikipedia/commons/c/cb/Crane_estate_(5).jpg',
      description: 'This grand old mansion sits on over 100 acres of rolling hills and dense redwood forests.'
    }, {
      id: 'urban-living',
      title: 'Urban Living',
      owner: 'Mike TV',
      city: 'Seattle',
      propertyType: 'Condo',
      bedrooms: 1,
      image: 'https://upload.wikimedia.org/wikipedia/commons/0/0e/Alfonso_13_Highrise_Tegucigalpa.jpg',
      description: 'A commuters dream. This rental is within walking distance of 2 bus stops and the Metro.'

    }, {
      id: 'downtown-charm',
      title: 'Downtown Charm',
      owner: 'Violet Beauregarde',
      city: 'Portland',
      propertyType: 'Apartment',
      bedrooms: 3,
      image: 'https://upload.wikimedia.org/wikipedia/commons/f/f7/Wheeldon_Apartment_Building_-_Portland_Oregon.jpg',
      description: 'Convenience is at your doorstep with this charming downtown rental. Great restaurants and active night life are within a few feet.'

    }];
  }
});
```
Observe que, aqui, estamos usando a sintaxe de definição do método de abreviaturas ES6: `model()` é o mesmo que escrever `model: function ()`.

Ember usará o objeto model retornado acima e salvá-lo como um atributo chamado `model`, disponível para o template de aluguel que geramos com nossa route em [Routes and Templates](../routes-and-templates/#toc_a-rentals-route).

Agora, vamos alterar nosso template da página de aluguel.
Podemos usar o atributo do model para exibir nossa lista de aluguel.
Aqui, usaremos um outro Helper do Handlebars chamado [`{{each}}`](../../templates/displaying-a-list-of-items/).
Este helper nos deixará percorrer todos os items do nosso array de alugueís em nosso tempate:

```app/templates/rentals.hbs{+12,+13,+14,+15,+16,+17,+18,+19,+20,+21,+22,+23,+24,+25,+26,+27,+28,+29}
<div class="jumbo">
  <div class="right tomster"></div>
  <h2>Welcome!</h2>
  <p>
    We hope you find exactly what you're looking for in a place to stay.
  </p>
  {{#link-to 'about' class="button"}}
    About Us
  {{/link-to}}
</div>

{{#each model as |rental|}}
  <article class="listing">
    <h3>{{rental.title}}</h3>
    <div class="detail owner">
      <span>Owner:</span> {{rental.owner}}
    </div>
    <div class="detail type">
      <span>Type:</span> {{rental.propertyType}}
    </div>
    <div class="detail location">
      <span>Location:</span> {{rental.city}}
    </div>
    <div class="detail bedrooms">
      <span>Number of bedrooms:</span> {{rental.bedrooms}}
    </div>
  </article>
{{/each}}
```
Neste template, fazemos um loop em cada objeto.
Em cada iteração, o objeto atual é armazenado em uma variável chamada `rental`.
A partir da variável `rental` em cada etapa, criamos uma listagem com as informações sobre o imovel.

Você pode passar para a [próxima página](../install-addons/) para continuar implementando novos recursos ou continuar e implementar os testes de aceitação.

### Acceptance Testing the Rental List

To check that rentals are listed with an automated test, we will create a test to visit the index route and check that the results show 3 listings.

In `app/templates/rentals.hbs`, we wrapped each rental display in an `article` element, and gave it a class called `listing`.
We will use the listing class to find out how many rentals are shown on the page.

To find the elements that have a class called `listing`, we'll use a test helper called [find](http://emberjs.com/api/classes/Ember.Test.html#method_find).
The `find` function returns the elements that match the given [CSS selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors).
In this case it will return an array of all the elements with a class called `listing`.

```/tests/acceptance/list-rentals-test.js{+2,+3,+4,+5}
test('should list available rentals.', function (assert) {
  visit('/');
  andThen(function() {
    assert.equal(find('.listing').length, 3, 'should see 3 listings');
  });
});
```

Run the tests again using the command `ember t -s`, and toggle "Hide passed tests" to show your new passing test.

Now we are listing rentals, and and verifying it with an acceptance test.
This leaves us with 2 remaining acceptance test failures (and 1 eslint failure):

![list rentals test passing](../../images/model-hook/model-hook.png)
