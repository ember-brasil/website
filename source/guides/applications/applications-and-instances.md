Toda aplicação Ember é representada por uma classe que estende [`Ember.Application`][1].
Essa classe é usada para declarar e configurar os muitos objetos que compõem sua aplicação.

A medida que sua aplicação é carregada, 
ele cria uma [`Ember.ApplicationInstance`][2] que é utilizada para gerenciar o seus aspectos stateful. 
Essa instância atua como o "dono" dos objetos instanciados por sua aplicação.

Essencialmente, a `Application` *define sua aplicação*
enquanto a `ApplicationInstance` *gerencia os seus estados*.

[1]: http://emberjs.com/api/classes/Ember.Application.html
[2]: http://emberjs.com/api/classes/Ember.ApplicationInstance.html 

Essa separação de conceitos não apenas clarifica a arquitetura de sua aplicação,
como pode inclusive melhorar sua eficiência.
Isso é particularmente verdadeiro quando sua aplicação precisa ser iniciada repetidamente durante testes 
e/ou em server-rendering (ex.: através do [FastBoot](https://github.com/tildeio/ember-cli-fastboot)).
A configuração de um `Application` pode ser feito uma vez 
e compartilhado através de múltiplas instâncias `ApplicationInstance` statefuls.
Essas instâncias podem ser descartadas uma vez que não sejam mais necessárias 
(ex.: quando um teste tiver rodado ou quando um request do FastBoot foi finalizado).
