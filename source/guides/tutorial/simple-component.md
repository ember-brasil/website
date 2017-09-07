À medida que nosso usuário navega em nossa lista de imoveis para alugar, eles podem querer ter algumas opções para interagir com os imoveis.
Para fazer isso, usaremos um component.

Vamos criar um component `rental-listing` que terá cada imóvel disponível para alugar.
É necessário um traço no nome do component para evitar conflitos com um possível elemento HTML, de modo que `rental-listing` é aceitável, mas o `rental` não é.

```shell
ember g component rental-listing
```

Ember CLI irá então gerar diversos arquivos para o nosso component:


```shell
installing component
  create app/components/rental-listing.js
  create app/templates/components/rental-listing.hbs
installing component-test
  create tests/integration/components/rental-listing-test.js
```

Um component é formado de duas partes:

* Um arquivo de template que define como ele vai ser visualmente (`app/templates/components/rental-listing.hbs`).
* Um arquivo de JavaScript (`app/components/rental-listing.js`) que define como ele vai se comportar.

Nosso novo component `rental-listing` vai listar nossos imoveis, definindo como será exibido para o usuário.
Para começar, vamos mover parte do código (detalhes do imóvel) em `rentals.hbs` para nosso component em `rental-listing.hbs`. Vamos aproveitar essa edição para adicionar uma imagem.

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

Agora, vamos editar nosso template `rentals.hbs` e substituir o detalhe do imóvel pela declaração do nosso component, dentro do `{{#each}}`.

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
Aqui, declaramos o component `rental-listing` e atribuímos `rentalUnit` como um atributo `rental` dentro do component.

Nossa aplicação deve se comportar agora como antes, porém agora terá uma imagem para cada imóvel.

![App with component and images](../../images/simple-component/app-with-images.png)

## Mostrar/Ocultar uma imagem

Agora que temos um component para cada imóvel, vamos adicionar funcionalidade para mostrar/ocultar uma imagem ampliada do imóvel quando o usuário clicar em `View Larger`.

Usaremos o helper `{{if}}` para mostrar a imagem ampliada do imóvel somente quando a propriedade `isWide` for `true`, se `true` a classe `wide` é adicionada ao elemento.
Vamos envolver a imagem e o texto em um elemento anchor com a classe `image` para que nosso teste possa encontra-lo mais tarde.

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
O valor de `isWide` deve ser definido no arquivo JavaScript do component em `app/component/rental-listing.js`.
Queremos que a imagem ampliada do imóvel seja mostrada somente quando o usuário solicitar, para isso vamos definir a propriedade como `false`.

```app/components/rental-listing.js{+4}
import Ember from 'ember';

export default Ember.Component.extend({
  isWide: false
});
```
Para que nosso usuário possa ampliar a imagem, precisamos criar uma `action` para trocar o valor da propriedade `isWide` e ampliar a imagem.
Vamos chamar essa `action` de `toggleImageSize`.

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
Quando nosso usuário clicar no elemento anchor, a `action` executará a função chamada `toggleImageSize`.

[Actions hash](../../templates/actions/) é um objeto de component que contém uma relação de funções.
Essas funções são chamadas quando o usuário interage com a interface do usuário, como clicar.

Vamos criar a função `toggleImageSize` e trocar o valor da propriedade `isWide` em nosso component:

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
Agora, quando nosso usuário clicar na imagem ou no link `View Larger` a imagem do imóvel será ampliada.
Quando o usuário clicar na imagem ampliada, ela voltará ao normal.

![rental listing with expand](../../images/simple-component/styled-rental-listings.png)

A partir desde ponto você pode avançar para a [próxima página](../hbs-helper/) ou você pode continuar e criar os testes do que foi feito.

### Teste de integração

Os components em Ember são comumente testados com [component integration tests](../../testing/testing-components/).
Os testes de integração de components verificam o comportamento de um components no contexto de renderização do Ember.
Quando executado em um teste de integração, o component passa pelo [render lifecycle](../../components/the-component-lifecycle/) que tem acesso a objetos dependentes, carregados através do `Ember Resolver`.

Nosso teste de integração de components testará dois comportamentos diferentes:

* O component deve mostrar detalhes do imóvel
* O component deve adicionar a classe `wide` ao clicar, para mostrar/ocultar a imagem ampliada do imóvel.

Vamos editar o teste padrão para conter os cenários que queremos testar:

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

Para fazer o teste, passamos para o component de um objeto falso que possui todas as propriedades que nosso `model` de imoveis tem.
Chamaremos à variável de `rental`, e em cada teste definiremos `rental` em nosso escopo local, representado pelo objeto `this`.
Podemos acessar informações através do escopo local `this`.


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

Agora vamos renderizar nosso component usando a função `render`.
A função `render` nos permite passar uma string como template, para que possamos declarar o component da mesma maneira que fazemos em nossos templates.
Como declaramos a variável `rentalObj` em nosso escopo local, podemos acessá-la como parte da nossa renderização.

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
Finalmente, vamos adicionar nossas ações e `asserts`.

No primeiro teste, queremos verificar o resultado do component, então vamos verificar se o título e o nome do proprietário são iguais ao do objeto `rental` fake.

```tests/integration/components/rental-listing-test.js{+4,+5}
test('should display rental details', function(assert) {
  this.set('rentalObj', rental);
  this.render(hbs`{{rental-listing rental=rentalObj}}`);
  assert.equal(this.$('.listing h3').text(), 'test-title', 'Title: test-title');
  assert.equal(this.$('.listing .owner').text().trim(), 'Owner: test-owner', 'Owner: test-owner');
});
```
No segundo teste, verificamos que ao clicar na imagem, deve mostrar uma imagem ampliada.
Vamos verificar se o component é inicializado sem o nome da classe `wide`.
Clicando na imagem, deve adicionar a classe `wide` ao nosso elemento, e clicando nela pela segunda vez deve remover a classe `wide`.
Observe que encontraremos o elemento da imagem usando o seletor CSS `.image`.

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
O teste final deve ser o seguinte:

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

Execute `ember t -s` para verificar se o nosso novo teste está passando.
Para encontrar o novo teste, localize "Integration | Components | rental-listing" no campo "Module" da UI do teste.

![simple_component_test](../../images/simple-component/simple-component-test.gif)
