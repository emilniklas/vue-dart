import 'package:vue/src/interop.dart';

main() {
  Vue.extend(new VueComponentDeclaration());

  new Vue(new VueDeclaration(el: 'body'));
}