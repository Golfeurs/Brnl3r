class Player {
  static const minPlayerNameLength = 1;

  final String name;
  final int id;
  const Player(this.id, this.name);

  /// Validate a list of players
  /// 
  /// Either return an error message, or null if no error.
  static String? playersAreValid(List<Player> players) {
    Set<String> names = {};
    Set<int> ids = {};
    for(final player in players) {
      if(!player.isValid) { return "Invalid player data"; }
      if(names.contains(player.name)) { return "Multiple identical names"; }
      if(ids.contains(player.id)) { return "Multiple identical IDs"; }
      names.add(player.name);
      ids.add(player.id);
    }
    return null;
  }

  bool get isValid {
    return name.length >= minPlayerNameLength;
  }

  @override
  String toString() {
    return 'Player(id: $id, name: $name)';
  }
}