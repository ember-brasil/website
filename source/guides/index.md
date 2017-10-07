Bem-vindo ao guia do Ember.js! Esse documento irá levá-lo de um completo iniciante para um expert em Ember.js.

## O que é Ember?
Ember é um framework front-end JavaScript estruturado, que visa à ajudá-lo na construção de websites ricos e com interações complexos com o usuário. Ele vai fornecer aos desenvolvedores todos os recursos que são essenciais para gerenciar a complexidade de suas aplicações web modernas, bem como um kit de ferramentas de desenvolvimento integrado que permite uma interação rápida.

Essas são algumas das características que você irá conhece nesse guia:

* [Ember CLI](./configuring-ember/configuring-ember-cli/) - Um robusto kit de ferramentas de criação, desenvolvimento e build para aplicações Ember. Por todo esse guia você irá vê a seguinte instrução do Ember CLI ```$ ember <comando>```.
* [Rotas](./routing) - Essa é a parte central de uma aplicação Ember. Permite aos desenvolvedores verificar o estado da sua aplicação a partir de uma URL.
* [Template Engine](./templates/handlebars-basics/) - Utilize a sintaxe do Handlebars para escreve os templates da sua aplicação.
* [Data Layer](./models/) - O Ember Data provê uma comunicação consistente com APIs externas e com o gerenciamento dos estados da sua aplicação.
* [Ember Inspector](./models/) - Uma extensão para o navegador, um bookmarklet, para inspecionar sua aplicação em tempo de desenvolvimento. Também é útil para detectar aplicações feita com Ember, tente instalá-lo e abrir o site da [NASA website](https://www.nasa.gov/)!

## Organização
No lado esquerdo de cada página desse guia é um índice, ele é organizado em seções que podem ser expandidas para mostra outros tópicos. As seções e os tópicos de cada seção são ordenados com o seguinte conceito do básico ao avançado.

Esse guia contém uma explicação prática de como contruir uma aplicação com Ember, concentrado-se nos recursos mas utilizados do Ember.js. Para uma melhor compreensão da documentação, caracteríticas e da API do Ember utilize [Ember.js API documentation](http://emberjs.com/api/).

Esse guia inícia com uma explicação inicial do Ember, seguindo o tutorial você terá sua primeira aplicação feita com Ember. Ser você esta começando agora com Ember, recomendamos que você siga com essas duas primeiras seções do guia.

## Suposições
Enquanto tentamos deixar esse guia o mas iniciante possível, nós devemos estabelecer uma base para que o guia possa ser manter focado nas funcionalidades do Ember.js. Sempre que for introduzido um novo conceito iremos vincular sua documentação para uma melhor compreensão do que esta sendo feito.

Para um melhor aproveitamento desse guia você deverá ter um conhecimento razoável de:

* **HTML, CSS, JavaScript** - Para construção dos elementos das suas páginas webs. Você irá encontrar a documentação de cada dessas tecnologia em [Mozilla Developer Network][mdn].
* **Promises** - É a maneira nativa que você irá trabalhar com códigos assíncronos em códigos JavaScript. Para uma melhor compreensão utiliza a seguinte seção [Mozilla Developer Network][promises].
* **ES2015 Modules** - Para uma melhor compreensão da estrutura de projeto é importação de arquivos, se você estive confortável com [Ember CLI's][ember-cli].
* **ES2015 Sintaxe** - O Ember CLI utiliza o Babel.js por padrão para tira vantagem das novas especificações do JavaScript como Arrow Functions, template string, destructuring e muito mais. Você pode verificar em [Babel.js][babeljs] ou lê [Compreendendo ECMAScript 6][es6] online.

## Notas sobre performance em dispositivos movéis
Ember vai te ajudar a escreve mas rapidamente seu aplicativos, mas ele não irá impedir você de escreve um aplicativo lento. Isso é verdadeiro especialmente em dispositivos movéis. Para uma melhor experiência, é importante você medir o desempenho da sua aplicação o mas cedo possível e várias vezes durante o desenvolvimento em diferentes dispositivos movéis.

Sempre verifique ser você esta testando em um dispositivo movél real. Pois os simuladores de um computador oferecem um representação otimista do desempenho do seu aplicativo, o melhor é fazer os testes em dispositivos reais. Quanto mas dispositivos diferentes você utilizar para realizar os testes melhor será o resultado da sua aplicação.

Devido as limitações que os dispositivos movéis possuem como a conectividade de rede e á sua potência, o desempenho em dispositivos movéis raramente irá vim de graça. Você terá que integra o teste de desempenho no seu fluxo de desenvolvimento desde o início. Isso irá te ajudar a evitar erros na arquitetura do seu projeto que podem custa caro mas para frente é que são difíceis de consertar ser você nota apenas uma vez no seu aplicativo quando ele estive quase completo.

Em resumo:

1. Sempre teste em dispositivos reais.
2. Faça testes de performance desde o início e continue testado seu aplicativo durante todo o desenvolvimento dele.

## Para reporta um problema

Tipos, palavras que estão faltado, exemplo de códigos com erros são considerados erros de documentação. Ser você detectar qualquer um desses erros, ou quiser melhorar o guia existente, estamos felizes em ajudar você a nos ajudar!

Essas são algumas das maneira comuns de relatar um problema com o guia:

* Usando o ícone do lápis na parte superior direita de cada página do guia.
* Abrindo um pull request no [repósitório do projeto][gh-guides].

Ao clicar no ícone de lápis, você será levando para o editor do GitHub para a página do guia que você possa editá-lo imediatamente, usando a linguagem de marcação Markdown. Está é a maneira mas rápida de corrigir um erro de digitação, uma palavra que falta ou um erro em qualquer amostrar de código.

Ser você deseja fazer uma contribuição mas significativa, certifique-se de verificar a nossa lista de [issues][gh-guides-issues] para verificar ser o problema já esta sendo resolvido. Ser você não encontra um problema ativo, abra um novo.

Ser você tiver mas dúvidas ou perguntas sobre o processo de contribuição, verifique o nosso [guia de contribuição][gh-guides-contributing]. Ser ainda sim a sua dúvida persistir entre em com contato com ```#-team-learning``` no [grupo do Slack][slackin]

Boa sorte!

[ember-cli]: https://ember-cli.com/

[mdn]: https://developer.mozilla.org/en-US/docs/Web
[promises]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise
[js-modules]: http://jsmodules.io/
[babeljs]: https://babeljs.io/docs/learn-es2015/
[es6]: https://leanpub.com/understandinges6/read

[gh-guides]: https://github.com/emberjs/guides/
[gh-guides-issues]: https://github.com/emberjs/guides/issues
[gh-guides-contributing]: https://github.com/emberjs/guides/blob/master/CONTRIBUTING.md

[slackin]: https://ember-community-slackin.herokuapp.com/
