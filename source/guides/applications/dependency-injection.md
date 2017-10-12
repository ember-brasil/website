Aplicações Ember utilizam o padrão de projeto [injeção de dependência](https://en.wikipedia.org/wiki/Dependency_injection)
("DI") para declarar e instanciar classes de objetos e as dependências entre eles. Aplicações e instâncias de aplicação, possuem cada uma funções na implementação DI do Ember.  

Uma [`Ember.Application`][1] serve como um "registro" para declarações de dependência.
Factories (ex.: classes) são registradas com uma aplicação, 
assim como as regras sobre "injetamento" de dependências que são aplicadas quando os objetos são instânciados.

Uma [`Ember.ApplicationInstance`][2] serve como o "dono" para objetos que são instânciados apartir de factories registradas.
Instâncias de aplicação fornecem uma forma de "pesquisar" (ou seja, instânciar e/ou recuperar) objetos.

> _Nota: Apesar de uma `Application` servir como um registro principal em  uma aplicação, 
cada `ApplicationInstance` pode servir também como um registro. 
Os registros em nível de instância são úteis para fornecer customizações em nível de instância, 
como o teste A/B de um recurso._ 

[1]: http://emberjs.com/api/classes/Ember.Application.html
[2]: http://emberjs.com/api/classes/Ember.ApplicationInstance.html

## Registros de Factory

Uma factory pode representar qualquer parte da sua aplicação, como uma _route_, _template_, ou uma classe personalizada.
Toda factory está registrada com um chave específica.
Por exemplo, o template index é registrado com a chave `template:index`,
e a rota application registrada com a chave `route:application`.

Chaves de registro tem dois segmentos divididos por dois pontos (`:`).
O primeiro segmento é o tipo da factory do framework e o segundo o nome da factory em  particular.
Portanto, o template `index` tem a chave `template:index`.
Ember tem vários tipos de factory embutidos, como `service`, `route`, `template` e  `component`.

Você pode criar seu próprio tipo de factory simplesmente registrando uma factory com o novo tipo.
Por exemplo, para cria um tipo `user`,
você simplesmente registraria sua factory com `application.register('user:user-to-register')`.

Registros de factory deve ser realizadas tanto em aplicação ou em inicializadores de  instância de aplicação (sendo o primeiro o mais comum).

Por exemplo, um inicializador de aplicação pode registrar uma factory `Logger` com a chave `logger:main`:

```app/initializers/logger.js
import Ember from 'ember';

export function initialize(application) {
  let Logger = Ember.Object.extend({
    log(m) {
      console.log(m);
    }
  });

  application.register('logger:main', Logger);
}

export default {
  name: 'logger',
  initialize: initialize
};
```

### Registrando objetos já registrados

Por padrão, Ember tentará instanciar um factory registrada quando for pesquisada (lookup).
Quando registrar uma objeto já instanciado ao invés de uma classe,
utilize a opção `instantiate: false` para evitar tentativas de re-instanciamento durante a pesquisa (lookups).

No exemplo a seguir, o `logger` é um objeto Javascript simples que deve ser retornado "como ele é" quando for pesquisado.

```app/initializers/logger.js
export function initialize(application) {
  let logger = {
    log(m) {
      console.log(m);
    }
  };

  application.register('logger:main', logger, { instantiate: false });
}

export default {
  name: 'logger',
  initialize: initialize
};
```

### Registro de Singletons vs. Non-Singletons

Por padrão, registramentos são tratados como "singletons".
Isso simplesmente significa que uma instância será criada quando for pesquisada pela primeira vez,
e esta mesma instância será armazenada e retornada nas pesquisas subseqüentes.

Quando você precisa que objetos novos sejam criados em cada pesquisa,
registre sua factory como um non-singleton usando a opção `singleton: false`.

No exemplo a seguir, a classe `Message` é registrada como um non-singleton:

```app/initializers/notification.js
import Ember from 'ember';

export function initialize(application) {
  let Message = Ember.Object.extend({
    text: ''
  });

  application.register('notification:message', Message, { singleton: false });
}

export default {
  name: 'notification',
  initialize: initialize
};
```

## Factory Injections

Once a factory is registered, it can be "injected" where it is needed.

Factories can be injected into whole "types" of factories with *type injections*. For example:

```app/initializers/logger.js
import Ember from 'ember';

export function initialize(application) {
  let Logger = Ember.Object.extend({
    log(m) {
      console.log(m);
    }
  });

  application.register('logger:main', Logger);
  application.inject('route', 'logger', 'logger:main');
}

export default {
  name: 'logger',
  initialize: initialize
};
```

As a result of this type injection,
all factories of the type `route` will be instantiated with the property `logger` injected.
The value of `logger` will come from the factory named `logger:main`.

Routes in this example application can now access the injected logger:

```app/routes/index.js
import Ember from 'ember';

export default Ember.Route.extend({
  activate() {
    // The logger property is injected into all routes
    this.get('logger').log('Entered the index route!');
  }
});
```

Injections can also be made on a specific factory by using its full key:

```js
application.inject('route:index', 'logger', 'logger:main');
```

In this case, the logger will only be injected on the index route.

Injections can be made into any class that requires instantiation.
This includes all of Ember's major framework classes, such as components, helpers, routes, and the router.

### Ad Hoc Injections

Dependency injections can also be declared directly on Ember classes using `Ember.inject`.
Currently, `Ember.inject` supports injecting controllers (via `Ember.inject.controller`)
and services (via `Ember.inject.service`).

The following code injects the `shopping-cart` service on the `cart-contents` component as the property `cart`:

```app/components/cart-contents.js
import Ember from 'ember';

export default Ember.Component.extend({
  cart: Ember.inject.service('shopping-cart')
});
```

If you'd like to inject a service with the same name as the property,
simply leave off the service name (the dasherized version of the name will be used):

```app/components/cart-contents.js
import Ember from 'ember';

export default Ember.Component.extend({
  shoppingCart: Ember.inject.service()
});
```

## Factory Instance Lookups

To fetch an instantiated factory from the running application you can call the
[`lookup`][3] method on an application instance. This method takes a string
to identify a factory and returns the appropriate object.

```javascript
applicationInstance.lookup('factory-type:factory-name');
```

The application instance is passed to Ember's instance initializer hooks and it
is added as the "owner" of each object that was instantiated by the application
instance.

### Using an Application Instance Within an Instance Initializer

Instance initializers receive an application instance as an argument, providing
an opportunity to look up an instance of a registered factory.

```app/instance-initializers/logger.js
export function initialize(applicationInstance) {
  let logger = applicationInstance.lookup('logger:main');

  logger.log('Hello from the instance initializer!');
}

export default {
  name: 'logger',
  initialize: initialize
};
```

### Getting an Application Instance from a Factory Instance

[`Ember.getOwner`][4] will retrieve the application instance that "owns" an
object. This means that framework objects like components, helpers, and routes
can use [`Ember.getOwner`][4] to perform lookups through their application
instance at runtime.

For example, this component plays songs with different audio services based
on a song's `audioType`.

```app/components/play-audio.js
import Ember from 'ember';
const {
  Component,
  computed,
  getOwner
} = Ember;

// Usage:
//
//   {{play-audio song=song}}
//
export default Component.extend({
  audioService: computed('song.audioType', function() {
    let applicationInstance = getOwner(this);
    let audioType = this.get('song.audioType');
    return applicationInstance.lookup(`service:audio-${audioType}`);
  }),

  click() {
    let player = this.get('audioService');
    player.play(this.get('song.file'));
  }
});
```

[3]: http://emberjs.com/api/classes/Ember.ApplicationInstance.html#method_lookup
[4]: http://emberjs.com/api/#method_getOwner

