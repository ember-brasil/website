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

## Injeção de Factory

Uma vez a factory estando registrada, ela pode ser "injetada" onde for necessário.

Factories pode ser injetadas em vários "tipos" de factories com *tipo de injeções*. Por exemplo:

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

Como resultado desse tipo de injeção,
todas as factoires do tipo `route` serão instanciadas com a propriedade `logger` injetada.
O valor de `logger` virá da factory chamada `logger:main`.

Routes nessa applicação exemplo podem apartir de agora acessar o logger injetado:

```app/routes/index.js
import Ember from 'ember';

export default Ember.Route.extend({
  activate() {
    // A propriedade logger é injetada em todas as rotas
    this.get('logger').log('Entered the index route!');
  }
});
```
Injeções também podem serem feitas em uma factory especifica usando sua chave completa:

```js
application.inject('route:index', 'logger', 'logger:main');
```

Nesse caso, o logger será injetado somente na rota index.

As injeções podem ser feitas em qualquer classe que exija instânciamento.
Isso inclui todas as principais classes do framework Ember, como components, helper, routes e o router.

### Injeções Ad Hoc

As injeções de dependências também podem ser declaradas diretamente em classes Ember usando `Ember.inject`.
Atualmente, `Ember.inject` suporta injeção de controllers (via `Ember.inject.controller`)
e services (via `Ember.inject.service`).

O código a seguir injeta o service `shopping-cart` no componente `cart-contents` como propriedade `cart`:

```app/components/cart-contents.js
import Ember from 'ember';

export default Ember.Component.extend({
  cart: Ember.inject.service('shopping-cart')
});
```
Se você gostaria de injetar um service com o mesmo nome da propriedade, 
simplesmente deixe sem o nome do service (a versão dasherizada do nome será usada):

```app/components/cart-contents.js
import Ember from 'ember';

export default Ember.Component.extend({
  shoppingCart: Ember.inject.service()
});
```

## Pesquisas de Instância de Factory

Para buscar uma factory instânciada em uma aplicação em execução você pode chamar o método [`lookup`][3] em uma instância de aplicação. Esse método pega uma string para identificar uma factory e retorna o objeto apropriado.

```javascript
applicationInstance.lookup('factory-type:factory-name');
```

A instância da aplicação é passada para os hooks inicializadores de instância do Ember e
adicionado como "dono" de cada objeto que foi instânciado pela instância da
aplicação.

### Usando uma Instância de Aplicação dentro de um Inicializador de Instância

Os inicializadores de instâncias recebem uma instância de aplicação como um argumento, provendo
uma oportunidade para pesquisar uma instância em uma factory registrada.

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

### Obtendo uma Instância de Aplicação de uma Instância de Factory

[`Ember.getOwner`][4] irá recuperar a instância da aplicação que "possui" um 
objeto. Isso significa que objetos do framework como components, helpers e routes podem usar [`Ember.getOwner`][4] para realizar pesquisas através de sua instância de aplicação em tempo de execução.

Por exemplo, esse componente reproduz músicas com diferentes serviços de áudio baseados
no `audioType` da música.

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

