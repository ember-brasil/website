Atualmente, nossa aplicação está usando dados fake em nossa listagem de imóveis para alugar, que estão definidas no manipulador de route `rental`.
À medida que nossa aplicação cresce, precisaremos persistir nossos imóveis em um servidor remoto para facilitar operações de consulta, criação e edição desses dados.

O Ember vem com uma biblioteca para gerenciamento de dados chamada [Ember Data](https://github.com/emberjs/data), ela nos ajuda a persistir e consultar dados de um servidor remoto.

O Ember Data precisa que especifiquemos a estrutura dos dados que vamos utilizar em nossa aplicação, estendendo [`DS.Model`](http://emberjs.com/api/data/classes/DS.Model.html).

Vamos usar o Ember CLI para gerar nosso Ember Data Model com o nome `rental`:

```shell
ember g model rental
```
Serão criado dois arquivos, um com nosso model e outro com nosso teste.

```shell
installing model
  create app/models/rental.js
installing model-test
  create tests/unit/models/rental-test.js
```
Se abrirmos o arquivo `/app/models/rental.js`, veremos uma classe vazia que estende [`DS.Model`](http://emberjs.com/api/data/classes/DS.Model.html):

```app/models/rental.js
import DS from 'ember-data';

export default DS.Model.extend({

});
```

Vamos definir a estrutura do nosso model `rental` usando os atributos [usados anteriormente](../model-hook/) em nosso array de imóveis que está hard-coded em nosso manipulador de route - _title_, _owner_, _city_, _property type_, _image_ , _bedrooms_ e _description_.
Defina os atributos com a função [`DS.attr()`](http://emberjs.com/api/data/classes/DS.html#method_attr).
Para obter mais informações sobre os atributos do Ember Data, leia a seção [Definição de atributos](../../models/ define-models/#toc_defining-attributes).


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

### Atualizando o Model Hook

Para usar nosso model, precisamos atualizar a função `model` que [definimos anteriormente](../model-hook/) em nosso manipulador de rotas.
Remova o array que está hard-coded e substitua pela chamada de [Ember Data Store](../../models/#toc_the-store-and-a-single-source-of-truth).

[Service Store](http://emberjs.com/api/data/classes/DS.Store.html) é injetado automaticamente em todas as routes e components no Ember. É a principal interface que usaremos para interagir com Ember Data.
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

Quando chamamos `findAll`, o Ember Data tentará buscar os imóveis em `/api/rentals`.
Se você lembrar, na seção chamada [Instalando Addons](../installing-addons/), configuramos um adapter para nossas routes solicitarem requisições em `/api`.

Você pode ler mais sobre Ember Data na seção [Model](../../models/).

Uma vez que já criamos o Ember Mirage no nosso ambiente de desenvolvimento, o Mirage retornará os dados que solicitamos, sem fazer requisições na rede.

Quando publicarmos nossa aplicação em um servidor de produção, iremos substituir o Mirage por um servidor remoto, para que Ember Data possa manipular dados reais.
