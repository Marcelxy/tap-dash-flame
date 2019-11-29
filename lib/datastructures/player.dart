class Player {

  String _email;
  String _playerName;
  int _exp;
  int _coins;

  Player(String email, String playerName) {
    this._email = email;
    this._playerName = playerName;
    this._exp = 0;
    this._coins = 0;
  }

  int get coins => _coins;

  int get exp => _exp;

  String get playerName => _playerName;

  String get email => _email;

}