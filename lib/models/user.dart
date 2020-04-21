class User {
  final String uid;
  User ({this.uid});
}

// each document has a uid, name, sugars and strength
class UserData{
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({
    this.uid,
    this.name,
    this.sugars,
    this.strength
  });
}