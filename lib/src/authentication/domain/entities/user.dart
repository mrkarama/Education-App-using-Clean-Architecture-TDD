import 'package:equatable/equatable.dart';

class LocaleUser extends Equatable {
  const LocaleUser({
    required this.uid,
    required this.name,
    required this.email,
    this.profilePic,
    this.bio,
    this.points = 0,
    this.enrolledCourseIds = const [],
    this.followers = const [],
    this.following = const [],
    this.groupIds = const [],
  });

  const LocaleUser.empty()
      : this(
          uid: '',
          name: '',
          email: '',
          points: 0,
        );

  final String uid; // Because Firebase uid is a String
  final String name;
  final String email;
  final String? profilePic;
  final String? bio;
  final int? points;
  final List<String>? enrolledCourseIds;
  final List<String>? groupIds; // For chatting
  final List<String>? followers;
  final List<String>? following;

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        profilePic,
        points,
        bio,
        enrolledCourseIds!.length,
        groupIds!.length,
        followers!.length,
        following!.length,
      ];
}
