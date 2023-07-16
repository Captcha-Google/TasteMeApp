class ProfileModel {
  final int profileId;
  final String profileUsername;
  final String profileFullname;
  final String profileFirstName;
  final String profileLastName;
  final String profileEmail;
  final bool profileIsStaff;
  final bool profileIsActive;
  final String profileDateJoined;
  final String profileLastLogin;

  ProfileModel({
    required this.profileId,
    required this.profileUsername,
    required this.profileFullname,
    required this.profileFirstName,
    required this.profileLastName,
    required this.profileEmail,
    required this.profileIsStaff,
    required this.profileIsActive,
    required this.profileDateJoined,
    required this.profileLastLogin,
  });
}
