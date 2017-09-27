Além de configurar o seu própria aplicação, você também pode configurar o Ember CLI. Essas configurações podem ser feitas adicionando-as ao arquivo `.ember-cli` na pasta raiz da sua aplicação. Muitas dessas configurações também podem ser feitas passando-as como argumentos no terminal.

Por exemplo, um desejo em comum é alterar a porta que o servidor do Ember CLI expõe a aplicação. É possível passar o número da porta por linha de comando como por exemplo: `ember server --port 8080`. Para fazer esta configuração de forma permatente, você pode editar o arquivo `.ember-cli` desta maneira:

```json
{
  "port": 8080
}
```

Para ver a lista completa de opções, execute `ember help`.
