Enquanto estiver desenvolvendo sua aplicação Ember, você provavelmente encontrará cenários comuns que não são resolvidos pelo próprio Ember,
como autenticação ou a utilização de SASS nas suas folhas de estilo.
Ember CLI provê uma forma comum chamada [Ember Addons](#toc_addons) para a distribuição de bibliotecas reutilizáveis
para resolver estes problemas.
Adicionalmente você pode querer utilizar dependências de front-end como um framework CSS ou um datepicker Javascript que não são específicos de aplicações Ember.

## Addons

Ember Addons podem ser instalados usando [Ember CLI](http://ember-cli.com/extending/#developing-addons-and-blueprints)
(e.g. `ember install ember-cli-sass`).
Addons podem incluir outras dependências modificando o arquivo `bower.json` do seu projeto automaticamente.

Você pode encontrar listas de addons em [Ember Observer](http://emberobserver.com).

## Outros assets

Javascript de terceiros não disponível como um addon ou um pacote Bower devem ser colocados na pasta
`vendor/` do seu projeto.

Seus próprios assets (tais como `robots.txt`, `favicon`, fontes customizadas etc.) devem ser colocados na pasta
`public/` do seu projeto.

## Compilando Assets

Quanto você está usando dependências que não estão incluídas em um addon
você precisará instruir o Ember CLI para incluir seus assets na build.
Isto é feito usando o arquivo asset manifest `ember-cli-build.js`.
Você deve tentar importar apenas assets localizados nas pastas `bower_components` and `vendor`.

### Globais fornecidas por assets Javascript

As globais fornecidas por alguns assets (como `moment` no exemplo abaixo) podem ser usadas na sua aplicação
sem a necessidade de importá-las.
Forneça o caminho do asset como o primeiro e único argumento.

```ember-cli-build.js
app.import('bower_components/moment/moment.js');
```

Você precisará adicionar `"moment"` à seção `globals` em `.eslintrc.js` para prevenir erros de ESLint sobre
utilizar uma variável indefinida.

### Módulos JavaScript AMD

Forneça o caminho do asset como o primeiro argumento e a lista de módulos e exports como o segundo.

```ember-cli-build.js
app.import('bower_components/ic-ajax/dist/named-amd/main.js', {
  exports: {
    'ic-ajax': [
      'default',
      'defineFixture',
      'lookupFixture',
      'raw',
      'request'
    ]
  }
});
```

Agora você pode importá-los na sua aplicação. (ex. `import { raw as icAjaxRaw } from 'ic-ajax';`)

### Assets específicos de ambiente

Se você precisa utilizar assets diferentes em ambientes diferentes, especifique um objeto como o primeiro parâmetro.
A chave desse objeto deve ser o nome do ambiente e o nome deve ser o asset utilizado naquele ambiente.

```ember-cli-build.js
app.import({
  development: 'bower_components/ember/ember.js',
  production:  'bower_components/ember/ember.prod.js'
});
```

Se você precisa importar um asset em apenas um ambiente você pode colocar `app.import` em uma declaração `if`.
Para assets necessários durante testes, você deve usar também a opção `{type: 'test'}` para ter certeza de que
eles estão disponíveis em modo de teste.

```ember-cli-build.js
if (app.env === 'development') {
  // Only import when in development mode
  app.import('vendor/ember-renderspeed/ember-renderspeed.js');
}
if (app.env === 'test') {
  // Only import in test mode and place in test-support.js
  app.import(app.bowerDirectory + '/sinonjs/sinon.js', { type: 'test' });
  app.import(app.bowerDirectory + '/sinon-qunit/lib/sinon-qunit.js', { type: 'test' });
}
```

### CSS

Forneça o caminho do asset como o primeiro argumento:

```ember-cli-build.js
app.import('bower_components/foundation/css/foundation.css');
```

Todos os assets de estilo adicionados desta forma serão concatenados e sairão como `/assets/vendor.css`.

### Outros assets

Todos os assets localizados na pasta `public/` serão copiados sem modificações para o diretório final de saída `dist/`.

Por exemplo, um `favicon` localizado em `public/images/favicon.ico` será copiado para `dist/images/favicon.ico`.

Todos os assets de terceiros, incluídos ou manualmente em `vendor/` ou via gerenciador de pacotes como Bower, devem ser adicionados via `import()`.

Assets de terceiros que não forem adicionados via `import()` não estarão presentes na build final.

Por padrão, assets `import`ados serão copiados para `dist/` como são, com a estrutura do diretório existente mantida.

```ember-cli-build.js
app.import('bower_components/font-awesome/fonts/fontawesome-webfont.ttf');
```

Este exemplo criaria o arquivo da fonte em `dist/font-awesome/fonts/fontawesome-webfont.ttf`.

Você pode também informar opcionalmente ao `import()` para colocar o arquivo em um caminho diferente.
O exemplo seguinte copiará o arquivo para `dist/assets/fontawesome-webfont.ttf`.

```ember-cli-build.js
app.import('bower_components/font-awesome/fonts/fontawesome-webfont.ttf', {
  destDir: 'assets'
});
```

Se você precisa carregar certas dependências antes de outras, você pode setar a propriedade `prepend`
igual a `true` no segundo argumento de `import()`.
Isto vai adicionar a dependência no início do arquivo vendor em vez de no final, que é o comportamento padrão.

```ember-cli-build.js
app.import('bower_components/es5-shim/es5-shim.js', {
  type: 'vendor',
  prepend: true
});
```
