
O Ember CLI por padrão utiliza o [Babel.js](https://babeljs.io/) para permitir que você use o JavaScript de amanhã, hoje!

Isso permitirá que você use os recursos mais recentes da linguagem e que eles sejam transformados para JavaScript podendo ser executados em todos os navegadores suportados.
Isso significa, gerar código compatível com ES5 que irá funcionar em qualquer navegador moderno, de volta ao Internet Explorer 9.

Mas, o código do ES5 normalmente é mais verboso do que o JavaScript original, e ao longo do tempo, como os navegadores ganham a habilidade de executar os novos recursos em Javascript e os navegadores mais antigos perdem usuários, muitos usuários realmente não querem esse código detalhado, pois aumenta o tamanho do aplicativo e o tempo de carregamento.

É por isso que o Ember CLI expõe uma maneira de configurar quais navegadores o seu aplicativo pode suportar.
Assim, é possível descobrir automaticamente quais recursos são suportados pelos navegadores que você está utilizando, e aplica o conjunto mínimo de transformações possíveis para o seu código.

Se você abrir o `config/targets.js`, você encontrará o seguinte código:

```config/targets.js
module.exports = {
  browsers: [
    'ie 9',
    'last 1 Chrome versions',
    'last 1 Firefox versions',
    'last 1 Safari versions'
  ]
};
```

Essa configuração padrão corresponde ao conjunto mais amplo de navegadores que o próprio Ember.js suporta.
No entanto, se o seu aplicativo não precisa mais suportar o IE, você pode alterá-lo para:

```config/targets.js
module.exports = {
  browsers: [
    'last 1 edge versions',
    'last 1 Chrome versions',
    'last 1 Firefox versions',
    'last 1 Safari versions'
  ]
};
```

Desta forma, você fica com os navegadores que possuem suporte total para o ES2015 e ES2016.
Se você inspecionar o código compilado, verá que alguns recursos não são compilados no código ES5, como as arrow functions.

Este recurso é suportado por [Browserlist](https://github.com/ai/browserslist) e [Can I Use](http://caniuse.com/).
Estes websites rastreiam as estatísticas de uso dos navegadores, assim você pode fazer consultas complexas baseadas na base dos usuários de cada navegador.

Se você quer suportar todos os navegadores com mais de 4% de participação do mercado do Canadá, você pode ter as seguintes opções:

```config/targets.js
module.exports = {
  browsers: [
    '> 4% in CA'
  ]
};
```

É muito importante que você configure as opções da sua aplicação apropriadamente para que você obtenha uma aplicação mais rápida e menor possível.

As opções de build também podem ser aprimoradas de outras maneiras.

Alguns addons podem condicionalmente incluir polyfills somente se necessário.
Alguns linters podem emitir avisos ao usar recursos ainda não totalmente suportados em seus destinos.
Alguns addons podem até prefixar automaticamente propriedades CSS não suportadas.
