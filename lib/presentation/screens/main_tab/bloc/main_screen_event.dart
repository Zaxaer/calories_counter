class MainScreenEvent {}

class SelectScreen extends MainScreenEvent {
  final int index;
  SelectScreen({
    required this.index,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectScreen && other.index == index;
  }

  @override
  int get hashCode => index.hashCode;
}
