Este guia vai te ensinar como construir, do zero, uma aplicação simples usando Ember.

Nós vamos cobrir estas etapas:


1. Instalando o Ember.
2. Criando uma nova aplicação.
3. Definindo uma rota.
4. Escrevendo um componente de UI (User Interface / Interface do Usuário).
5. Construindo (building) sua aplicação para ser instalado (deployed) em produção.


## Instalando o Ember

Você pode instalar o Ember com um único comando usando npm, o gerenciador de pacotes do Node.js.
Digite o seguinte comando em seu terminal:

```sh
npm install -g ember-cli
```

Não tem npm instalado? [Aprenda como instalar o Node.js e npm aqui][npm].
Para uma lista completa das dependências necessárias para um projeto Ember CLI, consulte nosso guia de [instalação de Ember](../../getting-started/).

[npm]: https://docs.npmjs.com/getting-started/installing-node

## Criando uma nova aplicação

Uma vez instalado Ember através do npm, você terá acesso a um novo comando em seu terminal: `ember`.
Você pode usar o comando `ember new` para criar uma nova aplicação.

```sh
ember new ember-quickstart
```
Este comando irá criar um novo diretório chamado `ember-quickstart`
e configurar uma nova aplicação Ember dentro dela. De cara, seu aplicativo irá incluir:

* Um servidor para desenvolvimento.
* Compilação de Template.
* Minificação de arquivos JavaScript e CSS.
* Funcionalidades ES2015 através da biblioteca Babel.

Ao fornecer, em um pacote integrado, tudo que você precisa para construir aplicações web prontas para produção,
Ember faz com que seja uma moleza começar novos projetos.

Vamos ver se tudo está funcionando corretamente. No seu terminal acesse o diretório da aplicação criada
e inicie o servidor de desenvolvimento, digitando:

```sh
cd ember-quickstart
ember server
```

Após alguns segundos, você deverá ver a seguinte saída no seu terminal:

```text
Livereload server on http://localhost:49152
Serving on http://localhost:4200/
```

(Se quiser parar o servidor a qualquer momento, pressione Ctrl-C no seu terminal)

Acesse [`http://localhost:4200`](http://localhost:4200) no seu navegador.
Você deverá ver uma página de boas-vindas do Ember. Parabéns!
Você acabou de criar sua primeira aplicação em Ember.

Vamos criar um novo template, usando o comando `ember generate`.

```sh
ember generate template application
```

O template `application` estará sempre na tela, enquanto o usuário tiver com sua aplicação carregada.
No seu editor, abra `app/templates/application.hbs` e adicione o seguinte:

```app/templates/application.hbs
<h1>PeopleTracker</h1>

{{outlet}}
```

Observe que o Ember detecta o novo arquivo e automaticamente recarrega
a página para você em segundo plano. Você verá que a página de boas-vindas
foi substituída por "PeopleTracker". Você também adicionou um `{{outlet}}` para esta página, o que significa que qualquer rota aninhada será processada neste local.

## Definindo uma Rota

Vamos fazer uma aplicação que mostra a lista de cientistas. Para fazer isso,
o primeiro passo é criar uma route. Por enquanto, você pode pensar em Routes como
sendo diferentes páginas que compõe sua aplicação.

Ember possui _generators_ que automatizam códigos que são usados repetidamente em tarefas comuns.
Para criar uma route de cientistas, digite em seu terminal:

```sh
ember generate route scientists
```

Você verá uma saída como essa em seu terminal:

```text
installing route
  create app/routes/scientists.js
  create app/templates/scientists.hbs
updating router
  add route scientists
installing route-test
  create tests/unit/routes/scientists-test.js
```
Isso é o Ember dizendo que criou:

1. Um template a ser exibido quando o usuário acessa a URL `/scientists`.
2. Um objeto `Route` (Rota) que busca o model usado por esse template.
3. Uma inserção da rota de `scientists` no router da aplicação (localizado em `app/router.js`).
4. Um teste unitário para esta rota.

Abra o template recém-criado em `app/templates/scientists.hbs` e adicione o seguinte HTML:

```app/templates/scientists.hbs
<h2>List of Scientists</h2>
```

No seu navegador, acesse
[`http://localhost:4200/scientists`](http://localhost:4200/scientists). Você verá a tag `<h2>`
que você colocou no template `scientists.hbs`, logo abaixo da tag
`<h1>` do template `application.hbs`.

Agora que temos o template `scientists` sendo renderizado, vamos dar a ele alguns
dados para mostrar. Para isso especificamos um _model_ para aquela rota
editando o arquivo `app/routes/scientists.js`.

Vamos pegar o código criado para nós pelo generator e adicionar o método `model()`
ao `Route`:

```app/routes/scientists.js{+4,+5,+6}
import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return ['Marie Curie', 'Mae Jemison', 'Albert Hofmann'];
  }
});
```
(Este código exemplifica usos das funcionalidades mais recentes do JavaScript, algumas talvez você não esteja muito familiarizados.
Saiba mais com este [resumo das funcionalidades mais novas do JavaScript][es6-bullet-points]).

[es6-bullet-points]: https://ponyfoo.com/articles/es6

No método `model()` de uma rota, você retorna qualquer dado que queira tornar
disponível para o template. Se precisar buscar dados assíncronamente, o
método `model()` suporta qualquer biblioteca que use [JavaScript Promises][promises].

[promises]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise

Agora vamos dizer ao Ember como transformar aquele array de strings em HTML. Abra
o template `scientists` e adicione um código Handlebars que itera o array e o imprima:

```app/templates/scientists.hbs{+3,+4,+5,+6,+7}
<h2>List of Scientists</h2>

<ul>
  {{#each model as |scientist|}}
    <li>{{scientist}}</li>
  {{/each}}
</ul>
```

Aqui, usamos o helper `each` para executar um loop sobre cada item do array
que fornecemos no `model()` hook e imprimímos o valor dentro de um elemento `<li>`.

## Criando um UI Component

Conforme sua aplicação cresce e você percebe que está repetindo elementos de interface
em diversas páginas (ou usando o mesmo elemento várias vezes na mesma página), o
Ember facilita a criação de componentes reutilizáveis.

Vamos criar um component `people-list` que podemos usar
para mostrar uma lista de pessoas em vários lugares.

Como de costume, há um generator que facilita essa criação para nós. Crie um
novo component digitando em seu terminal:

```sh
ember generate component people-list
```

Copie e cole o template de `scientists` no template do component `people-list`
e edite-o para ter a seguinte aparência:

```app/templates/components/people-list.hbs
<h2>{{title}}</h2>

<ul>
  {{#each people as |person|}}
    <li>{{person}}</li>
  {{/each}}
</ul>
```

Observe que mudamos o título de uma string fixa ("List of Scientists")
para uma propriedade dinâmica (`{{title}}`). Nós também renomeamos `scientist`
para um termo mais genérico chamado `person`, diminuindo o acoplamento do nosso
component onde ele é usado.

Salve esse template e volte para o template de `scientists`. Troque todo
o nosso código anterior para a nossa nova versão componentizada. Components são como
tags HTML, mas ao invés de usarem angle brackets (`<tag>`) eles usam
double curly braces (`{{component}}`). Vamos definir em nosso component:

1. Qual o título usar, através do atributo `title`.
2. Qual array de pessoas usar, através do atributo `people`. Nós
  iremos passar o `model` desta rota, como uma lista de pessoas.

```app/templates/scientists.hbs{-1,-2,-3,-4,-5,-6,-7,+8}
<h2>List of Scientists</h2>

<ul>
  {{#each model as |scientist|}}
    <li>{{scientist}}</li>
  {{/each}}
</ul>
{{people-list title="List of Scientists" people=model}}
```

Volte para o seu navegador e você verá que a interface parece idêntica.
A única diferença é que agora nós componentizamos nossa lista em uma
versão que é mais reutilizável e mais passível de manutenção.

Você pode ver isso se você criar uma nova rota que mostra uma lista diferente de `people`.
Vamos deixar isso como um desafio para você:
tente criar uma route de `programmers` que mostra uma lista de programadores famosos.
Re-usando o component `people-list`, você pode fazer isso com praticamente quase nenhum código.

## Eventos de clique

Até o momento, sua aplicação está apenas listando dados mas não há nenhuma forma do
usuário interagir com essa informação.
Em aplicações web, muitas vezes você precisa saber quando o usuário executou um
evento de click ou hover. Ember torna essa tarefa muito fácil.
Primeiro adicione um helper `action` à tag `li` em nosso component `people-list`.

```app/templates/components/people-list.hbs{-5,+6}
<h2>{{title}}</h2>

<ul>
  {{#each people as |person|}}
    <li>{{person}}</li>
    <li {{action "showPerson" person}}>{{person}}</li>
  {{/each}}
</ul>
```

O helper `action` permite você adicionar event listeners aos elementos e chamar funções nomeadas.
Por padrão, o helper `action` adiciona automaticamente um event listener de `click`,
mas pode ser utilizado para "ouvir" qualquer evento naquele elemento.
Agora, quando o elemento `li` é clicado, uma função `showPerson` será chamada do objeto
`actions` no component `people-list`.
Pense nisso como se estivéssemos chamando `this.actions.showPerson(person)` a partir de nosso template.

Para lidar com a chamada dessa função, você precisa modificar o component `people-list`
para adicionar a função a ser chamada.
No componente, adicione um objeto `actions` com uma função `showPerson` que
exibe o primeiro argumento através de um alert.


```app/components/people-list.js{+4,+5,+6,+7,+8}
import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
    showPerson(person) {
      alert(person);
    }
  }
});
```

Agora no navegador, quando o usuário clica no nome de um cientista, essa função é chamada
e o nome da pessoa é exibido via um alert.

## Building para produção

Agora que escrevemos nossa aplicação e verificamos que funciona
em modo de desenvolvimento, é hora de prepará-lo para o deploy. Para fazer isso,
execute o seguinte comando em seu terminal:

```sh
ember build --env production
```

O comando `build` agrupa todos os assets que compõe sua
aplicação&mdash;JavaScript, templates, CSS, fontes web, imagens, e
muito mais.

Nesse caso, dissemos ao Ember para fazer o build para o ambiente de produção
através da flag `--env`. Isso cria um pacote otimizado que está pronto para upload
para o seu servidor de hospedagem. Uma vez que o build termina, você encontrará
todos os assets concatenados e minificados no diretório `dist/` da sua aplicação.

A comunidade Ember valoriza a colaboração e cria ferramentas comuns que
todos dependem. Se você estiver interessado em "deployar" sua aplicação
para produção de forma rápida e confiável, confira o addon [Ember CLI
Deploy][ember-deploy].

[ember-deploy]: http://ember-cli-deploy.com/

Se você fizer o deploy da sua aplicação em um servidor web Apache, primeiro crie um novo virtual host para a aplicação.
Para garantir que todas as rotas sejam tratadas pelo index.html,
adicione a seguinte diretiva à configuração do virtual host da aplicação ```FallbackResource index.html```
