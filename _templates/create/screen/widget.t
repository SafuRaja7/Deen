---
to: lib/features/<%= name %>/presentation/widgets/<%= h.changeCase.snake(name) %>_body.dart
---
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/<%= name %>/bloc/<%= h.changeCase.snake(name) %>_bloc.dart';
import 'package:deen/features/<%= name %>/bloc/<%= h.changeCase.snake(name) %>_state.dart';

class <%= h.changeCase.pascal(name) %>Body extends StatelessWidget {
  const <%= h.changeCase.pascal(name) %>Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<<%= h.changeCase.pascal(name) %>Bloc, <%= h.changeCase.pascal(name) %>State>(
      builder: (context, state) {
        if (state.status == <%= h.changeCase.pascal(name) %>Status.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state.status == <%= h.changeCase.pascal(name) %>Status.failure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return const Center(
          child: Text('Welcome to <%= h.changeCase.title(name) %> Screen'),
        );
      },
    );
  }
}
