library vue.interop;

import 'package:js/js.dart';
import 'dart:html';

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
  /// Create a “subclass” of the base Vue constructor. The argument should
  /// be an object containing component options.
  ///
  /// The special cases to note here are el and data options - they must
  /// be functions when used with Vue.extend().
  external static Function extend(VueComponentDeclaration options);

  external static VueConfig get config;

  /// Defer the callback to be executed after the next DOM update cycle.
  /// Use it immediately after you’ve changed some data to wait for the
  /// DOM update.
  external static void nextTick(void callback());

  /// Set a property on an object. If the object is reactive, ensure the
  /// property is created as a reactive property and trigger view updates.
  /// This is primarily used to get around the limitation that Vue cannot
  /// detect property additions.
  external static void set(object, String key, value);

  /// Delete a property on an object. If the object is reactive, ensure
  /// the deletion triggers view updates. This is primarily used to
  /// get around the limitation that Vue cannot detect property deletions,
  /// but you should rarely need to use it.
  external static void delete(object, String key);

  /// Register or retrieve a global directive. [definition] can be either
  /// a [VueDirective] object or a [Function].
  external static VueDirective directive(String id, [definition]);

  /// Register or retrieve a global element directive.
  external static VueDirective elementDirective(String id,
      [VueDirective definition]);

  /// Register or retrieve a global filter. [definition] can be either
  /// a [VueFilter] object or a [Function].
  external static VueFilter filter(String id, [definition]);

  /// Register or retrieve a global component. [definition] can be either
  /// a [VueComponentDeclaration] object or a [Function] constructor.
  external static Function component(String id, [definition]);

  /// Register or retrieve a global transition hooks object.
  external static VueTransition transition(String id,
      [VueTransition hooks]);

  /// Register or retrieve a global template partial string.
  external static String partial(String id, [String partial]);

  /// Install a Vue.js plugin. If the plugin is an Object, it must expose
  /// an install method. If it is a function itself, it will be treated as
  /// the install method. The install method will be called with Vue as
  /// the argument.
  external static void use(plugin, [JsObject options]);

  /// Apply a mixin globally, which affects every Vue instance created
  /// afterwards. This can be used by plugin authors to inject custom
  /// behavior into components. Not recommended in application code.
  external static void mixin(VueMixin mixin);

  external Vue(VueSingletonDeclaration options);

  /// The data object that the Vue instance is observing. You can swap it
  /// with a new object. The Vue instance proxies access to the properties
  /// on its data object.
  external JsObject get $data;

  /// The DOM element that the Vue instance is managing. Note that for
  /// Fragment Instances, vm.$el will return an anchor node that indicates
  /// the starting position of the fragment.
  external Element get $el;

  /// The instantiation options used for the current Vue instance.
  external VueMixin get $options;

  /// The parent instance, if the current instance has one.
  external Vue get $parent;

  /// The root Vue instance of the current component tree. If the current
  /// instance has no parents this value will be itself.
  external Vue get $root;

  /// The direct child components of the current instance.
  external Iterable<Vue> get $children;

  /// An object that holds child components that have v-ref registered.
  external JsObject get $refs;

  /// An object that holds DOM elements that have v-el registered.
  external JsObject<Element> get $els;

  /// Watch an expression or a computed function on the Vue instance
  /// for changes. The callback gets called with the new value and the
  /// old value. The expression can be a single keypath or any valid
  /// binding expressions.
  external Function $watch(expOrFn,
      callback(newVal, oldVal),
      [WatchOptions options]);

  /// Retrieve a value from the Vue instance given an expression.
  /// Expressions that throw errors will be suppressed and return undefined.
  external $get(String expression);

  /// Set a data value on the Vue instance given a valid keypath. In most
  /// cases you should prefer setting properties using plain object syntax,
  /// e.g. vm.a.b = 123. This method is only needed in two scenarios:
  ///
  /// 1. When you have a keypath string and want to dynamically set the
  ///    value using that keypath.
  ///
  /// 2. When you want to set a property that doesn’t exist.
  ///
  /// If the path doesn’t exist it will be recursively created and made
  /// reactive. If a new root-level reactive property is created due to
  /// a $set call, the Vue instance will be forced into a “digest cycle”,
  /// during which all its watchers are re-evaluated.
  external void $set(String keypath, value);

  /// Delete a root level property on the Vue instance (and also its $data).
  /// Forces a digest cycle. Not recommended.
  external void $delete(String key);

  /// Evaluate a valid binding expression on the current instance. The
  /// expression can also contain filters.
  external $eval(String expression);

  /// Evaluate a piece of template string containing mustache interpolations.
  /// Note that this method simply performs string interpolation; attribute
  /// directives are ignored.
  external String $interpolate(String templateString);

  /// Log the current instance data as a plain object, which is more
  /// inspection-friendly than a bunch of getter/setters. Also accepts
  /// an optional key.
  external void $log([String keypath]);

  /// Listen for a custom event on the current vm. Events can be
  /// triggered by vm.$emit, vm.$dispatch or vm.$broadcast. The callback
  /// will receive all the additional arguments passed into these
  /// event-triggering methods.
  external void $on(String event, Function callback);

  /// Listen for a custom event, but only once. The listener will be
  /// removed once it triggers for the first time.
  external void $once(String event, Function callback);

  /// Remove event listener(s).
  ///
  /// * If no arguments are provided, remove all event listeners;
  /// * If only the event is provided, remove all listeners for that event;
  /// * If both event and callback are given, remove the listener for that
  ///   specific callback only.
  external void $off([String event, Function callback]);

  /// Trigger an event on the current instance. Any additional arguments
  /// will be passed into the listener’s callback function.
  external void $emit(String event,
      [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10]);

  /// Dispatch an event, first triggering it on the instance itself, and
  /// then propagates upward along the parent chain. The propagation stops
  /// when it triggers a parent event listener, unless that listener returns
  /// true. Any additional arguments will be passed into the listener’s
  /// callback function.
  external void $dispatch(String event,
      [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10]);

  /// Broadcast an event that propagates downward to all descendants of
  /// the current instance. Since the descendants expand into multiple
  /// sub-trees, the event propagation will follow many different “paths”.
  /// The propagation for each path will stop when a listener callback is
  /// fired along that path, unless the callback returns true.
  external void $broadcast(String event,
      [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10]);

  /// Append the Vue instance’s DOM element or fragment to target element.
  /// The target can be either an element or a querySelector string. This
  /// method will trigger transitions if present. The callback is fired
  /// after the transition has completed (or immediately if no transition
  /// has been triggered).
  external Vue $appendTo(elementOrSelector, [Function callback]);

  /// Insert the Vue instance’s DOM element or fragment before target
  /// element. The target can be either an element or a querySelector string.
  /// This method will trigger transitions if present. The callback is
  /// fired after the transition has completed (or immediately if no transition
  /// has been triggered).
  external Vue $before(elementOrSelector, [Function callback]);

  /// Insert the Vue instance’s DOM element or fragment after target element.
  /// The target can be either an element or a querySelector string. This
  /// method will trigger transitions if present. The callback is fired after
  /// the transition has completed (or immediately if no transition has
  /// been triggered).
  external Vue $after(elementOrSelector, [Function callback]);

  /// Remove the Vue instance’s DOM element or fragment from the DOM. This
  /// method will trigger transitions if present. The callback is fired
  /// after the transition has completed (or immediately if no transition
  /// has been triggered).
  external Vue $remove([Function callback]);

  /// Defer the callback to be executed after the next DOM update cycle. Use
  /// it immediately after you’ve changed some data to wait for the DOM update.
  /// This is the same as the global Vue.nextTick, except that the callback’s
  /// this context is automatically bound to the instance calling this method.
  external void $nextTick(Function callback);

  /// If a Vue instance didn’t receive the el option at instantiation, it
  /// will be in “unmounted” state, without an associated DOM element or
  /// fragment. vm.$mount() can be used to manually start the
  /// mounting/compilation of an unmounted Vue instance.
  ///
  /// If no argument is provided, the template will be created as an
  /// out-of-document fragment, and you will have to use other DOM instance
  /// methods to insert it into the document yourself. If replace option
  /// is set to false, then an empty <div> will be automatically created
  /// as the wrapper element.
  ///
  /// Calling $mount() on an already mounted instance will have no
  /// effect. The method returns the instance itself so you can
  /// chain other instance methods after it.
  external Vue $mount([elementOrSelector]);

  /// Completely destroy a vm. Clean up its connections with other existing
  /// vms, unbind all its directives, turn off all event listeners and,
  /// if the remove argument is true, remove its associated DOM element
  /// or fragment from the DOM.
  ///
  /// Triggers the beforeDestroy and destroyed hooks.
  external void $destroy([bool remove]);
}

@JS()
@anonymous
class VueSingletonDeclaration extends VueBaseOptions {
  external factory VueSingletonDeclaration({
    JsObject data,
    el,
    void props(props),
    JsObject computed,
    JsObject<Function> methods,
    JsObject watch,
    String template,
    bool replace,
    Function created,
    Function beforeCompile,
    Function compiled,
    Function ready,
    Function attached,
    Function detached,
    Function beforeDestroy,
    Function destroyed,
    JsObject<VueDirective> directives,
    JsObject<VueDirective> elementDirectives,
    JsObject<VueFilter> filters,
    JsObject<VueComponentDeclaration> components,
    JsObject<VueTransition> transitions,
    JsObject<String> partials,
    Vue parent,
    JsObject<Function> events,
    Iterable<VueMixin> mixins,
    String name
  });

  external JsObject get data;

  external void set data(JsObject data);

  external get el;

  external void set el(el);
}

@JS()
@anonymous
class VueComponentDeclaration extends VueBaseOptions {
  external factory VueComponentDeclaration({
    el(),
    JsObject data(),
    void props(props),
    JsObject computed,
    JsObject<Function> methods,
    JsObject watch,
    String template,
    bool replace,
    Function created,
    Function beforeCompile,
    Function compiled,
    Function ready,
    Function attached,
    Function detached,
    Function beforeDestroy,
    Function destroyed,
    JsObject<VueDirective> directives,
    JsObject<VueDirective> elementDirectives,
    JsObject<VueFilter> filters,
    JsObject<VueComponentDeclaration> components,
    JsObject<VueTransition> transitions,
    JsObject<String> partials,
    Vue parent,
    JsObject<Function> events,
    Iterable<VueMixin> mixins,
    String name
  });

  external Function get data;

  external void set data(Function data);

  external Function get el;

  external void set el(Function el);
}

@JS()
@anonymous
class VueMixin extends VueBaseOptions {
  external factory VueMixin({
    void props(props),
    JsObject computed,
    JsObject<Function> methods,
    JsObject watch,
    String template,
    bool replace,
    Function created,
    Function beforeCompile,
    Function compiled,
    Function ready,
    Function attached,
    Function detached,
    Function beforeDestroy,
    Function destroyed,
    JsObject<VueDirective> directives,
    JsObject<VueDirective> elementDirectives,
    JsObject<VueFilter> filters,
    JsObject<VueComponentDeclaration> components,
    JsObject<VueTransition> transitions,
    JsObject<String> partials,
    Vue parent,
    JsObject<Function> events,
    Iterable<VueMixin> mixins,
    String name
  });
}

@JS()
@anonymous
class VueBaseOptions {
  /// A list/hash of attributes that are exposed to accept data from the
  /// parent component. It has a simple Array-based syntax and an
  /// alternative Object-based syntax that allows advanced configurations
  /// such as type checking, custom validation and default values.
  ///
  /// Can be [Iterable<String>], [JsObject<Type>],
  /// [JsObject<PropertyDeclaration>] or a combination.
  external get props;

  external void set props(props);

  /// Computed properties to be mixed into the Vue instance.
  ///
  /// Can be [JsObject<Function>], [JsObject<SetterSetter>]
  /// or a combination.
  external JsObject get computed;

  external void set computed(JsObject computed);

  /// Methods to be mixed into the Vue instance. You can access
  /// these methods directly on the VM instance, or use them in
  /// directive expressions.
  ///
  /// Must be an object containing the methods available to
  /// the Vue instance.
  external JsObject<Function> get methods;

  external void set methods(JsObject<Function> methods);

  /// An object where keys are expressions to watch and values are
  /// the corresponding callbacks. The value can also be a string
  /// of a method name, or an Object that contains additional options.
  /// The Vue instance will call $watch() for each entry in the object
  /// at instantiation.
  ///
  /// Can be a [JsObject<WatchHandler>], [JsObject<String>],
  /// [JsObject<WatchDeclaration>] or a combination.
  external JsObject get watch;

  external void set watch(JsObject watch);

  /// A string template to be used as the markup for the Vue instance.
  /// By default, the template will replace the mounted element. When
  /// the replace option is set to false, the template will be inserted
  /// into the mounted element instead. In both cases, any existing
  /// markup inside the mounted element will be ignored, unless content
  /// distribution slots are present in the template.
  ///
  /// If the string starts with # it will be used as a querySelector
  /// and use the selected element’s innerHTML as the template string.
  /// This allows the use of the common <script type="x-template"> trick
  /// to include templates.
  ///
  /// Note that under certain situations, for example when the template
  /// contains more than one top-level element, or contains only plain
  /// text, the instance will become a fragment instance - i.e. one that
  /// manages a list of nodes rather than a single node. Non flow-control
  /// directives on the mount point for fragment instances are ignored.
  external String get template;

  external void set template(String template);

  /// Determines whether to replace the element being mounted on with the
  /// template. If set to false, the template will overwrite the element’s
  /// inner content without replacing the element itself.
  external bool get replace;

  external void set replace(bool replace);

  /// Called synchronously after the instance is created. At this stage,
  /// the instance has finished processing the options which means the
  /// following have been set up: data observation, computed properties,
  /// methods, watch/event callbacks. However, DOM compilation has not
  /// been started, and the $el property will not be available yet.
  external Function get created;

  external void set created(Function created);

  /// Called right before the compilation starts.
  external Function get beforeCompile;

  external void set beforeCompile(Function beforeCompile);

  /// Called after the compilation is finished. At this stage all
  /// directives have been linked so data changes will trigger DOM
  /// updates. However, $el is not guaranteed to have been inserted
  /// into the document yet.
  external Function get compiled;

  external void set compiled(Function compiled);

  /// Called after compilation and the $el is inserted into the document
  /// for the first time, i.e. right after the first attached hook.
  /// Note this insertion must be executed via Vue (with methods like
  /// vm.$appendTo() or as a result of a directive update) to trigger
  /// the ready hook.
  external Function get ready;

  external void set ready(Function ready);

  /// Called when vm.$el is attached to DOM by a directive or a VM
  /// instance method such as $appendTo(). Direct manipulation of
  /// vm.$el will not trigger this hook.
  external Function get attached;

  external void set attached(Function attached);

  /// Called when vm.$el is removed from the DOM by a directive
  /// or a VM instance method. Direct manipulation of vm.$el will
  /// not trigger this hook.
  external Function get detached;

  external void set detached(Function detached);

  /// Called right before a Vue instance is destroyed. At this stage
  /// the instance is still fully functional.
  external Function get beforeDestroy;

  external void set beforeDestroy(Function beforeDestroy);

  /// Called after a Vue instance has been destroyed. When this hook
  /// is called, all bindings and directives of the Vue instance have
  /// been unbound and all child Vue instances have also been destroyed.
  ///
  /// Note if there is a leaving transition, the destroyed hook is
  /// called after the transition has finished.
  external Function get destroyed;

  external void set destroyed(Function destroyed);

  /// A hash of directives to be made available to the Vue instance.
  external JsObject<VueDirective> get directives;

  external void set directives(JsObject<VueDirective> directives);

  /// A hash of element directives to be made available to the Vue instance.
  external JsObject<VueDirective> get elementDirectives;

  external void set elementDirectives(
      JsObject<VueDirective> elementDirectives);

  /// A hash of filters to be made available to the Vue instance.
  external JsObject<VueFilter> get filters;

  external void set filters(JsObject<VueFilter> filters);

  /// A hash of components to be made available to the Vue instance.
  external JsObject<VueComponentDeclaration> get components;

  external void set components(JsObject<VueComponentDeclaration> components);

  /// A hash of transitions to be made available to the Vue instance.
  external JsObject<VueTransition> get transitions;

  external void set transitions(JsObject<VueTransition> transitions);

  /// A hash of partial strings to be made available to the Vue instance.
  external JsObject<String> get partials;

  external void set partials(JsObject<String> partials);

  /// Specify the parent instance for the instance to be created.
  /// Establishes a parent-child relationship between the two. The
  /// parent will be accessible as this.$parent for the child, and
  /// the child will be pushed into the parent’s $children array.
  external Vue get parent;

  external void set parent(Vue parent);

  /// An object where keys are events to listen for and values are
  /// the corresponding callbacks. Note these are Vue events rather
  /// than DOM events. The value can also be a string of a method name.
  /// The Vue instance will call $on() for each entry in the object
  /// at instantiation.
  external JsObject<Function> get events;

  external void set events(JsObject<Function> events);

  /// The mixins option accepts an array of mixin objects. These mixin
  /// objects can contain instance options just like normal instance
  /// objects, and they will be merged against the eventual options using
  /// the same option merging logic in Vue.extend(). e.g. If your
  /// mixin contains a created hook and the component itself also has
  /// one, both functions will be called.
  ///
  /// Mixin hooks are called in the order they are provided, and called
  /// before the component’s own hooks.
  external Iterable<VueMixin> get mixins;

  external void set mixins(Iterable<VueMixin> mixins);

  /// Allow the component to recursively invoke itself in its template.
  /// Note that when a component is registered globally with Vue.component(),
  /// the global ID is automatically set as its name.
  ///
  /// Another benefit of specifying a name option is console inspection.
  /// When inspecting an extended Vue component in the console, the default
  /// constructor name is VueComponent, which isn’t very informative. By
  /// passing in an optional name option to Vue.extend(), you will get a
  /// better inspection output so that you know which component you are
  /// looking at. The string will be camelized and used as the component’s
  /// constructor name.
  external String get name;

  external void set name(String name);
}

@JS()
@anonymous
class VuePropertyDeclaration {
  external Type get type;

  external void set type(Type type);

  external bool get required;

  external void set required(bool required);

  external factory VuePropertyDeclaration({
  bool required,
  Type type
  });
}

@JS()
@anonymous
class GetterSetter<T> {
  external factory GetterSetter({
  T get(),
  void set(T value)
  });

  external T get();

  external void set(T value);
}

@JS()
@anonymous
class VueWatchDeclaration {
  external factory VueWatchDeclaration({
  bool deep,
  VueWatchHandler handler
  });

  external bool get deep;

  external void set deep(bool deep);

  external VueWatchHandler get handler;

  external void set handler(VueWatchHandler handler);
}

typedef void VueWatchHandler(value, oldValue);

@JS()
@anonymous
class WatchOptions {
  external factory WatchOptions({
  bool deep,
  bool immediate
  });

  external bool get deep;

  external void set deep(bool deep);

  external bool get immediate;

  external void set immediate(bool immediate);
}

@JS()
@anonymous
class VueTransition {
  external factory VueTransition({
  void beforeEnter(),
  void enter(),
  void afterEnter(),
  void enterCancelled(),
  void beforeLeave(),
  void leave(),
  void afterLeave(),
  void leaveCancelled()
  });

  external Function get beforeEnter;

  external void set beforeEnter(void beforeEnter(Element el));

  external Function get enter;

  external void set enter(void enter(Element el));

  external Function get afterEnter;

  external void set afterEnter(void afterEnter(Element el));

  external Function get enterCancelled;

  external void set enterCancelled(void enterCancelled(Element el));

  external Function get beforeLeave;

  external void set beforeLeave(void beforeLeave(Element el));

  external Function get leave;

  external void set leave(void leave(Element el));

  external Function get afterLeave;

  external void set afterLeave(void afterLeave(Element el));

  external Function get leaveCancelled;

  external void set leaveCancelled(void leaveCancelled(Element el));
}

@JS()
@anonymous
class VueFilter {
  external factory VueFilter({
  void read(val),
  void write(val, oldVal)
  });

  external Function get read;

  external void set read(void read(val));

  external Function get write;

  external void set write(void write(val, oldVal));
}

@JS()
@anonymous
class VueDirective {
  external factory VueDirective({
  void bind(),
  void update(newValue, oldValue),
  void unbind()
  });

  external Function get bind;

  external void set bind(void bind());

  external Function get update;

  external void set update(void update(newValue, oldValue));

  external Function get unbind;

  external void set unbind(void unbind());
}