part of vue;

abstract class VueComponent {

  get initialState => {};

  JsObject _state;

  JsObject get state => _state;

  final Map<String, Function> methods = {};

  final String template = '';

  void register(String name) async {

    _state = new JsObject.jsify(await initialState);

    context['Vue']['component'].apply([
      name,
      new JsObject.jsify({
        'template': template,
        'data': new JsFunction.withThis((vm) => _state),
        'methods': methods,
      })
    ], thisArg: context['Vue']);
  }
}