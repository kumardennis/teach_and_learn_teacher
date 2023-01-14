class UserModel {
  final String id;
  final String created_at;
  final String firstName;
  final String lastName;
  final String? profileImage;
  final int? rating;
  final String? proofOfAuthenticity;
  final String? proofOfIdentity;
  final double? allEarnings;
  final double? amountToBePaid;
  final String userId;
  final String? phone;
  final String? email;
  final String accessToken;

  UserModel(
      this.id,
      this.created_at,
      this.firstName,
      this.lastName,
      this.profileImage,
      this.rating,
      this.proofOfAuthenticity,
      this.proofOfIdentity,
      this.allEarnings,
      this.amountToBePaid,
      this.userId,
      this.email,
      this.phone,
      this.accessToken);
}
