Além de configurar o seu próprio aplicativo, você também pode configurar o CLI do Ember. Essas configurações podem ser feitas adicionando-as ao arquivo `.ember-cli` na pasta raiz do seu aplicativo. Muitas dessas configurações também podem ser feitas passando-as como argumentos para o programa por linha de comando.

Por exemplo, um desejo em comum é alterar a porta que o servidor do Ember CLI expõe a aplicação. É possível passar a número da porta a partir de uma linha de comando com `ember server --port 8080`. Para fazer esta configuração de forma permatente, você pode editar o arquivo `.ember-cli` desta maneira:

```json
{
  "port": 8080
}
```

Para a ver a lista completa de opções, execute `ember help`.
