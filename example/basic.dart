// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library example.basic;

import 'package:jaguar_serializer/serializer.dart';

part 'basic.g.dart';

@GenSerializer(serializers: const [
  AddressSerializer,
])
class PlayerSerializer extends Serializer<Player> with _$PlayerSerializer {
  Player createModel() => new Player();
}

@GenSerializer()
class AddressSerializer extends Serializer<Address> with _$AddressSerializer {
  Address createModel() => new Address();

  AddressSerializer();
}

/// Player model for the game
class Player {
  /// Name of the player
  String name;

  /// Email of the player
  String email;

  /// Age of the player
  int age;

  /// Player score
  int score;

  /// Has the player confirmed his email?
  ///
  /// Should not be sent to client
  bool emailConfirmed;

  int test;

  List<int> list;

  Map<String, int> map;

  Map<String, Address> map1;

  Address address;

  String toString() => 'Player($name, $email, $age, $score, $emailConfirmed)';
}

class Address {
  String street;
  String zipcode;
  String country;
  String city;
}

void json() {
  SerializerRepo serializer = new JsonRepo();
  {
    Player player = serializer.deserialize({
      'name': 'John',
      'email': 'john@noemail.com',
      'age': 25,
      'score': 1000,
      'emailConfirmed': true,
      '@t': "Player"
    });
    // Player(John, john@noemail.com, 25, 1000, true)
    print(player);
  }

  {
    Player player = serializer.deserialize({
      'name': 'John',
      'email': 'john@noemail.com',
      'age': 25,
      'score': 1000,
      'emailConfirmed': true
    }, type: Player);
    // Player(John, john@noemail.com, 25, 1000, true)
    print(player);
  }

  {
    Player player = new Player()
      ..name = 'John'
      ..email = 'john@noemail.com'
      ..age = 25
      ..score = 1000
      ..emailConfirmed = true
      ..address = (new Address()..city = "Paris");
    print(serializer.serialize(player));
    print(serializer.serialize(player, withType: true));
  }
}

void yaml() {
  SerializerRepo serializer = new YamlRepo();
  {
    Player player = serializer.deserialize({
      'name': 'John',
      'email': 'john@noemail.com',
      'age': 25,
      'score': 1000,
      'emailConfirmed': true,
      '@t': "Player"
    });
    // Player(John, john@noemail.com, 25, 1000, true)
    print(player);
  }

  {
    Player player = serializer.deserialize({
      'name': 'John',
      'email': 'john@noemail.com',
      'age': 25,
      'score': 1000,
      'emailConfirmed': true
    }, type: Player);
    // Player(John, john@noemail.com, 25, 1000, true)
    print(player);
  }

  {
    Player player = new Player()
      ..name = 'John'
      ..email = 'john@noemail.com'
      ..age = 25
      ..score = 1000
      ..emailConfirmed = true
      ..address = (new Address()..city = "Paris");
    print(serializer.serialize(player));
    print(serializer.serialize(player, withType: true));
  }
}

void main() {
  // user basic serializer
  PlayerSerializer pSerializer = new PlayerSerializer();
  Player player = new Player()
    ..name = 'John'
    ..email = 'john@noemail.com'
    ..age = 25
    ..score = 1000
    ..emailConfirmed = true
    ..address = (new Address()..city = "Paris");
  print(pSerializer.toMap(player));
  print(pSerializer.toMap(player, withType: true));

  json();
  yaml();
}