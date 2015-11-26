library vue.interop;

import 'package:js/js.dart';

@JS()
@anonymous
class JsObject<T> {
  external factory JsObject();

  external operator []=(String key, T value);

  external operator [](String key);
}

JsObject jsify(Map<String, dynamic> map) {
  final object = new JsObject();
  for (final key in map.keys)
    object[key] = map[key];
  return object;
}

@JS()
@anonymous
class VueConfig {
  external bool get debug;

  external void set debug(bool debug);

  external Iterable<String> get delimiters;

  external void set delimiters(Iterable<String> delimiters);

  external Iterable<String> get unsafeDelimiters;

  external void set unsafeDelimiters(Iterable<String> unsafeDelimiters);

  external bool get silent;

  external void set silent(bool silent);

  external bool get async;

  external void set async(bool async);

  external bool get convertAllProperties;

  external void set convertAllProperties(bool convertAllProperties);
}

@JS()
class Vue {
}

@JS()
@anonymous
class VueSingletonDeclaration extends Object
    with _VueDeclaration {
  external get data;

  external get el;
}

@JS()
@anonymous
class VueComponentDeclaration extends Object
    with _VueDeclaration {
  external get data;

  external get el;
}

@JS()
@anonymous
class _VueDeclaration {
  /// [props] can be [Iterable<String>], [JsObject<Type>],
  /// [JsObject<PropertyDeclaration>] or a combination.
  external get props;

  external void set props(props);

  /// [computed] can be [JsObject<Function>], [JsObject<SetterSetter>]
  /// or a combination.
  external JsObject get computed;

  external void set computed(JsObject computed);

  /// [methods] is an object containing the methods available to
  /// the Vue instance.
  external JsObject<Function> get methods;

  external void set methods(JsObject<Function> methods);

  /// [watch] can be a [JsObject<WatchHandler>], [JsObject<String>],
  /// [JsObject<WatchDeclaration>] or a combination.
  external JsObject get watch;

  external void set watch(JsObject watch);

  /// [template] is the template of the Vue instance. Can be a hash ID
  /// of an element to use as a template.
  external String get template;

  external void set template(String template);

  external get replace;

  external void set replace(replace);

  external get created;

  external void set created(created);

  external get beforeCompile;

  external void set beforeCompile(beforeCompile);

  external get compiled;

  external void set compiled(compiled);

  external get ready;

  external void set ready(ready);

  external get attached;

  external void set attached(attached);

  external get detached;

  external void set detached(detached);

  external get beforeDestroy;

  external void set beforeDestroy(beforeDestroy);

  external get destroyed;

  external void set destroyed(destroyed);

  external get directives;

  external void set directives(directives);

  external get elementDirectives;

  external void set elementDirectives(elementDirectives);

  external get filters;

  external void set filters(filters);

  external get components;

  external void set components(components);

  external get transitions;

  external void set transitions(transitions);

  external get partials;

  external void set partials(partials);

  external get parent;

  external void set parent(parent);

  external get events;

  external void set events(events);

  external get mixins;

  external void set mixins(mixins);

  external get name;

  external void set name(name);
}

@JS()
@anonymous
class PropertyDeclaration {
  external Type get type;
  external void set type(Type type);
  external bool get required;
  external void set required(bool required);

  external factory PropertyDeclaration({
  bool required,
  Type type
  });
}

@JS()
@anonymous
class GetterSetter<T> {
  external T get();

  external void set(T value);

  external factory GetterSetter({
  T get(),
  void set(T value)
  });
}

@JS()
@anonymous
class WatchDeclaration {
  external bool get deep;

  external void set deep(bool deep);

  external WatchHandler get handler;

  external void set handler(WatchHandler handler);

  external factory WatchDeclaration({
  bool deep,
  WatchHandler handler
  });
}

typedef void WatchHandler(value, oldValue);
