class Player {
  final String name;
  final int id;
  const Player(this.id, this.name);

  bool get isValid {
    return name.length > 3;
  }

  @override
  String toString() {
    return 'Player(id: $id, name: $name)';
  }
}