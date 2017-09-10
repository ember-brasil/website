O Ember CLI é fornecido com suporte para gerenciar o ambiente da sua aplicaçãp. O Ember CLI configurará um arquivo de configuração de ambiente padrão no `config / environment`. Neste arquivo, você pode definir um objeto `ENV` para cada ambiente, atualmente é limitado a três: desenvolvimento, teste e produção.

O objecto ENV contém três chaves importantes:

  - `EmberENV` pode ser usado para definir o Ember feature flags (see the [Feature Flags guide](../feature-flags/)).
  - `APP` pode ser usado para as flags/opções para sua instância de aplicação.
  - `environment` contém o nome do ambiente atual (`desenvolvimento`,`produção` ou `teste`).

Você pode acessar esta variável de ambiente no código da sua aplicação importando do `your-application-name/config/environment`.

Por exemplo:

```js
import ENV from 'your-application-name/config/environment';

if (ENV.environment === 'development') {
  // ...
}
```
