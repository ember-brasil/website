Até agora, nossa aplicação está mostrando diretamente para o usuário os dados do Ember Data models.
À medida que nossa aplicação cresce, precisaremos manipular os dados antes de mostrar para nossos usuários.
Por esta razão, o Ember oferece templates helpers para personalizar os dados em nossos templates.
Vamos usar um template helper para permitir que nossos usuários vejam rapidamente se um imóvel é "Standalone" ou parte de uma "Community".

Para começar, vamos gerar um helper chamado `rental-property-type`:

```shell
ember g helper rental-property-type
```
Isso vai criar dois arquivos, nosso helper e seu teste relacionado:

```shell
installing helper
  create app/helpers/rental-property-type.js
installing helper-test
  create tests/integration/helpers/rental-property-type-test.js
```
Nosso novo helper foi criado com um código inicial bem simples pelo nosso gerador:

```app/helpers/rental-property-type.js
import Ember from 'ember';

export function rentalPropertyType(params/*, hash*/) {
  return params;
}

export default Ember.Helper.helper(rentalPropertyType);
```
Vamos atualizar o template do nosso component `rental-listing` para usar nosso helper e passar `rental.propertyType` como parâmetro:

```app/templates/components/rental-listing.hbs{-11,+12,+13}
<article class="listing">
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
    <span>Type:</span> {{rental-property-type rental.propertyType}}
      - {{rental.propertyType}}
  </div>
  <div class="detail location">
    <span>Location:</span> {{rental.city}}
  </div>
  <div class="detail bedrooms">
    <span>Number of bedrooms:</span> {{rental.bedrooms}}
  </div>
</article>
```
Idealmente, veremos "Type: Standalone - Estate" em nosso primeiro imóvel.
Em vez disso, nosso template helper está retornando o valor de `rental.propertyType`.
Vamos atualizar o nosso helper para verificar se existe uma propriedade em uma matriz de `communityPropertyTypes`. Se assim então, retornaremos `Community` ou `Standalone`:

```app/helpers/rental-property-type.js
import Ember from 'ember';

const communityPropertyTypes = [
  'Condo',
  'Townhouse',
  'Apartment'
];

export function rentalPropertyType([propertyType]) {
  if (communityPropertyTypes.includes(propertyType)) {
    return 'Community';
  }

  return 'Standalone';
}

export default Ember.Helper.helper(rentalPropertyType);
```

Cada [argument](https://guides.emberjs.com/v2.12.0/templates/writing-helpers/#toc_helper-arguments) no helper será adicionado a uma matriz e passado para o nosso helper. Por exemplo, `{{my-helper "foo" "bar"}}` retornará `myHelper(["foo", "bar"])`. Usando array assignment [ES2015 desestruturação](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment), podemos nomear os parâmetros dentro do array. No exemplo acima, o primeiro argumento no template será atribuído a `propertyType`. Isso fornece uma interface flexível e expressiva para nossos helpers, incluindo argumentos opcionais e valores padrões.

Agora, em nosso navegador, devemos ver que o primeiro imóvel para alugar é "Standalone", enquanto as outros dois estão listados como "Community".


### Teste de integração

Atualize o conteúdo do teste de integração dessa forma para corrigi-lo:

```/tests/integration/helpers/rental-property-type-test.js{-15,+16}

import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('rental-property-type', 'helper:rental-property-type', {
  integration: true
});

// Replace this with your real tests.
test('it renders', function(assert) {
  this.set('inputValue', '1234');

  this.render(hbs`{{rental-property-type inputValue}}`);

  assert.equal(this.$().text().trim(), '1234');
  assert.equal(this.$().text().trim(), 'Standalone');
});

```
