Participar de uma comunidade de desenvolvimento web pode ser um desafio por si só, especialmente quando todos os recursos que você visita assumem que você está familiarizado com outras tecnologias que você não conhece.

Nosso objetivo é ajuda-lo evitando essa confusão e destravá-lo o mais rápido possível; considere-nos seu amigo da internet.

## CDN
Content Delivery Network (Rede de Fornecimento de Conteúdo)

Normalmente é um serviço pago, utilizado para que você obtenha ótima performance para seu aplicativo. Muitas CDNs agem como proxies de cache do seu servidor de origem; alguns requerem que os assets seja armazenados neles. Eles dão a você uma URL para cada recurso em seu aplicativo. Essa URL irá resolver de forma diferente para cada usuário dependendo de onde eles estão navegando.

Nos bastidores, a CDN distribuirá o seu conteúdo geograficamente, com o objetivo de que os usuários finais possam buscar o contéudo com a menor latência possível. Por exemplo, se um usuário está na Índia, eles provavelmente receberão conteúdo da India mais rápido do que dos Estados Unidos.


## CoffeeScript, TypeScript
São duas linguagens que compilam para JavaScript. Você pode escrever seu código usando a sintaxe que elas oferecem e, quando finalizado, você compila seu TypeScript ou CoffeeScript para Javascript.

[CoffeeScript vs TypeScript](http://www.stoutsystems.com/articles/coffeescript-versus-typescript/)


## Navegadores Evergreen
Navegadores que atualizam automaticamente (sem intervenção do usuário).

[Navegadores Evergreen](http://tomdale.net/2013/05/evergreen-browsers/)


## ES3, ES5, ES5.1, ES6 (vulgo ES2015), etc
ES é um acrônimo para ECMAScript, a especificação sobre a qual JavaScript se baseia. O número que acompanha é a versão da especificação.

A maioria dos navegadores suporta pelo menos ES5, e alguns até suportam ES6 (vulgo ES2015). Você pode checar suporte de cada navegador (incluindo o seu) aqui:

* [Suporte ES5](http://kangax.github.io/compat-table/es5/)
* [Suporte ES6](http://kangax.github.io/compat-table/es6/)

[ECMAScript](https://en.wikipedia.org/wiki/ECMAScript)


## LESS, Sass
Tanto LESS e Sass são tipos de pré processadores de CSS capazes de dar-lhe muito mais controle sobre o seu CSS. Durante o processo de construção (build process), os recursos do LESS ou Sass serão compilados para CSS comum (que pode ser executado em um navegador).

[Comparação Sass/Less](https://gist.github.com/chriseppstein/674726)


## Linter, linting
Uma ferramenta de validação que checa por problemas comuns em seu código JavaScript. Você geralmente usuaria isso em seu processo de construção (build process) para forçar qualidade na sua base de código. Um bom exemplo é algo que checa por: *ter certeza que você colocou todos os pontos e vírgulas*.

Um exemplo de algumas das opções que você pode configurar:
[ESLint](http://eslint.org/docs/rules/)
[JSlint](http://jshint.com/docs/options/)


## Polyfill
Esse é um conceito que normalmente significa prover código Javascript que testa por funcionalidades não implementadas (protótipos não definidos, etc) e "preenchem" elas provendo uma implementação.


## Promise (Promessa)
Chamadas assíncronas normalmente retornam uma promessa (ou deferido). Este é um objeto que tem um estado: podendo retornar manipuladores para quando ele for completado ou rejeitado.

Ember faz uso disso em lugares como na chamada de um model em uma rota. Até que a promise finalize, Ember é capaz de colocar a rota em um estado de "carregando".

* [Especificação completa das Promises/A+ no JavaScript](https://promisesaplus.com/)
* [emberjs.com - A word on promises](http://emberjs.com/guides/routing/asynchronous-routing/#toc_a-word-on-promises)


## SSR
Server-Side Rendering (Renderização do Lado Servidor)

[Por dentro do FastBoot: A estrada para a renderização do lado do servidor (em inglês)](http://emberjs.com/blog/2014/12/22/inside-fastboot-the-road-to-server-side-rendering.html)


## Transpile (Transpilação)
Quando relacionado a JavaScript, isso tem a ver com o processo de construção (build process) que "transpila" (converte) seu código JavaScript com sintaxe ES6 em JavaScript suportado pelos navegadores atuais.

Além de ES6, você encontrará muito conteúdos sobre compilação/transpilação CoffeeScript, uma linguagem que pode ser "compilada" para JavaScript.

* Ember CLI usa especificamente [Babel](https://babeljs.io/) através do plugin [ember-cli-babel](https://github.com/babel/ember-cli-babel).


## UI
UI siginifica Interface do Usuário e é essecialmente o que o usuário encherga e interage em um dispositivo. Em termos da web, a UI é geralmente composta por uma série de páginas contendo elementos visuais como botões e ícones, com os quis um usuário pode interagir para executar uma função específica.


## Shadow DOM (DOM sombra)
Não confunda com Virtual DOM. Shadow DOM ainda é um trabalho em andamento, mas basicamente uma maneira proposta de ter um DOM "isolado" encapsulado no DOM do seu aplicativo.

Criar um "widget" reutilizável ou um controle reutilizável pode ser um bom caso de uso para isso. Navegadores implementam alguns dos seus controles usando suas próproas versões um shadow DOM.

* [W3C Working Draft](http://www.w3.org/TR/shadow-dom/)
* [Que diabos é Shadow DOM?](http://glazkov.com/2011/01/14/what-the-heck-is-shadow-dom/)


## Virtual DOM (DOM Virtual)
Não confunda com Shadow DOM. O conceito de um DOM virtual é abstrair seu código (ou no nosso caso, Ember), evitando de usar o DOM do navegador, em favor de um DOM "virtual" que pode facilmente ser acessado para leitura/escrita ou mesmo serializado.
