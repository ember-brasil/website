No nosso aplicativo Super Rentals, queremos acessar a página inicial e exibir a lista de imóveis para alugar.
A partir daí, precisamos conseguir visitar uma página sobre a empresa e outra com informações de contato.

## Página Sobre

Vamos começar construíndo nossa página "sobre".

Em Ember, quando queremos fazer uma nova página, precisamos criar uma `route` usando o Ember CLI. Para uma visão geral rápida de como o Ember estrutura as coisas, veja [nosso diagrama na página de conceitos básicos](../../ começando / core-concepts /).

Vamos usar Ember CLI para criar nossa "route" `about`.


```shell
ember generate route about
```

_**Note**: Running `ember help generate` will list a number of other Ember resources you can create as well ..._

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

## An Index Route

With our three routes in place, we are ready to add an index route, which will handle requests to the root URI (`/`) of our site.
We'd like to make the rentals page the main page of our application, and we've already created a route.
Therefore, we want our index route to simply forward to the `rentals` route we've already created.

Using the same process we did for our about and contact pages, we will first generate a new route called `index`.

```shell
ember g route index
```

We can see the now familiar output for the route generator:

```shell
installing route
  create app/routes/index.js
  create app/templates/index.hbs
installing route-test
  create tests/unit/routes/index-test.js
```

Unlike the other route handlers we've made so far, the `index` route is special:
it does NOT require an entry in the router's mapping.
We'll learn more about why the entry isn't required later on when we look at [nested routes](../subroutes) in Ember.

All we want to do when a user visits the root (`/`) URL is transition to `/rentals`.
To do this we will add code to our index route handler by implementing a route lifecycle hook,
called `beforeModel`.

Each route handler has a set of "lifecycle hooks", which are functions that are invoked at specific times during the loading of a page.
The [`beforeModel`](http://emberjs.com/api/classes/Ember.Route.html#method_beforeModel)
hook gets executed before the data gets fetched from the model hook, and before the page is rendered.
See [the next section](../model-hook) for an explanation of the model hook.

In our index route handler, we'll call the [`replaceWith`](http://emberjs.com/api/classes/Ember.Route.html#method_replaceWith) function.
The `replaceWith` function is similar to the route's `transitionTo` function,
the difference being that `replaceWith` will replace the current URL in the browser's history,
while `transitionTo` will add to the history.
Since we want our `rentals` route to serve as our home page, we will use the `replaceWith` function.

In our index route handler, we add the `replaceWith` invocation to `beforeModel`.

```app/routes/index.js{+4,+5,+6}
import Ember from 'ember';

export default Ember.Route.extend({
  beforeModel() {
    this.replaceWith('rentals');
  }
});
```

Now visiting the root route at `/` will result in the `/rentals` URL loading.

## Adding a Banner with Navigation

In addition to adding individual links to each route of our app, we'd like to
add a common header across the top of our page to display our app's title and its navigation bar.

To show something on every page, we can use the application template (which we edited earlier).
Let's open it again (`/app/templates/application.hbs`) and replace its contents with the following:

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

We've seen most of this before, but the `{{outlet}}` beneath `<div class="body">` is new.
The `{{outlet}}` helper tells Ember where content for our current route (such as `about`
or `contact`) should be shown.

At this point, we should be able to navigate between our `about`, `contact`, and `rentals` pages.

From here you can move on to the [next page](../model-hook/) or dive into testing the new functionality we just added.

## Implementing Acceptance Tests

Now that we have various pages in our application, let's walk through how to build tests for them.

As mentioned earlier on the [Planning the Application page](../acceptance-test/),
an Ember acceptance test automates interacting with our app in a similar way to a visitor.

If you open the acceptance test we created (`/tests/acceptance/list-rentals-test.js`), you'll see our
goals, which include the ability to navigate to an `about` page and a `contact` page. Let's start there.

First, we want to test that visiting `/` properly redirects to `/rentals`. We'll use the Ember `visit` helper
and then make sure our current URL is `/rentals` once the redirect occurs.

```/tests/acceptance/list-rentals-test.js{+2,+3,+4,+5}
test('should show rentals as the home page', function (assert) {
  visit('/');
  andThen(function() {
    assert.equal(currentURL(), '/rentals', 'should redirect automatically');
  });
});
```

Now run the tests by typing `ember test --server` in the command line (or `ember t -s` for short).

Instead of 7 failures there should now be 6 (5 acceptance failures and 1 ESLint).
You can also run our specific test by selecting the entry called "Acceptance | list rentals"
in the drop down input labeled "Module" on the test UI.

You can also toggle "Hide passed tests" to show your passing test case along with the tests that are still
failing (because we haven't yet built them).

![6_fail](../../images/routes-and-templates/routes-and-templates.gif)

### Ember's test helpers

Ember provides a variety of acceptance test helpers to make common tasks easier,
such as visiting routes, filling in fields, clicking on links/buttons, and waiting for pages to display.

Some of the helpers we'll use commonly are:

* [`visit`](http://emberjs.com/api/classes/Ember.Test.html#method_visit) - loads a given URL
* [`click`](http://emberjs.com/api/classes/Ember.Test.html#method_click) - pretends to be a user clicking on a specific part of the screen
* [`andThen`](../../testing/acceptance/#toc_wait-helpers) - waits for our previous commands to run before executing our function.
  In our test below, we want to wait for our page to load after `click` is called so that we can double-check that the new page has loaded
* [`currentURL`](http://emberjs.com/api/classes/Ember.Test.html#method_currentURL) - returns the URL of the page we're currently on

### Test visiting our About and Contact pages
Now let's add code that simulates a visitor arriving on our homepage, clicking one of our links and then visiting a new page.

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

In the tests above, we're using [`assert.equal()`](https://api.qunitjs.com/assert/equal). `assert.equal()` checks
to see if two items (our first and second arguments) equal each other.  If they don't, our test will fail.
The third optional argument allows us to provide a nicer message which we'll be shown if this test fails.

In our tests, we also call two helpers (`visit` and `click`) one after another. Although Ember does a number
of things when we make those calls, Ember hides those complexities by giving us these [asynchronous test helpers](../../testing/acceptance/#toc_asynchronous-helpers).

If you left `ember test` running, it should have automatically updated to show the three tests related to
navigating have now passed.

In the screen recording below, we run the tests, deselect "Hide passed tests", and set the module to our acceptance test,
revealing the 3 tests we got passing.

![passing navigation tests](../../images/routes-and-templates/ember-route-tests.gif)
