Bem-vindo ao Tutorial do Ember!
Este tutorial destina-se a apresentar conceitos básicos para criar um aplicativo profissional com Ember.
Se você ficar com dúvida em qualquer ponto durante o tutorial, sinta-se à vontade para baixar [https://github.com/ember-learn/super-rentals](https://github.com/ember-learn/superrentals), esse é o aplicativo completo construído neste tutorial.

Você vai precisar instalar a última versão do `ember-cli` seguindo o [Guia Inicial](../../getting-started/quick-start/#toc_install-ember) na seção "Instalando Ember".

Ember CLI, é uma interface de linha de comando do Ember, fornece uma estrutura de projeto padrão, um conjunto de ferramentas de desenvolvimento e um sistema de complemento.
Isso permite que os desenvolvedores Ember se concentrem na construção de aplicativos, em vez de criar estruturas para executar.
No terminal, digite `ember -help` isso mostra todos os comandos disponíveis no Ember CLI. Para obter mais informações sobre um comando específico, digite `ember help <command-name>`.

## Criando uma nova Aplicação

Para criar um novo projeto usando o Ember CLI, use o comando `new`. Já pensando na próxima seção, você pode criar um aplicativo chamado `super-rentals`.

```shell
ember new super-rentals
```
Um novo projeto será criado dentro do seu diretório atual. Agora você pode ir ao seu diretório do projeto `super-rentals` e começar a trabalhar nele.

```shell
cd super-rentals
```

## Estrutura de pastas e arquivos

O comando `new` cria um projeto com essa estrutura de pastas e arquivos:

```text
|--app
|--config
|--node_modules
|--public
|--tests
|--vendor

<other files>

ember-cli-build.js
package.json
README.md
testem.js
```

Vamos dar uma olhada nas pastas e arquivos que o Ember CLI gerou.

**app**: É onde são salvas as pastas e arquivos para models, components, routes, templates e styles na sua aplicação.

**config**: Esse diretório contém `environment.js` onde você pode definir configurações para sua aplicação.

**node_modules / package.json**: Essa pasta e arquivo são do npm. Npm é um gerenciador de pacotes para Node.js.
Ember é construído com Node e usa uma variedade de módulos Node.js para executar. O arquivo `package.json` contém a lista de dependências npm para seu aplicativo. Qualquer Ember CLI Addons que você instale também aparecerá neste arquivo. Os pacotes listados no `package.json` estão instalados na pasta `node_modules`.



**public**: Essa pasta contém recursos como imagens e fontes.

**vendor**: Essa pasta é onde são salvas as dependências front-end (como JavaScript ou CSS) que não são gerenciados pelo Bower.

**tests**: Todos os testes automatizados como `unit`, `integrations` e `acceptance` são salvos nesta pasta.

**testem.js**: Ember CLI roda os testes com **testem** configurado em `testem.js`, ele funciona integrado com **QUnit** e **Mocha**.

**ember-cli-build.js**: Esse arquivo configura como Ember CLI deve construir sua aplicação.

## ES6 Modules

If you take a look at `app/router.js`, you'll notice some syntax that may be
unfamiliar to you.

```app/router.js
import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
});

export default Router;
```

Ember CLI uses ECMAScript 2015 (ES2015 for short or previously known as ES6) modules to organize application
code.
For example, the line `import Ember from 'ember';` gives us access to the actual
Ember.js library as the variable `Ember`. And the `import config from
'./config/environment';` line gives us access to our app's configuration data
as the variable `config`. `const` is a way to declare a read-only variable to make
sure it is not accidentally reassigned elsewhere. At the end of the file,
`export default Router;` makes the `Router` variable defined in this file available
to other parts of the app.


## The Development Server

Once we have a new project in place, we can confirm everything is working by
starting the Ember development server:

```shell
ember server
```

or, for short:

```shell
ember s
```

If we navigate to [`http://localhost:4200`](http://localhost:4200), we'll see the default welcome screen.
When we edit the `app/templates/application.hbs` file, we'll replace that content with our own.

![default welcome screen](../../images/ember-cli/default-welcome-page.png)

The first thing we want to do in our new project is to remove the welcome screen.
We do this by simply opening up the application template file located at `app/templates/application.hbs`.

Once open, remove the component labeled `{{welcome-page}}`.
The application should now be a completely blank canvas to build our application on.

```app/templates/application.hbs{-1,-2,-3}
{{!-- The following component displays Ember's default welcome message. --}}
{{welcome-page}}
{{!-- Feel free to remove this! --}}

{{outlet}}

```
