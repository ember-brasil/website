À medida que um usuário navega em nossa lista de aluguéis, eles podem querer ter algumas opções interativas para ajudá-los a tomar uma decisão.
Para fazer isso, usaremos um componente.

Vamos criar um componente de `rental-listing` que gerenciará o comportamento de cada um dos nossos aluguéis.
É necessário um traço em cada nome do componente para evitar conflitos com um possível elemento HTML, de modo que `rental-listing` é aceitável, mas o `rental` não é.

```shell
ember g component rental-listing
```

Ember CLI irá então gerar diversos arquivos para o nosso componente:


```shell
installing component
  create app/components/rental-listing.js
  create app/templates/components/rental-listing.hbs
installing component-test
  create tests/integration/components/rental-listing-test.js
```

Um componente consiste em duas partes:

* Um arquivo de template que define como ele vai ser ser visualmente (`app/templates/components/rental-listing.hbs`).
* Um arquivo de JavaScript (`app/components/rental-listing.js`) que define como ele vai se comportar.

Nosso novo componente `rental-listing` gerenciará como um usuário vê e interage com um aluguel.
Para começar, vamos mover os detalhes de exibição do aluguel para um único de aluguel em `rentals.hbs` para` rental-listing.hbs` e já vamos adicionar a TAG de imagem:

```app/templates/components/rental-listing.hbs{-1,+2,+3,+4,+5,+6,+7,+8,+9,+10,+11,+12,+13,+14,+15,+16,+17}
{{yield}}
<article class="listing">
  <img src="{{rental.image}}" alt="">
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
```

Agora, no nosso template `rentals.hbs`, substituamos a marcação HTML antiga do loop `{{#each}}` com nosso novo componente `rental-listing`:

```app/templates/rentals.hbs{+12,+13,-14,-15,-16,-17,-18,-19,-20,-21,-22,-23,-24,-25,-26,-27,-28,-29}
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

{{#each model as |rentalUnit|}}
  {{rental-listing rental=rentalUnit}}
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
Aqui, invocamos o componente `rental-listing` e atribuímos cada `rentalUnit` como o um atributo `rental` do componente.

Nosso aplicativo deve se comportar agora como antes, com a adição de uma imagem para cada item de aluguel.

![App with component and images](../../images/simple-component/app-with-images.png)

## Escondendo e mostrando a imagem

Agora, podemos adicionar funcionalidades que msotra a imagem de um aluguel quando solicitado pelo usuário.

Vamos usar o helper `{{if}}` para mostrar nossa imagem de aluguel atual maior somente quando `isWide` estiver definido como verdadeiro, definindo o nome da classe do elemento para` wide`.
Também adicionaremos algum texto para indicar que a imagem pode ser clicada, e envolver os dois com um elemento de anchor, dando-lhe o nome da classe `image` para que nosso teste possa encontrá-lo.


```app/templates/components/rental-listing.hbs{+2,+4,+5}
<article class="listing">
  <a class="image {{if isWide "wide"}}">
    <img src="{{rental.image}}" alt="">
    <small>View Larger</small>
  </a>
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
```
O valor de `isWide` vem do arquivo JavaScript do nosso componente, neste caso `rental-listing.js`.
Como queremos que a imagem seja menor no início, definiremos a propriedade para começar como `false`:

```app/components/rental-listing.js{+4}
import Ember from 'ember';

export default Ember.Component.extend({
  isWide: false
});
```

Para permitir que o usuário aumente a imagem, precisamos adicionar uma ação que altere o valor de `isWide`.
Vamos chamar essa ação `toggleImageSize`.

```app/templates/components/rental-listing.hbs{-2,+3}
<article class="listing">
  <a class="image {{if isWide "wide"}}">
  <a {{action 'toggleImageSize'}} class="image {{if isWide "wide"}}">
    <img src="{{rental.image}}" alt="">
    <small>View Larger</small>
  </a>
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
```
Ao clicar no elemento anchor, a ação será enviada para o componente.
Ember entrará no hash `actions` e chamará a função `toggleImageSize`.

Uma [actions hash](../../templates/actions/) é um objeto de componente que contém funções.
Essas funções são chamadas quando o usuário interage com a interface do usuário, como clicar.

Vamos criar a função `toggleImageSize` e alternar a propriedade `isWide` em nosso componente:

```app/components/rental-listing.js{-4,+5,+6,+7,+8,+9,+10}
import Ember from 'ember';

export default Ember.Component.extend({
  isWide: false
  isWide: false,
  actions: {
    toggleImageSize() {
      this.toggleProperty('isWide');
    }
  }
});
```


Now when we click the image or the `View Larger` link in our browser, we  see our image show larger.
When we click the enlarged image again, we see it smaller.

![rental listing with expand](../../images/simple-component/styled-rental-listings.png)

Move on to the [next page](../hbs-helper/) for the next feature, or continue on here to test what you just wrote.

### An Integration Test

Ember components are commonly tested with [component integration tests](../../testing/testing-components/).
Component integration tests verify the behavior of a component within the context of Ember's rendering engine.
When running in an integration test, the component goes through its regular [render lifecycle](../../components/the-component-lifecycle/),
and has access to dependent objects, loaded through Ember's resolver.

Our component integration test will test two different behaviors:

* The component should show details about the rental
* The component should toggle the existence of a wide class on click, to expand and shrink the photo of the rental.

Let's update the default test to contain the scenarios we want to verify:

```tests/integration/components/rental-listing-test.js{+3,+9,+10,+11,+12,+13,+14,+15,-16,-17,-18,-19,-20,-21,-22,-23,-24,-25,-26,-27,-28,-29,-30,-31,-32,-33}
import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import Ember from 'ember';

moduleForComponent('rental-listing', 'Integration | Component | rental listing', {
  integration: true
});

test('should display rental details', function(assert) {

});

test('should toggle wide class on click', function(assert) {

});
test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{rental-listing}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#rental-listing}}
      template block text
    {{/rental-listing}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
```

For the test we'll pass the component a fake object that has all the properties that our rental model has.
We'll give the variable the name `rental`, and in each test we'll set `rental` to our local scope, represented by the `this` object.
The render template can access values in local scope.

```tests/integration/components/rental-listing-test.js{+5,+6,+7,+8,+9,+10,+11,+12,+19,+23}
import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import Ember from 'ember';

let rental = Ember.Object.create({
  image: 'fake.png',
  title: 'test-title',
  owner: 'test-owner',
  propertyType: 'test-type',
  city: 'test-city',
  bedrooms: 3
});

moduleForComponent('rental-listing', 'Integration | Component | rental listing', {
  integration: true
});

test('should display rental details', function(assert) {
  this.set('rentalObj', rental);
});

test('should toggle wide class on click', function(assert) {
  this.set('rentalObj', rental);
});
```

Now let's render our component using the `render` function.
The `render` function allows us to pass a template string, so that we can declare the component in the same way we do in our templates.
Since we set the `rentalObj` variable to our local scope, we can access it as part of our render string.

```tests/integration/components/rental-listing-test.js{+20,+25}
import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import Ember from 'ember';

let rental = Ember.Object.create({
  image: 'fake.png',
  title: 'test-title',
  owner: 'test-owner',
  propertyType: 'test-type',
  city: 'test-city',
  bedrooms: 3
});

moduleForComponent('rental-listing', 'Integration | Component | rental listing', {
  integration: true
});

test('should display rental details', function(assert) {
  this.set('rentalObj', rental);
  this.render(hbs`{{rental-listing rental=rentalObj}}`);
});

test('should toggle wide class on click', function(assert) {
  this.set('rentalObj', rental);
  this.render(hbs`{{rental-listing rental=rentalObj}}`);
});
```

Finally, let's add our actions and assertions.

In the first test, we just want to verify the output of the component, so we just assert that the title and owner text match what we provided in the fake `rental`.

```tests/integration/components/rental-listing-test.js{+4,+5}
test('should display rental details', function(assert) {
  this.set('rentalObj', rental);
  this.render(hbs`{{rental-listing rental=rentalObj}}`);
  assert.equal(this.$('.listing h3').text(), 'test-title', 'Title: test-title');
  assert.equal(this.$('.listing .owner').text().trim(), 'Owner: test-owner', 'Owner: test-owner');
});
```
In the second test, we verify that clicking on the image toggles the size.
We will assert that the component is initially rendered without the `wide` class name.
Clicking the image will add the class `wide` to our element, and clicking it a second time will take the `wide` class away.
Note that we find the image element using the CSS selector `.image`.

```tests/integration/components/rental-listing-test.js{+4,+5,+6,+7,+8}
test('should toggle wide class on click', function(assert) {
  this.set('rentalObj', rental);
  this.render(hbs`{{rental-listing rental=rentalObj}}`);
  assert.equal(this.$('.image.wide').length, 0, 'initially rendered small');
  Ember.run(() => document.querySelector('.image').click());
  assert.equal(this.$('.image.wide').length, 1, 'rendered wide after click');
  Ember.run(() => document.querySelector('.image').click());
  assert.equal(this.$('.image.wide').length, 0, 'rendered small after second click');
});
```
The final test should look as follows:

```tests/integration/components/rental-listing-test.js
import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import Ember from 'ember';

let rental = Ember.Object.create({
  image: 'fake.png',
  title: 'test-title',
  owner: 'test-owner',
  propertyType: 'test-type',
  city: 'test-city',
  bedrooms: 3
});

moduleForComponent('rental-listing', 'Integration | Component | rental listing', {
  integration: true
});

test('should display rental details', function(assert) {
  this.set('rentalObj', rental);
  this.render(hbs`{{rental-listing rental=rentalObj}}`);
  assert.equal(this.$('.listing h3').text(), 'test-title', 'Title: test-title');
  assert.equal(this.$('.listing .owner').text().trim(), 'Owner: test-owner', 'Owner: test-owner')
});

test('should toggle wide class on click', function(assert) {
  this.set('rentalObj', rental);
  this.render(hbs`{{rental-listing rental=rentalObj}}`);
  assert.equal(this.$('.image.wide').length, 0, 'initially rendered small');
  Ember.run(() => document.querySelector('.image').click());
  assert.equal(this.$('.image.wide').length, 1, 'rendered wide after click');
  Ember.run(() => document.querySelector('.image').click());
  assert.equal(this.$('.image.wide').length, 0, 'rendered small after second click');
});
```

Run `ember t -s` to verify that our new test is passing.
To find the new test, locate "Integration | Component | rental listing" in the "Module" field of the test UI.

![simple_component_test](../../images/simple-component/simple-component-test.gif)
