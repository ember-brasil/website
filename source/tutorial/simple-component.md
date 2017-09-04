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
Agora, quando clicamos na imagem ou no link `View Larger` no nosso navegador, veremos a imagem amplicada.
Quando clicamos novamente na imagem ampliada, ela volta ao normal.

![rental listing with expand](../../images/simple-component/styled-rental-listings.png)

Agora você pode avançar para [próxima página](../hbs-helper/) para o próximo recurso ou continuar aqui para testar o que você acabou de fazer.

### Teste de integração

Os componentes no Ember são comumente testados com [component integration tests](../../testing/testing-components/).
Os testes de integração de componentes verificam o comportamento de um componente no contexto de renderização no Ember.
Quando executado em um teste de integração, o componente passa pelo [render lifecycle](../../components/the-component-lifecycle/) que tem acesso a objetos dependentes, carregados através do resolvedor do Ember.

Nosso teste de integração de componentes testará dois comportamentos diferentes:

* O componente deve mostrar detalhes sobre o aluguel
* O componente deve alternar a existência de uma classe `wide` e clicar, para expandir e diminuir a imagem do aluguel. 

Vamos atualizar o teste padrão para conter os cenários que queremos verificar:

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

Para fazer o teste, passamos para o componente de um objeto falso que possui todas as propriedades que nosso `model` de aluguel tem.
Daremos à variável o nome `rental`, e em cada teste definiremos `rental` para o nosso escopo local, representado pelo objeto `this`.
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
Agora vamos renderizar nosso componente usando a função `render`.
A função `render` nos permite passar uma string como template, para que possamos declarar o componente da mesma maneira que fazemos em nossos templates.
Como estabelecemos a variável `rentalObj` para o nosso escopo local, podemos acessá-la como parte de nossa renderização.

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

No primeiro teste, queremos verificar o resultado do componente, então vamos verificar se o título e o nome do proprietário são iguais ao do objetivo `rental` fake.

```tests/integration/components/rental-listing-test.js{+4,+5}
test('should display rental details', function(assert) {
  this.set('rentalObj', rental);
  this.render(hbs`{{rental-listing rental=rentalObj}}`);
  assert.equal(this.$('.listing h3').text(), 'test-title', 'Title: test-title');
  assert.equal(this.$('.listing .owner').text().trim(), 'Owner: test-owner', 'Owner: test-owner');
});
```
No segundo teste, verificamos que ao clicar na imagem mostra uma imagem ampliada.
Vamos verificar que o componente é inicializado sem o nome da classe `wide`.
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
Para encontrar o novo teste, localize "Integração | Componente | listagem de aluguel" no campo "Module" da UI do teste.

![simple_component_test](../../images/simple-component/simple-component-test.gif)
