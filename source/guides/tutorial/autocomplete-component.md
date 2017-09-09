Quando nossos usuários estão procurando um imóvel, eles precisam filtrar a pesquisa por uma cidade especifica, por exemplo.
Nosso [primeiro component](../simple-component/) `rental-listing` apenas mostrava informações sobre o o imóvel, esse novo componente vai permitir que nosso usuário consiga filtrar os imóveis por critérios.

Para começar, vamos gerar o nosso novo component.
Chamaremos esse component de `list-filter`, já que tudo o que precisamos é que ele filtre os imóveis disponivel.

```shell
ember g component list-filter
```

Assim como o component [`rental-listing` component](../simple-component), o comando "generate component" vai criar:

* um arquivo de template (`app/templates/components/list-filter.hbs`),
* um arquivo JavaScript (`app/templates/components/list-filter.hbs`),
* and um arquivo contendo o teste de integração (`tests/integration/components/list-filter-test.js`).

#### Atualizando as declarações de componente

Vamos adicionar nosso component `list-filter` em nosso arquivo `app/templates/rentals.hbs`.

Observe que vamos envolver nossa listagem de imóveis dentro do component `list-filter`, nas linhas 12 e 20.
Esse é um exemplo de [**block form**](../../components/wrapping-content-in-a-component), que permite que os template Handlebars seja renderizado _inside_, dentro do component `list-filter` na expressão `{{yield}}`.

Neste caso, estamos passando (`yielding`), o resultado do nosso filtro para dentro da marcação interna, através da variável `rentals` (linha 14).


```app/templates/rentals.hbs{+12,+13,+14,+15,+16,+17,+18,+19,+20,-21,-22,-23}
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

{{#list-filter
   filter=(action 'filterByCity')
   as |rentals|}}
  <ul class="results">
    {{#each rentals as |rentalUnit|}}
      <li>{{rental-listing rental=rentalUnit}}</li>
    {{/each}}
  </ul>
{{/list-filter}}
{{#each model as |rentalUnit|}}
  {{rental-listing rental=rentalUnit}}
{{/each}}
```

#### Adicionando um input ao component

Queremos que o component simplesmente tenha um campo (input) e envie o resultado para a expressão `{{yield}}`.

```app/templates/components/list-filter.hbs
{{input value=value
        key-up=(action 'handleFilterEntry')
        class="light"
        placeholder="Filter By City"}}
{{yield results}}
```
Observer que nosso template agora possui um novo tipo de helper [`{{input}}`](../../templates/input-helpers), ele funciona como um campo de texto, no qual nosso usuário poderá digitar uma cidade e filtrar o resultado de imóveis.
A propriedade `value` do` input` será sincronizada com a propriedade `value` do component.

Outra maneira de dizer isso é que a propriedade `value` do `input` é [**bound**](../../object-model/bindings/) com a propriedade `value` do compenent.

A propriedade `key-up` será vinculada à ação` handleFilterEntry`.

Aqui está como nosso código JavaScript do component deve ficar:

```app/components/list-filter.js
import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['list-filter'],
  value: '',

  init() {
    this._super(...arguments);
    this.get('filter')('').then((results) => this.set('results', results));
  },

  actions: {
    handleFilterEntry() {
      let filterInputValue = this.get('value');
      let filterAction = this.get('filter');
      filterAction(filterInputValue).then((filterResults) => this.set('results', filterResults));
    }
  }

});
```

#### Filtrando os dados

No exemplo acima, usamos o hook `init` para criar nossas lista de imóveis iniciais ao chamar a função `filter` com um valor vazio.
Nossa action `handleFilterEntry` chama uma função chamada `filter` com base no valor do atributo `value`.

A função `filter` foi passada como objeto. Este é um padrão conhecido como [closure actions](../../components/triggering-changes-with-actions/#toc_passing-the-action-to-the-component).

Observe a função `then` chamada no resultado da função `filter`.
O código espera que a função `filter` responda uma promessa.
Uma [promise](http://emberjs.com/api/classes/RSVP.Promise.html) é um objeto JavaScript que representa o resultado de uma função assíncrona.
Uma promise pode ou não ser executada no momento em que você a declara.
Em nosso exemplo, fornecemos a função `then` que permite que seja executado somente quando na promise finalizar de processar o resultado.

Para implementar a função `filter` para fazer a filtragem dos imóveis de acordo com a cidade, criaremos um controller chamado `rental`.
[Controllers](../../controllers/) contêm ações e propriedades disponiveis para nosso template.
Como Ember trabalha por conveção, ele saberá que um controller chamado `rental` coresponde a uma route com o mesmo nome.

Crie um controller para a route `rental` executando o seguinte:


```shell
ember g controller rentals
```
Agora, podemos adicionar a action `filterByCity` ao controller:

```app/controllers/rentals.js
import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    filterByCity(param) {
      if (param !== '') {
        return this.get('store').query('rental', { city: param });
      } else {
        return this.get('store').findAll('rental');
      }
    }
  }
});
```

Quando o usuário digitar no campo de texto em nosso component, a action `filterByCity` no controller será chamada.
Essa action aceita a propriedade `value` e filtra os dados de `rental`  de acordo com a cidade que o usuário digitou.
O resultado da consulta é retornado para quem o chamou.

#### Simulando um resultado

Para que esta action funcione, precisamos substituir no arquivo `config.js` no Mirage com o seguinte, para que ele possa devolver o resultado de acordo com nossa consulta.
Em vez de simplesmente retornar a lista de imóveis, nosso manipulador Mirage HTTP GET `rentals` retornará os imóveis correspondente à string fornecida no parâmetro `city` na URL.

```mirage/config.js
export default function() {
  this.namespace = '/api';

  let rentals = [{
      type: 'rentals',
      id: 'grand-old-mansion',
      attributes: {
        title: 'Grand Old Mansion',
        owner: 'Veruca Salt',
        city: 'San Francisco',
        "property-type": 'Estate',
        bedrooms: 15,
        image: 'https://upload.wikimedia.org/wikipedia/commons/c/cb/Crane_estate_(5).jpg',
        description: "This grand old mansion sits on over 100 acres of rolling hills and dense redwood forests."
      }
    }, {
      type: 'rentals',
      id: 'urban-living',
      attributes: {
        title: 'Urban Living',
        owner: 'Mike Teavee',
        city: 'Seattle',
        "property-type": 'Condo',
        bedrooms: 1,
        image: 'https://upload.wikimedia.org/wikipedia/commons/0/0e/Alfonso_13_Highrise_Tegucigalpa.jpg',
        description: "A commuters dream. This rental is within walking distance of 2 bus stops and the Metro."
      }
    }, {
      type: 'rentals',
      id: 'downtown-charm',
      attributes: {
        title: 'Downtown Charm',
        owner: 'Violet Beauregarde',
        city: 'Portland',
        "property-type": 'Apartment',
        bedrooms: 3,
        image: 'https://upload.wikimedia.org/wikipedia/commons/f/f7/Wheeldon_Apartment_Building_-_Portland_Oregon.jpg',
        description: "Convenience is at your doorstep with this charming downtown rental. Great restaurants and active night life are within a few feet."
      }
    }];

  this.get('/rentals', function(db, request) {
    if(request.queryParams.city !== undefined) {
      let filteredRentals = rentals.filter(function(i) {
        return i.attributes.city.toLowerCase().indexOf(request.queryParams.city.toLowerCase()) !== -1;
      });
      return { data: filteredRentals };
    } else {
      return { data: rentals };
    }
  });
}
```
Depois de atualizar as configurações do Mirage, devemos conseguir ver o resultado sendo filtrado a medida que vamos digitando no campo de texto.

![home screen with filter component](../../images/autocomplete-component/styled-super-rentals-filter.png)

#### Manipulação de resultados que retornam em tempos diferentes

Se você digitar rapidamente no campo de texto, você verá que o resultado apresentado é mostrado de forma confusa em tempo diferente.
Isso ocorre porque nossa função que faz a filtragem é _synchronous_, o que significa que o código na função é agendado para mais tarde, enquanto o código que chama a função continua a ser executado.
Muitas vezes, o código que faz solicitações na rede está configurado para ser assíncrono porque o servidor pode retornar as respostas em horários variáveis.

Vamos adicionar um código simples para garantir que nossos resultados sejam sincronizados de acordo com o valor do filtro.
Para fazer isso, simplesmente forneceremos o texto do filtro para a função de filtro, de modo que, quando os resultados retornarem, podemos comparar o valor do filtro original com o valor do filtro atual.
Vamos atualizar o resultado na tela somente se o valor do filtro original e o valor do filtro atual forem iguais.

```app/controllers/rentals.js{-7,+8,+9,+10,+11,-13,+14,+15,+16,+17}
import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    filterByCity(param) {
      if (param !== '') {
        return this.get('store').query('rental', { city: param });
        return this.get('store')
          .query('rental', { city: param }).then((results) => {
            return { query: param, results: results };
          });
      } else {
        return this.get('store').findAll('rental');
        return this.get('store')
          .findAll('rental').then((results) => {
            return { query: param, results: results };
          });
      }
    }
  }
});
```

A action `filterByCity` no controller rental acima, adicionamos uma nova propriedade chamada` query` aos resultados do filtro em vez de apenas retornar um array de imóveis como antes.

```app/components/list-filter.js{+9,+10,+11,+19,+20,+21}
import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['list-filter'],
  value: '',

  init() {
    this._super(...arguments);
    this.get('filter')('').then((allResults) => {
      this.set('results', allResults.results);
    });
  },

  actions: {
    handleFilterEntry() {
      let filterInputValue = this.get('value');
      let filterAction = this.get('filter');
      filterAction(filterInputValue).then((resultsObj) => {
        if (resultsObj.query === this.get('value')) {
          this.set('results', resultsObj.results);
        }
      });
    }
  }

});
```

No nosso component `list-filter`, usamos a propriedade `query` para comparar com a propriedade `value` do component.
A propriedade `value` representa o estado mais recente do filtro.
Portanto, verificamos se os resultados correspondem ao valor do filtro, garantindo que os resultados permanecerão em sincronia com a última coisa que o usuário digitou.

Embora esta abordagem mantenha nossa ordem de resultados consistente, há outras coisas a considerar ao lidar com várias tarefas simultâneas, como [limitar o número de solicitações feitas ao servidor](https://emberjs.com/api/classes/Ember.run.html#method_debounce).
Para criar um comportamento de autocomplete eficaz e robusto para seus aplicativos, recomendamos considerar utilizar o addon [`ember-concurrency`](http://ember-concurrency.com/#/docs/introduction).

Agora você pode avançar para [próxima página](../service/) ou continuar nesta página e fazer os teste de integração e aceitação.

### Teste de integração

Agora que criamos um novo component `list-filter`, precisamos criar testes para verificar que tudo funcione corretamente no futuro.
Vamos usar um [component integration test](../../testing/testing-components) para verificar o comportamento do component, semelhante ao teste criado para a [listagem de ímoveis](../simple-component/#toc_teste-de-integra-o).

Comece abrindo o arquivo de teste do component `list-filter` criado anteriormente `tests/integration/components/list-filter-test.js`.
Remova o teste padrão e crie um novo teste que verifique se o component irá listar todos os ímoveis.

```tests/integration/components/list-filter-test.js
import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('list-filter', 'Integration | Component | filter listing', {
  integration: true
});

test('should initially load all listings', function (assert) {
});
```

Nosso component `list-filter` recebe como argumento uma função, usado para retornar a lista de imóveis que corresponde a string digitada pelo usuário.

Para simular o comportamento da action `filterByCity` definida no controller `rental`, vamos criar uma action no escopo local usando `this.on`.

```tests/integration/components/list-filter-test.js{+3,+5,+6,+13,+14,+15,+16,+17}
import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import RSVP from 'rsvp';

const ITEMS = [{city: 'San Francisco'}, {city: 'Portland'}, {city: 'Seattle'}];
const FILTERED_ITEMS = [{city: 'San Francisco'}];

moduleForComponent('list-filter', 'Integration | Component | filter listing', {
  integration: true
});

test('should initially load all listings', function (assert) {
  // we want our actions to return promises,
  //since they are potentially fetching data asynchronously
  this.on('filterByCity', () => {
    return RSVP.resolve({ results: ITEMS });
  });
});
```

`this.on` irá adicionar a função fornecida ao escopo local de teste como` filterByCity`, que podemos usar para fornecer ao componente.

Nossa função `filterByCity` vai pretender ser a função de ação de nosso componente, que faz a filtragem real da lista de aluguel.

Não estamos testando a filtragem real dos aluguéis neste teste, pois está focada apenas na capacidade do componente.
Vamos testar a lógica completa de filtragem em testes de aceitação, descritos na próxima seção.

Uma vez que nosso componente está esperando que o processo do filtro seja assíncrono, retornamos as promessas do nosso filtro, usando a [Biblioteca RSVP da Ember] (http://emberjs.com/api/classes/RSVP.html).

Em seguida, adicionaremos a chamada para renderizar o componente para mostrar as cidades que fornecemos acima.


`this.on` will add the provided function to the test local scope as `filterByCity`, which we can use to provide to the component.

Our `filterByCity` function is going to pretend to be the action function for our component, that does the actual filtering of the rental list.

We are not testing the actual filtering of rentals in this test, since it is focused on only the capability of the component.
We will test the full logic of filtering in acceptance tests, described in the next section.

Since our component is expecting the filter process to be asynchronous, we return promises from our filter, using [Ember's RSVP library](http://emberjs.com/api/classes/RSVP.html).

Next, we'll add the call to render the component to show the cities we've provided above.

```tests/integration/components/list-filter-test.js{+19,+20,+21,+22,+23,+24,+25,+26,+27,+28,+29,+30,+31,+32}
import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import RSVP from 'rsvp';

const ITEMS = [{city: 'San Francisco'}, {city: 'Portland'}, {city: 'Seattle'}];
const FILTERED_ITEMS = [{city: 'San Francisco'}];

moduleForComponent('list-filter', 'Integration | Component | filter listing', {
  integration: true
});

test('should initially load all listings', function (assert) {
  // we want our actions to return promises,
  //since they are potentially fetching data asynchronously
  this.on('filterByCity', () => {
    return RSVP.resolve({ results: ITEMS });
  });

  // with an integration test,
  // you can set up and use your component in the same way your application
  // will use it.
  this.render(hbs`
    {{#list-filter filter=(action 'filterByCity') as |results|}}
      <ul>
      {{#each results as |item|}}
        <li class="city">
          {{item.city}}
        </li>
      {{/each}}
      </ul>
    {{/list-filter}}
  `);

});
```
Finalmente, adicionamos uma chamada de "espera" no final do nosso teste para afirmar os resultados.

Ember's [wait helper] (../../ testing / testing-components / # toc_waiting-on-asynchronous-behavior) aguarda que todas as tarefas assíncronas sejam concluídas antes de executar o retorno da função dada.
Ele retorna uma promessa de que também retornamos do teste.

Se você retornar uma promessa de um teste QUnit, o teste aguardará até terminar até que essa promessa seja resolvida.
Nesse caso, nosso teste é concluído quando o ajudante `wait` decide que o processamento está concluído, e a função que fornecemos que afirma que o estado resultante está concluído.

Finally we add a `wait` call at the end of our test to assert the results.

Ember's [wait helper](../../testing/testing-components/#toc_waiting-on-asynchronous-behavior) waits for all asynchronous tasks to complete before running the given function callback.
It returns a promise that we also return from the test.

If you return a promise from a QUnit test, the test will wait to finish until that promise is resolved.
In this case our test completes when the `wait` helper decides that processing is finished, and the function we provide that asserts the resulting state is completed.

```tests/integration/components/list-filter-test.js{+3,+33,+34,+35,+36}
import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import wait from 'ember-test-helpers/wait';
import RSVP from 'rsvp';

moduleForComponent('list-filter', 'Integration | Component | filter listing', {
  integration: true
});

const ITEMS = [{city: 'San Francisco'}, {city: 'Portland'}, {city: 'Seattle'}];
const FILTERED_ITEMS = [{city: 'San Francisco'}];

test('should initially load all listings', function (assert) {
  // we want our actions to return promises, since they are potentially fetching data asynchronously
  this.on('filterByCity', () => {
    return RSVP.resolve({ results: ITEMS });
  });

  // with an integration test,
  // you can set up and use your component in the same way your application will use it.
  this.render(hbs`
    {{#list-filter filter=(action 'filterByCity') as |results|}}
      <ul>
      {{#each results as |item|}}
        <li class="city">
          {{item.city}}
        </li>
      {{/each}}
      </ul>
    {{/list-filter}}
  `);

  return wait().then(() => {
    assert.equal(this.$('.city').length, 3);
    assert.equal(this.$('.city').first().text().trim(), 'San Francisco');
  });
});
```

Para o nosso segundo teste, verificaremos que o texto de digitação no filtro realmente chamará adequadamente a ação do filtro e atualizará as listagens mostradas.

Nós adicionaremos algumas funcionalidades adicionais à nossa ação `filterByCity` para retornar um único aluguel, representado pela variável `FILTERED_ITEMS` quando qualquer valor estiver definido.

Forçamos a ação gerando um evento `keyUp` em nosso campo de entrada, e depois afirmamos que apenas um item é renderizado.

For our second test, we'll check that typing text in the filter will actually appropriately call the filter action and update the listings shown.

We'll add some additional functionality to our `filterByCity` action to additionally return a single rental, represented by the variable `FILTERED_ITEMS` when any value is set.

We force the action by generating a `keyUp` event on our input field, and then assert that only one item is rendered.

```tests/integration/components/list-filter-test.js
test('should update with matching listings', function (assert) {
  this.on('filterByCity', (val) => {
    if (val === '') {
      return RSVP.resolve({
        query: val,
        results: ITEMS });
    } else {
      return RSVP.resolve({
        query: val,
        results: FILTERED_ITEMS });
    }
  });

  this.render(hbs`
    {{#list-filter filter=(action 'filterByCity') as |results|}}
      <ul>
      {{#each results as |item|}}
        <li class="city">
          {{item.city}}
        </li>
      {{/each}}
      </ul>
    {{/list-filter}}
  `);

  // The keyup event here should invoke an action that will cause the list to be filtered
  this.$('.list-filter input').val('San').keyup();

  return wait().then(() => {
    assert.equal(this.$('.city').length, 1);
    assert.equal(this.$('.city').text().trim(), 'San Francisco');
  });
});

```
Agora, ambos os cenários de teste de integração devem ser aprovados.
Você pode verificar isso iniciando nosso conjunto de testes digitando `ember t -s` na linha de comando.

Now both integration test scenarios should pass.
You can verify this by starting up our test suite by typing `ember t -s` at the command line.

### Teste de aceitação

Agora que testámos que o componente `list-filter` se comporta como esperado, vamos testar que a própria página também se comporta adequadamente com um teste de aceitação.
Verificaremos que um usuário que visite a página de aluguel pode inserir texto no campo de pesquisa e restringir a lista de aluguéis por cidade.

Abra nosso teste de aceitação existente, `tests / acceptance / list-rentals-test.js` e implemente o teste rotulado" deve filtrar a lista de aluguéis por cidade ".

Now that we've tested that the `list-filter` component behaves as expected, let's test that the page itself also behaves properly with an acceptance test.
We'll verify that a user visiting the rentals page can enter text into the search field and narrow the list of rentals by city.

Open our existing acceptance test, `tests/acceptance/list-rentals-test.js`, and implement the test labeled "should filter the list of rentals by city".


```/tests/acceptance/list-rentals-test.js
test('should filter the list of rentals by city.', function (assert) {
  visit('/');
  fillIn('.list-filter input', 'Seattle');
  keyEvent('.list-filter input', 'keyup', 69);
  andThen(function() {
    assert.equal(find('.listing').length, 1, 'should show 1 listing');
    assert.equal(find('.listing .location:contains("Seattle")').length, 1, 'should contain 1 listing with location Seattle');
  });
});
```
Apresentamos dois novos ajudantes neste teste, `fillIn` e` keyEvent`.

* O [`fillIn`] (http://emberjs.com/api/classes/Ember.Test.html#method_fillIn) helper" preenche "o texto fornecido em um campo de entrada correspondente ao seletor fornecido.
* O auxiliar [`keyEvent`] (http://emberjs.com/api/classes/Ember.Test.html#method_keyEvent) envia um evento de traçado de tecla para a interface do usuário, simulando o usuário digitando uma chave.

Em `app / components / list-filter.js`, temos como elemento de nível superior representado pelo componente uma classe chamada` list-filter`.
Localizamos a entrada de pesquisa dentro do componente usando o seletor `.list-filter input`, pois sabemos que existe apenas um elemento de entrada localizado no componente de filtro de lista.

Nosso teste preenche "Seattle" como o critério de pesquisa no campo de pesquisa e, em seguida, envia um evento `keyup` para o mesmo campo com um código de` 69` (a chave `e`) para simular a digitação de um usuário.

O teste localiza os resultados da pesquisa encontrando elementos com uma classe de 'listagem', que nós demos ao nosso componente 'lista de aluguel' na seção ["Construindo um Componente Simples"] (../ componente simples) o tutorial.

Uma vez que nossos dados estão codificados em Mirage, sabemos que existe apenas um aluguel com um nome da cidade de "Seattle", por isso afirmamos que o número de listagens é um e que a localização exibida é chamada "Seattle".

O teste verifica que depois de preencher a entrada de pesquisa com "Seattle", a lista de aluguel diminui de 3 para 1 e o item exibido mostra "Seattle" como a localização.

Você deve fazer apenas 2 testes com falha: uma falha de teste de aceitação remanescente; e nosso teste ESLint que falha em um assertivo não utilizado para o nosso teste não implementado.

We introduce two new helpers into this test, `fillIn` and `keyEvent`.

* The [`fillIn`](http://emberjs.com/api/classes/Ember.Test.html#method_fillIn) helper "fills in" the given text into an input field matching the given selector.
* The [`keyEvent`](http://emberjs.com/api/classes/Ember.Test.html#method_keyEvent) helper sends a key stroke event to the UI, simulating the user typing a key.

In `app/components/list-filter.js`, we have as the top-level element rendered by the component a class called `list-filter`.
We locate the search input within the component using the selector `.list-filter input`, since we know that there is only one input element located in the list-filter component.

Our test fills out "Seattle" as the search criteria in the search field, and then sends a `keyup` event to the same field with a code of `69` (the `e` key) to simulate a user typing.

The test locates the results of the search by finding elements with a class of `listing`, which we gave to our `rental-listing` component in the ["Building a Simple Component"](../simple-component) section of the tutorial.

Since our data is hard-coded in Mirage, we know that there is only one rental with a city name of "Seattle", so we assert that the number of listings is one and that the location it displays is named, "Seattle".

The test verifies that after filling in the search input with "Seattle", the rental list reduces from 3 to 1, and the item displayed shows "Seattle" as the location.

You should be down to only 2 failing tests: One remaining acceptance test failure; and our ESLint test that fails on an unused assert for our unimplemented test.

![passing acceptance tests](../../images/autocomplete-component/passing-acceptance-tests.png)
