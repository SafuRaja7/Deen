---
inject: true
to: lib/core/router/router.dart
after: "import 'package:flutter/material.dart';"
skip_if: "import 'package:deen/features/<%= name %>/presentation/<%= h.changeCase.snake(name) %>_screen.dart';"
---
import 'package:deen/features/<%= name %>/presentation/<%= h.changeCase.snake(name) %>_screen.dart';
