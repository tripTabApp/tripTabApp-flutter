//We use Singleton to connect to the database

class Singleton {
  static Singleton? _instance; // instance of this class

  Singleton._internal() {}

  static Singleton getInstance() {
    _instance ??= Singleton._internal();
    return _instance!;
  }
}
