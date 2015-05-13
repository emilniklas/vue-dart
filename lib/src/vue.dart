part of vue;

class Vue {

  JsObject _vue;

  JsObject get instance => _vue;

  Vue({String el, Map data, Map<String, dynamic> extension}) {

    JsFunction constructor = context['Vue'];

    _vue = new JsObject(constructor, [
      _options(el:el, data:data, extension:extension)
    ]);
  }

  static JsObject _options({String el, String template, Map data, Map<String, dynamic> extension}) {

    Map options = {};

    if (el != null) options['el'] = el;
    if (data != null) options['data'] = data;
    if (template != null) options['template'] = template;
    if (extension == null) extension = {};

    extension.forEach((String name, dynamic field) {

      if (field is Function)
        return options[name] = new JsFunction.withThis(field);

      if (field is Iterable)
        return options[name] = new JsArray.from(field);

      if (field is Map)
        return options[name] = new JsObject.jsify(field);

      options[name] = field;
    });

    return new JsObject.jsify(options);
  }

  Vue._fromJsObject(JsObject vueObject) {
    _vue = vueObject;
  }

  JsObject noSuchMethod(Invocation invocation) {

    String symbolExpression = invocation.memberName.toString();

    RegExp matcher = new RegExp(r'^Symbol\("(.*)"\)$');

    String symbolName = symbolExpression.replaceAllMapped(matcher, (Match match) {

      return match.group(1);
    });

    if (invocation.isGetter) {

      return _vue[symbolName];
    }

    if (invocation.isSetter) {

      return _vue[symbolName] = invocation.positionalArguments[0];
    }

    return _vue.callMethod(symbolName, invocation.positionalArguments);
  }

  Element get $el {

    return _vue[r'$el'];
  }

  Map get $data {

    return _vue[r'$data'];
  }

  void set $data(Map data) {

    _vue[r'$data'] = new JsObject.jsify(data);
  }

  Vue get $parent {

    JsObject parent = _vue[r'$parent'];

    if (parent == null) return null;

    return new Vue._fromJsObject(parent);
  }

  Vue get $root {

    return new Vue._fromJsObject(_vue[r'$root']);
  }

  dynamic get $ {

    JsObject $ = _vue[r'$'];

    return $;
  }

  dynamic get $$ {

    JsObject $$ = _vue[r'$$'];

    return $$;
  }

  int get $index {

    return _vue[r'$index'];
  }

  String get $key {

    return _vue[r'$key'];
  }

  dynamic get $value {

    return _vue[r'$value'];
  }
}