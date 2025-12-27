---
to: lib/features/<%= name %>/bloc/<%= h.changeCase.snake(name) %>_bloc.dart
---
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/<%= name %>/bloc/<%= h.changeCase.snake(name) %>_event.dart';
import 'package:deen/features/<%= name %>/bloc/<%= h.changeCase.snake(name) %>_state.dart';

class <%= h.changeCase.pascal(name) %>Bloc extends Bloc<<%= h.changeCase.pascal(name) %>Event, <%= h.changeCase.pascal(name) %>State> {
  <%= h.changeCase.pascal(name) %>Bloc() : super(const <%= h.changeCase.pascal(name) %>State()) {
    on<Load<%= h.changeCase.pascal(name) %>Data>(_onLoad<%= h.changeCase.pascal(name) %>Data);
  }

  Future<void> _onLoad<%= h.changeCase.pascal(name) %>Data(
    Load<%= h.changeCase.pascal(name) %>Data event,
    Emitter<<%= h.changeCase.pascal(name) %>State> emit,
  ) async {
    emit(state.copyWith(status: <%= h.changeCase.pascal(name) %>Status.loading));
    try {
      // TODO: Implement data loading logic
      emit(state.copyWith(status: <%= h.changeCase.pascal(name) %>Status.success));
    } catch (e) {
      emit(state.copyWith(
        status: <%= h.changeCase.pascal(name) %>Status.failure,
        error: e.toString(),
      ));
    }
  }
}
