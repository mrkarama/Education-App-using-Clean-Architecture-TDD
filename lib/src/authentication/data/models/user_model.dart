import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';

class LocalUserModel extends LocaleUser {
  const LocalUserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.points,
    super.bio,
    super.profilePic,
    super.groupIds,
    super.enrolledCourseIds,
    super.followers,
    super.following,
  });

  const LocalUserModel.empty()
      : this(
          uid: '',
          name: '',
          email: '',
          points: 0,
        );

  LocalUserModel.fromMap(DataMap map)
      : this(
          uid: map['uid'] as String,
          name: map['name'] as String,
          email: map['email'] as String,
          points: (map['points'] as num).toInt(),
          bio: map['bio'] as String?,
          profilePic: map['profilePic'] as String?,
          groupIds: List<String>.from(map['groupIds'] as List<dynamic>),
          enrolledCourseIds: (map['enrolledCourseIds'] as List).cast<String>(),
          followers: List<String>.from(map['followers'] as List),
          following: List<String>.from(map['following'] as List<dynamic>),
        );

  DataMap toMap() => {
        'uid': uid,
        'name': name,
        'email': email,
        'points': points,
        'bio': bio,
        'profilePic': profilePic,
        'groupIds': groupIds,
        'enrolledCourseIds': enrolledCourseIds,
        'followers': followers,
        'following': following,
      };

  LocalUserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? bio,
    String? profilePic,
    int? points,
    List<String>? enrolledCourseIds,
    List<String>? groupIds,
    List<String>? followers,
    List<String>? following,
  }) =>
      LocalUserModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        points: points ?? this.points,
        bio: bio ?? this.bio,
        profilePic: profilePic ?? this.profilePic,
        enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
        followers: followers ?? this.followers,
        following: following ?? this.following,
      );
}
