You can inspect your models by clicking on the `Data` tab. Check out [Building a Data Custom Adapter][building-data-adapter] below if you maintain your own persistence library. 
[building-data-adapter]:#toc_building-a-data-custom-adapter

Você pode inspecional seus modelos clicando na tab `Data`. Check

Quando você abrir a tab Data, você verá a lista dos tipos de modelos definidos em sua aplicação, junto com o número de carregamentos registrados. O Inspetor mostra os registros de recarregamentos quando você clica no tipo do modelo.

<img src="../../images/guides/ember-inspector/data-screenshot.png" width="680"/>

### Inspecionando Registros

Each row in the list corresponds to one record. The first four model attributes are shown in the list view. Clicking on the record will open the Object Inspector for that record, and display all attributes.

Cada linha na lista corresponde a um registro. Os quatro primeiros modelos de atributo são mostrados na lita da View. Clicando em registros irá abrir o Objeto de Inspeção para esse registro e mostrar todos os atributos.

<img src="../../images/guides/ember-inspector/data-object-inspector.png"
width="680"/>

### Record States and Filtering

The Data tab is kept in sync with the data loaded in your application.
Any record additions, deletions, or changes are reflected immediately. If you have unsaved
records, they will be displayed in green by clicking on the New pill.

<img src="../../images/guides/ember-inspector/data-new-records.png"
width="680"/>

Click on the Modified pill to display unsaved record modifications.

<img src="../../images/guides/ember-inspector/data-modified-records.png"
width="680"/>

Você tambem pode filter os registros digitando uma query no campo de busca.

### Building a Data Custom Adapter
### Criando um Adaptador Personalizado de Dados

You can use your own data persistence library with the Inspector. Build a [data adapter][data-adapter-docs], and you can inspect your models
using the Data tab. Use [Ember Data's data adapter][ember-data-data-adapter] as an example for how to build your data adapter.

Você pode user sua própria biblioteca de persistencia de dados com o Inspetor. Criando um data adapter][data-adapter-docs], e você pode inspensonar seus modelos usando a tab Daya. Usando [Ember Data's data adapter][ember-data-data-adapter] como um exemplo de como construir seu adaptador de dados.

[data-adapter-docs]: https://github.com/emberjs/ember.js/blob/3ac2fdb0b7373cbe9f3100bdb9035dd87a849f64/packages/ember-extension-support/lib/data_adapter.js
[ember-data-data-adapter]:https://github.com/emberjs/data/blob/d7988679590bff63f4d92c4b5ecab173bd624ebb/packages/ember-data/lib/system/debug/debug_adapter.js
