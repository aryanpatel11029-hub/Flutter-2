enum UserRole { buyer, seller, admin }

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String? profileImageUrl;
  final String bio;
  final UserRole role;
  final String address;
  final DateTime? joinedAt;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone = '',
    this.profileImageUrl,
    this.bio = '',
    this.role = UserRole.buyer,
    this.address = '',
    this.joinedAt,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
    String? bio,
    UserRole? role,
    String? address,
    DateTime? joinedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      role: role ?? this.role,
      address: address ?? this.address,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'role': role.name,
      'address': address,
      'joinedAt': joinedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return UserModel(
      uid: docId ?? map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      profileImageUrl: map['profileImageUrl'],
      bio: map['bio'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => UserRole.buyer,
      ),
      address: map['address'] ?? '',
      joinedAt: map['joinedAt'] != null ? DateTime.tryParse(map['joinedAt']) : null,
    );
  }
}
