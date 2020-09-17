class UsersList {
  final List<UserModel> users;

  UsersList({this.users});

  factory UsersList.fromJson(List<dynamic> json) {
    List<UserModel> users = json.map((e) => UserModel.fromJson(e)).toList();

    return new UsersList(
      users: users,
    );
  }
}

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"] as int,
        name: json["name"] == null ? null : json["name"] as String,
        username: json["username"] == null ? null : json["username"] as String,
        email: json["email"] == null ? null : json["email"] as String,
        address: json["address"] == null
            ? null
            : Address.fromjson(json["address"] as Map<String, dynamic>),
        phone: json["phone"] == null ? null : json["phone"] as String,
        website: json["website"] == null ? null : json["website"] as String,
        company: json["company"] == null
            ? null
            : Company.fromjson(json["company"] as Map<String, dynamic>),
      );
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({this.name, this.catchPhrase, this.bs});

  factory Company.fromjson(Map<String, dynamic> json) => Company(
        name: json["name"] == null ? null : json["name"] as String,
        catchPhrase:
            json["catchPhrase"] == null ? null : json["catchPhrase"] as String,
        bs: json["bs"] == null ? null : json["bs"] as String,
      );
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  factory Address.fromjson(Map<String, dynamic> json) => Address(
        street: json["street"] == null ? null : json["street"] as String,
        suite: json["suite"] == null ? null : json["suite"] as String,
        city: json["city"] == null ? null : json["city"] as String,
        zipcode: json["zipcode"] == null ? null : json["zipcode"] as String,
        geo: json["geo"] == null
            ? null
            : Geo.fromjson(json["geo"] as Map<String, dynamic>),
      );
}

class Geo {
  final String lat;
  final String lng;

  Geo({this.lat, this.lng});

  factory Geo.fromjson(Map<String, dynamic> json) => Geo(
        lat: json["lat"] == null ? null : json["lat"] as String,
        lng: json["lng"] == null ? null : json["lng"] as String,
      );
}
