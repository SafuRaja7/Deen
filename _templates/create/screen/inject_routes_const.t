---
inject: true
to: lib/core/router/routes.dart
before: "}"
skip_if: "static const <%= h.changeCase.camel(name) %>"
---
  static const <%= h.changeCase.camel(name) %> = '/<%= h.changeCase.param(name) %>';
