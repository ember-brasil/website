Atualmente, nossa aplicação está usando dados fake em nossa listagem de imoveis para alugar, que estão definidas no route `rental`.
À medida que nossa aplicação cresce, queremos persistir nossos imóveis em um servidor e facilitar operações de consulta desses dados.

Ember vem com uma biblioteca de gerenciamento de dados chamada [Ember Data](https://github.com/emberjs/data) para ajudar a controlar e persitir os dados da nossa aplicação.

Ember Data requer que nós definimos a estrutura dos dados que vamos utilizar em nossa aplicação estendendo [`DS.Model`](http://emberjs.com/api/data/classes/DS.Model.html).

Você pode gerar Ember Data Model usando Ember CLI.
Chamaremos nosso model de `rental`:

```shell
ember g model rental
```
O resultado será a criação de dois arquivos, nosso model e um arquivo de teste:

```shell
installing model
  create app/models/rental.js
installing model-test
  create tests/unit/models/rental-test.js
```
Abrindo o arquivo model, podemos ver uma classe em branco que se estende [`DS.Model`](http://emberjs.com/api/data/classes/DS.Model.html):

```app/models/rental.js
import DS from 'ember-data';

export default DS.Model.extend({

});
```

Vamos definir a estrutura do objeto `rental` usando os  atributos do nosso imóvel que [usado anteriormente](../model-hook/) em nosso array de imoveis - _title_, _owner_, _city_, _property type_, _image_ , _bedrooms_ e _description_.
Defina atributos com a  função [`DS.attr()`](http://emberjs.com/api/data/classes/DS.html#method_attr).
Para obter mais informações sobre os Ember Data Attributes, leia a seção chamada [Definição de atributos](../../models/ define-models/#toc_defining-attributes).


```app/models/rental.js
import DS from 'ember-data';

export default DS.Model.extend({
  title: DS.attr(),
  owner: DS.attr(),
  city: DS.attr(),
  propertyType: DS.attr(),
  image: DS.attr(),
  bedrooms: DS.attr(),
  description: DS.attr()
});
```
Agora temos um model que podemos usar para a implementação do Ember Data.

### Updating the Model Hook

Para usar nosso objeto Ember Data Model, precisamos atualizar a função `model` que [definimos anteriormente](../model-hook/) em nosso manipulador de rotas.
Elimine o array que está hard-coded e substitua-a pela seguinte chamada para o [Ember Data Store service](../../models/#toc_the-store-and-a-single-source-of-truth).
[Store service](http://emberjs.com/api/data/classes/DS.Store.html) é injetado em todas as routes e components no Ember. É a interface principal que você usará para interagir com Ember Data.
Nesse caso, chame a função [`findAll`](http://emberjs.com/api/data/classes/DS.Store.html#method_findAll) na `store` e passe como parâmetro o nome do model `rental` recêm criado.


```app/routes/rentals.js{+5,-6,-7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18,-19,-20,-21,-22,-23,-24,-25,-26,-27,-28,-29,-30,-31,-32,-33}
import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return this.get('store').findAll('rental');
    return [{
      id: 'grand-old-mansion',
      title: 'Grand Old Mansion',
      owner: 'Veruca Salt',
      city: 'San Francisco',
      propertyType: 'Estate',
      bedrooms: 15,
      image: 'https://upload.wikimedia.org/wikipedia/commons/c/cb/Crane_estate_(5).jpg',
      description: "This grand old mansion sits on over 100 acres of rolling hills and dense redwood forests."
    }, {
      id: 'urban-living',
      title: 'Urban Living',
      owner: 'Mike TV',
      city: 'Seattle',
      propertyType: 'Condo',
      bedrooms: 1,
      image: 'https://upload.wikimedia.org/wikipedia/commons/0/0e/Alfonso_13_Highrise_Tegucigalpa.jpg',
      description: "A commuters dream. This rental is within walking distance of 2 bus stops and the Metro."
    }, {
      id: 'downtown-charm',
      title: 'Downtown Charm',
      owner: 'Violet Beauregarde',
      city: 'Portland',
      propertyType: 'Apartment',
      bedrooms: 3,
      image: 'https://upload.wikimedia.org/wikipedia/commons/f/f7/Wheeldon_Apartment_Building_-_Portland_Oregon.jpg',
      description: "Convenience is at your doorstep with this charming downtown rental. Great restaurants and active night life are within a few feet."
    }];
  }
});
```

When we call `findAll`, Ember Data will attempt to fetch rentals from `/api/rentals`.
If you recall, in the section titled [Installing Addons](../installing-addons/) we set up an adapter to route data requests through `/api`.

You can read more about Ember Data in the [Models section](../../models/).

Since we have already set up Ember Mirage in our development environment, Mirage will return the data we requested without actually making a network request.

When we deploy our app to a production server,
we will likely want to replace Mirage with a remote server for Ember Data to communicate with for storing and retrieving persisted data.
A remote server will allow for data to be shared and updated across users.
