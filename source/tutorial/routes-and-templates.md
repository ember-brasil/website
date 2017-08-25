No nosso aplicativo Super Rentals, queremos acessar a página inicial e exibir a lista de imóveis para alugar.
A partir daí, precisamos conseguir visitar uma página sobre a empresa e outra com informações de contato.

## Página Sobre

Vamos começar construíndo nossa página "sobre".

Em Ember, quando queremos fazer uma nova página, precisamos criar uma `route` usando o Ember CLI. Para uma visão geral rápida de como o Ember estrutura as coisas, veja [nosso diagrama na página de conceitos básicos](../../começando/core-concepts/).

Vamos usar Ember CLI para criar nossa "route" `about`.


```shell
ember generate route about
```

_**Observação**: executando `ember help generate` listará diversos recursos que você pode utilizar, você também pode criar os seus futuramente._

Após executar o comando, esse será o resultado:

```shell
installing route
  create app/routes/about.js
  create app/templates/about.hbs
updating router
  add route about
installing route-test
  create tests/unit/routes/about-test.js
```

Uma Ember `route` é construída com três partes:

1. Uma entrada no Ember `Router` (`/app/router.js`), que mapeia nosso o nome da route a uma URL
2. Um arquivo de manipulador de route, que configura o que deve acontecer quando essa route é carregada _`(app/routes/about.js)`_
3. Um template da route, onde é exibido o conteúdo da página _`(app/templates/about.hbs)`_

Se você abrir `/app/router.js`, verá uma nova linha de código para a route **about**, chamanda `this.route('about')` na função `Router.map`. Essa nova linha de código diz ao roteador Ember para executar o nosso arquivo `/app/routes/about.js` quando um visitante acessa `/about`.

```app/router.js{+10}
import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('about');
});

export default Router;
```

Como a página sobre a empresa vai ter um conteúdo estático, não vamos ajustar o arquivo de manipulador de route `/app/routes/about.js` agora. Em vez disso, vamos abrir nosso arquivo de template `/app/templates/about.hbs` e adicionar algumas informações sobre Super Rentals:

```app/templates/about.hbs
<div class="jumbo">
  <div class="right tomster"></div>
  <h2>About Super Rentals</h2>
  <p>
    The Super Rentals website is a delightful project created to explore Ember.
    By building a property rental site, we can simultaneously imagine traveling
    AND building Ember applications.
  </p>
</div>
```

Agora, execute `ember server` (ou` ember serve`, ou mesmo `ember s` para abreviar) em seu terminal para iniciar o servidor de desenvolvimento Ember e acesse [`http://localhost:4200/about`](http://localhost:4200/about) para ver nossa nova página em ação!

## Página de contato

Agora vamos criar outra route com informações de contato.
Mais uma vez, começaremos gerando uma route:


```shell
ember g route contact
```

Mais uma vez, adicionamos uma nova route em `app/router.js` e criamos um manipulador de route em `app/routes/contact.js`.

No template da route `/app/templates/contact.hbs`, vamos adicionar informações de contato:


```app/templates/contact.hbs
<div class="jumbo">
  <div class="right tomster"></div>
  <h2>Contact Us</h2>
  <p>Super Rentals Representatives would love to help you<br>choose a destination or answer
    any questions you may have.</p>
  <p>
    Super Rentals HQ
    <address>
      1212 Test Address Avenue<br>
      Testington, OR 97233
    </address>
    <a href="tel:503.555.1212">+1 (503) 555-1212</a><br>
    <a href="mailto:superrentalsrep@emberjs.com">superrentalsrep@emberjs.com</a>
  </p>
</div>
```

Agora, quando você acessar [`http://localhost:4200/contact`](http://localhost:4200/contact), será exibido a página de contato.

## Navegando entre links com Helper {{link-to}}

Navegar entre os links se tornou uma dor agora, então vamos facilitar isso.
Vamos colocar um link para a página de contato para a página sobre, e um link correspondente para a página sobre na página de contato.

Para fazer isso, usaremos um Ember Helper [`{{link-to}}`](../../ templates/links/) que facilita a navegação entre nossas páginas. Vamos ajustar o nosso arquivo `about.hbs`:

```app/templates/about.hbs{+9,+10,+11}
<div class="jumbo">
  <div class="right tomster"></div>
  <h2>About Super Rentals</h2>
  <p>
    The Super Rentals website is a delightful project created to explore Ember.
    By building a property rental site, we can simultaneously imagine traveling
    AND building Ember applications.
  </p>
  {{#link-to 'contact' class="button"}}
    Contact Us
  {{/link-to}}
</div>
```

Neste caso, estamos dizendo para o Helper `{{link-to}}` que queremos criar um link para a route: `contact`.
Quando olhamos para a nossa página sobre [`http://localhost:4200/about`](http://localhost:4200/about), agora temos um link funcionando para nossa página de contato:

![super rentals about page screenshot](../../images/routes-and-templates/ember-super-rentals-about.png)

Agora, vamos adicionar um link correspondente à página de contatos, para que possamos navegar entre `about` e` contact`:

```app/templates/contact.hbs{+15,+16,+17}
<div class="jumbo">
  <div class="right tomster"></div>
  <h2>Contact Us</h2>
  <p>Super Rentals Representatives would love to help you<br>choose a destination or answer
    any questions you may have.</p>
  <p>
    Super Rentals HQ
    <address>
      1212 Test Address Avenue<br>
      Testington, OR 97233
    </address>
    <a href="tel:503.555.1212">+1 (503) 555-1212</a><br>
    <a href="mailto:superrentalsrep@emberjs.com">superrentalsrep@emberjs.com</a>
  </p>
  {{#link-to 'about' class="button"}}
    About
  {{/link-to}}
</div>
```

## Página de aluguéis

Além das nossas páginas `about` e `contact`, queremos listar os aluguéis que nossos clientes. Então, vamos adicionar uma terceira route e chamá-la de `rentals`:

```shell
ember g route rentals
```
E então vamos atualizar nosso novo template (`/app/templates/rentals.hbs`) com algum conteúdo inicial.
Voltaremos a esta página para adicionar as propriedades reais do aluguéis.

```app/templates/rentals.hbs
<div class="jumbo">
  <div class="right tomster"></div>
  <h2>Welcome!</h2>
  <p>We hope you find exactly what you're looking for in a place to stay.</p>
  {{#link-to 'about' class="button"}}
    About Us
  {{/link-to}}
</div>
```

## Página index

Com nossas três routes criada, estamos prontos para adicionar uma route de index, que irá lidar com solicitações para o URI (`/`) do nosso site.
Gostaríamos de fazer a página de aluguel na página principal do nosso aplicativo e já criamos uma route.
Portanto, queremos que nossa route index simplesmente redirecione nosso cliente para a route `rentals` que já criamos.

Usando o mesmo processo que fizemos anteriormente, primeiro devemos criar uma nova route chamada `index`.


```shell
ember g route index
```
Esse é o resultado do comando para você olhar e se familiarizar:

```shell
installing route
  create app/routes/index.js
  create app/templates/index.hbs
installing route-test
  create tests/unit/routes/index-test.js
```

Ao contrário dos outros manipuladores de routes que fizemos até agora, a route `index` é especial:
**NÃO** requer uma entrada no mapeamento do roteador.
Vamos aprender mais sobre por que a entrada não é necessária mais tarde quando olharmos para [nested routes](../ subroutes) do Ember.

Tudo o que queremos fazer quando um usuário visita nossa URL (`/`) é redireciona-lo para `/rentals`.
Para fazer isso, adicionaremos um código ao nosso manipulador de route `index`, implementando um hook de ciclo de vida da route, chamado `beforeModel`.

Cada manipulador de route possui um conjunto de "lifecycle hooks", que são funções invocadas em momentos específicos durante o carregamento de uma página.
O hook [`beforeModel`](http://emberjs.com/api/classes/Ember.Route.html#method_beforeModel) é executado antes que os dados sejam obtidos pelo hook `model` e antes que a página seja renderizada.
Veja [a próxima seção](../ model-hook) para obter uma explicação do hook `model`.

Em nosso manipulador de route `index`, chamaremos a função [`replaceWith`](http://emberjs.com/api/classes/Ember.Route.html#method_replaceWith).
A função `replaceWith` é semelhante à função` transitionTo` da rota, sendo a diferença que `replaceWith` substituirá o URL atual no histórico do navegador, enquanto` transitionTo` irá adicionar ao histórico.
Como queremos que nossa route de "rentals" seja nossa página inicial, usaremos a função `replaceWith`.

Em nosso manipulador de route `index`, vamos chamar `replaceWith` em `beforeModel`.

```app/routes/index.js{+4,+5,+6}
import Ember from 'ember';

export default Ember.Route.extend({
  beforeModel() {
    this.replaceWith('rentals');
  }
});
```

Agora, vamos acessar a route `/` e ver que ela vai redirecionar para `/rentals`.

## Criando uma barra de navegação


Queremos agora criar uma barra de navegação que tenha o nome do nosso aplicativo e os links para nossas páginas internas.

Para mostrar a mesma barra em cada página, vamos usar o template `/app/templates/application.hbs`.
Vamos edita-lo novamente substituindo seu conteúdo por este:

```app/templates/application.hbs
<div class="container">
  <div class="menu">
    {{#link-to 'index'}}
      <h1>
        <em>SuperRentals</em>
      </h1>
    {{/link-to}}
    <div class="links">
      {{#link-to 'about'}}
        About
      {{/link-to}}
      {{#link-to 'contact'}}
        Contact
      {{/link-to}}
    </div>
  </div>
  <div class="body">
    {{outlet}}
  </div>
</div>
```
Muito do código acima já conhecemos, mas o `{{outlet}}` dentro de `<div class="body">` é novo.
O Helper `{{outlet}}` diz para o Ember onde o conteúdo das nossas routes (como `about` ou `contact`) deve ser mostrado.

A partir deste ponto, devemos conseguir navegar entre as páginas `about`,` contact`, e `rentals`.

Você pode agora optar seguir na [próxima página](../model-hook/) ou fazer os testes de aceitação das páginas que acabamos de criar.

## Implementando testes de aceitação


Agora que temos várias páginas em nosso aplicativo, vamos ver como criar testes para elas.

Como mencionado anteriormente na página [Planejando seu aplicativo](.../aceitação-teste/), um teste de aceitação do Ember automatiza a interação com o nosso aplicativo simulando uma navegação de um usuário real.

Se você abrir o teste de aceitação que criamos (`/tests/acceptance/list-rentals-test.js`), você verá nossos objetivos, que incluem conseguir acessar as páginas `about` e `contact`. Vamos começar por lá.

Primeiro, queremos testar que ao acessar `/` nosso aplicativo seja redirecionado corretamente para `/rentals`. Usaremos o Helper `visit` do Ember e, em seguida, verificamos se nossa URL atual é `/rentals`.

```/tests/acceptance/list-rentals-test.js{+2,+3,+4,+5}
test('should show rentals as the home page', function (assert) {
  visit('/');
  andThen(function() {
    assert.equal(currentURL(), '/rentals', 'should redirect automatically');
  });
});
```

Agora, execute os testes digitando `ember test --server` no terminal (ou `ember t -s`).

Em vez de 7 falhas, agora deve ter 6 (5 falhas de aceitação e 1 ESLint).
Você também pode executar o nosso teste específico, selecionando o teste chamado "Acceptance | list rentals" no campo de seleção "Module" na UI de teste.

Você também pode marcar a opção "Hide passed tests" para mostrar os testes aprovados, juntamente com os testes que ainda estão falhando (porque ainda não os construímos).


![6_fail](../../images/routes-and-templates/routes-and-templates.gif)

### Helpers de testes do Ember

Ember fornece uma variedade de helpers de teste de aceitação para tornar as tarefas comuns mais fáceis, como visitar links, preenchendo campos, clicando em links/botões e esperando que as páginas sejam exibidas.

Esses são os helpers que usaremos com mais frequencia:

* [`visit`](http://emberjs.com/api/classes/Ember.Test.html#method_visit) - visita um link do nosso aplicativo
* [`click`](http://emberjs.com/api/classes/Ember.Test.html#method_click) - clica em um link/botão simulando um usuário
* [`andThen`](../../testing/acceptance/#toc_wait-helpers) - espera que nossa página tenha terminando de carregar para fazer as verificações. No nosso teste abaixo, por exemplo, queremos aguardar após um `click` e verificar se a página correta foi carregada
* [`currentURL`](http://emberjs.com/api/classes/Ember.Test.html#method_currentURL) - retorna a URL atual do nosso aplicativo

### Testar uma visita na página de contatos e sobre

Agora vamos adicionar um código que simula um visitante que chega na nossa página inicial, clicando em um de nossos links e depois visitando uma nova página.


```/tests/acceptance/list-rentals-test.js{+2,+3,+4,+5,+6,+10,+11,+12,+13,+14}
test('should link to information about the company.', function (assert) {
  visit('/');
  click('a:contains("About")');
  andThen(function() {
    assert.equal(currentURL(), '/about', 'should navigate to about');
  });
});

test('should link to contact information', function (assert) {
  visit('/');
  click('a:contains("Contact")');
  andThen(function() {
    assert.equal(currentURL(), '/contact', 'should navigate to contact');
  });
});
```
Nos testes acima, estamos usando [`assert.equal()`](https://api.qunitjs.com/assert/equal). `assert.equal()` verifica se dois itens (nosso primeiro e segundo argumentos) são iguais. Se não são iguais, nosso teste falhará.

O terceiro argumento opcional nos permite fornecer uma mensagem melhor, que será mostrada quando esse teste falhar.

Nos nossos testes, também chamamos dois helpers (`visit` e `click`) um após o outro. Embora o Ember faça uma série de coisas quando fazemos essas chamadas, o Ember esconde essas complexidades, dando-nos estes [asynchronous test helpers](../../testing/acceptance/#toc_asynchronous-helpers).

Se você deixou o `ember test` em execução, ele deve ter atualizado automaticamente para mostrar que os três testes relacionados à navegação já passaram.

In the screen recording below, we run the tests, deselect "Hide passed tests", and set the module to our acceptance test,
revealing the 3 tests we got passing.

No screenshot abaixo, executamos os testes, desmarque "Hide passed tests" e selecione o module para nosso testes de aceitação, temos agora 3 testes passando e 3 testes falhando.

![passing navigation tests](../../images/routes-and-templates/ember-route-tests.gif)
