import 'package:equatable/equatable.dart';

/// Base class for [ColorView] BLoC events
sealed class ColorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// BLoC event triggering random picking new color for [ColorView] background and following that
/// picking contrasting color for home page text.
class JuggleColorEvent extends ColorEvent {}
