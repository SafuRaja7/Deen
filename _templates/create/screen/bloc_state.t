---
to: lib/features/<%= name %>/bloc/<%= h.changeCase.snake(name) %>_state.dart
---
import 'package:equatable/equatable.dart';

enum <%= h.changeCase.pascal(name) %>Status { initial, loading, success, failure }

class <%= h.changeCase.pascal(name) %>State extends Equatable {
  final <%= h.changeCase.pascal(name) %>Status status;
  final String? error;

  const <%= h.changeCase.pascal(name) %>State({
    this.status = <%= h.changeCase.pascal(name) %>Status.initial,
    this.error,
  });

  <%= h.changeCase.pascal(name) %>State copyWith({
    <%= h.changeCase.pascal(name) %>Status? status,
    String? error,
  }) {
    return <%= h.changeCase.pascal(name) %>State(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
