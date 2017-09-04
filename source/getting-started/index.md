Começar com Ember é fácil. Projetos em Ember são criados e gerenciados
pelo Ember CLI, nossa ferramenta de linha de comando.
Com essa ferramenta você tem:


* Gerenciamento automático dos assets (incluindo concatenação, minificação e controle de versão).
* Geradores para ajudar a criar componentes, rotas e muito mais.
* Uma estrutura de projeto padrão, tornando mais fácil entender aplicações Ember existentes.
* Suporte a Javascript ES2015/ES6 através do projeto [Babel](http://babeljs.io/docs/learn-es2015/). O que inclui suporte para [JavaScript modules](http://exploringjs.com/es6/ch_modules.html), que são usados ao longo deste guia.
* Uma estrutura completa de testes automatizados com [QUnit](https://qunitjs.com/).
* A habilidade de usufruir de um crescente ecossistema de [Ember Addons](https://emberobserver.com/).

## Dependências

### Git

Ember requer que o Git esteja instalado para gerenciar muitas de suas dependências.
Git já vem instalado no Mac OS e na maioria das distribuições Linux.
Usuários de Windows podem baixar e executar [este instalador do Git](http://git-scm.com/download/win).


### Node.js e npm

Ember CLI foi criado em JavaScript e requer a versão LTS mais recente de [Node.js](https://nodejs.org/)
runtime. Ele também precisa de dependências disponíveis através do [npm](https://www.npmjs.com/).
npm são pacotes construídos com Node.js, então, se seu computador tem Node.js instalado, você está pronto para começar.

Se você não tem certeza que tem Node.js instalado ou a versão correta, rode esse comando em seu terminal:

```bash
node --version
npm --version
```

Se você receber um erro *"command not found"* ou tiver uma versão desatualizada do Node:

* Usuários de Windows ou Mac podem baixar e rodar [esse instalador Node.js](http://nodejs.org/en/download/).
* Usuários de Mac podem instalar o Node usando [Homebrew](http://brew.sh/). Depois de instalar o Homebrew, execute `brew install node` para instalar o Node.js.
* Usuários de Linux podem usar [esse guia para a instalação de Node.js no Linux](https://nodejs.org/en/download/package-manager/).

Se você estiver com uma versão desatualizada do npm, execute `npm install -g npm`.

### Watchman (opcional)

No Mac e Linux, você pode melhorar a performance da exibição de arquivos instalando [Watchman](https://facebook.github.io/watchman/docs/install.html).

### PhantomJS (opcional)

Você pode rodar seus testes através do seu terminal com PhantomJS, sem a necessidade de um browser ser aberto. Veja as [instruções de download do PhantomJS](http://phantomjs.org/download.html).

## Instalação

Instalando Ember usando npm:

```bash
npm install -g ember-cli
```

Para verificar se a instalação foi bem sucedida, rode em seu terminal:

```bash
ember -v
```

Se um número de versão for exibido, você está pronto para começar a usar Ember.
