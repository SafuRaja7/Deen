---
to: lib/features/<%= name %>/bloc/<%= h.changeCase.snake(name) %>_event.dart
---
import 'package:equatable/equatable.dart';

abstract class <%= h.changeCase.pascal(name) %>Event extends Equatable {
  const <%= h.changeCase.pascal(name) %>Event();

  @override
  List<Object?> get props => [];
}

class Load<%= h.changeCase.pascal(name) %>Data extends <%= h.changeCase.pascal(name) %>Event {}
