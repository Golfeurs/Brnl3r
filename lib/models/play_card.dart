enum Kind {
  spade("♠️", false),
  club("♣️", false),
  heart("♥️", true),
  diamond("♦️", true);

  final String name;
  final bool isRed;
  const Kind(this.name, this.isRed);

  @override
  String toString() {
    return name;
  }
}

enum Order {
  two("2"),
  three("3"),
  four("4"),
  five("5"),
  six("6"),
  seven("7"),
  eight("8"),
  nine("9"),
  ten("10"),
  j("J"),
  q("Q"),
  k("K"),
  a("A"),
  joker("🃏Joker🃏");

  final String name;
  const Order(this.name);

  @override
  String toString() {
    return name;
  }
}

class PlayCard {
  final Kind kind;
  final Order order;

  static List<PlayCard> cards() {
    final list = <PlayCard>[];
    for (final kind in Kind.values) {
      for (final order in Order.values) {
        list.add(PlayCard(kind, order));
      }
    }
    return list;
  }

  const PlayCard(this.kind, this.order);

  bool isJoker() {
    return order == Order.joker;
  }

  @override
  String toString() {
    return isJoker() ? "$order" : "$kind$order";
  }

  @override
  int get hashCode => (order.index << 2) + kind.index;

  @override
  bool operator ==(Object other) {
    return (other is PlayCard) && other.kind == kind && other.order == order;
  }
}
