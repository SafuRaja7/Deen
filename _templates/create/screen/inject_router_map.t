---
inject: true
to: lib/core/router/router.dart
after: "final appRoutes = {"
skip_if: "AppRoutes.<%= h.changeCase.camel(name) %>:"
---
  AppRoutes.<%= h.changeCase.camel(name) %>: (_) => const <%= h.changeCase.pascal(name) %>Screen(),
