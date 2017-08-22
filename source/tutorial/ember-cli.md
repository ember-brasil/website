Bem-vindo ao Tutorial do Ember!
Este tutorial destina-se a apresentar conceitos básicos para criar um aplicativo profissional com Ember.
Se você ficar com dúvida em qualquer ponto durante o tutorial, sinta-se à vontade para baixar [https://github.com/ember-learn/super-rentals](https://github.com/ember-learn/superrentals), esse é o aplicativo completo construído neste tutorial.

Você vai precisar instalar a última versão do `ember-cli` seguindo o [Guia Inicial](../../getting-started/quick-start/#toc_install-ember) na seção "Instalando Ember".

Ember CLI, é uma interface de linha de comando do Ember, fornece uma estrutura de projeto padrão, um conjunto de ferramentas de desenvolvimento e um sistema de complemento.
Isso permite que os desenvolvedores Ember se concentrem na construção de aplicativos, em vez de criar estruturas para executar.
No terminal, digite `ember -help` isso mostra todos os comandos disponíveis no Ember CLI. Para obter mais informações sobre um comando específico, digite `ember help <command-name>`.

## Creating a New App

To create a new project using Ember CLI, use the `new` command. In preparation
for the tutorial in the next section, you can make an app called `super-rentals`.

```shell
ember new super-rentals
```

A new project will be created inside your current directory. You can now go to
your `super-rentals` project directory and start working on it.

```shell
cd super-rentals
```

## Directory Structure

The `new` command generates a project structure with the following files and
directories:

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

Let's take a look at the folders and files Ember CLI generates.

**app**: This is where folders and files for models, components, routes,
templates and styles are stored. The majority of your coding on an Ember
project happens in this folder.

**config**: The config directory contains the `environment.js` where you can
configure settings for your app.

**node_modules / package.json**: This directory and file are from npm.
npm is the package manager for Node.js. Ember is built with Node and uses a
variety of Node.js modules for operation. The `package.json` file maintains the
list of current npm dependencies for the app.  Any Ember CLI
addons you install will also show up here. Packages listed in `package.json`
are installed in the node_modules directory.

**public**: This directory contains assets such as images and fonts.

**vendor**: This directory is where front-end dependencies (such as JavaScript
or CSS) that are not managed by Bower go.

**tests / testem.js**: Automated tests for our app go in the `tests` folder,
and Ember CLI's test runner **testem** is configured in `testem.js`.

**ember-cli-build.js**: This file describes how Ember CLI should build our app.

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
