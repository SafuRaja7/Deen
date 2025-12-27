---
to: lib/features/<%= name %>/presentation/<%= h.changeCase.snake(name) %>_screen.dart
---
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/<%= name %>/bloc/<%= h.changeCase.snake(name) %>_bloc.dart';
import 'package:deen/features/<%= name %>/bloc/<%= h.changeCase.snake(name) %>_event.dart';
import 'package:deen/features/<%= name %>/presentation/widgets/<%= h.changeCase.snake(name) %>_body.dart';

class <%= h.changeCase.pascal(name) %>Screen extends StatelessWidget {
  const <%= h.changeCase.pascal(name) %>Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => <%= h.changeCase.pascal(name) %>Bloc()..add(Load<%= h.changeCase.pascal(name) %>Data()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('<%= h.changeCase.title(name) %>'),
        ),
        body: const <%= h.changeCase.pascal(name) %>Body(),
      ),
    );
  }
}
