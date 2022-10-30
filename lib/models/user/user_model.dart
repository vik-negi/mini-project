import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? jwtoken;
  Data? data;
  String? status;
  String? message;
  String? accountType;

  UserModel({
    this.jwtoken,
    this.data,
    this.status,
    this.message,
    this.accountType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jwtoken': jwtoken,
      'data': data?.toMap(),
      'status': status,
      'message': message,
      'accountType': accountType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      jwtoken: map['jwtoken'] != null ? map['jwtoken'] as String : null,
      data: map['data'] != null
          ? Data.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      accountType:
          map['accountType'] != null ? map['accountType'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Data {
  int? personId;
  String name;
  DateTime? birthDate;
  String email;
  String? mobile;
  String username;
  String? location;
  String password;
  String id;
  String? jti;
  String? profileImage;
  String? profileCreatedAt;
  LastUpdate? lastUpdate;
  bool? isVerified;
  bool? isDeleted;
  bool? isBlocked;
  bool? isOnline;
  bool? isProfileCompleted;
  bool? isMobileVerified;
  bool? isEmailVerified;
  List<dynamic>? follower;
  List<dynamic>? following;
  List<dynamic>? post;
  int? age;
  String? gender;
  String? bio;
  String? website;
  List<SocialMedia>? socialMedia;
  List<String>? interest;
  int? profileViews;
  Data({
    this.personId,
    required this.name,
    this.birthDate,
    required this.email,
    this.mobile,
    required this.username,
    this.location,
    required this.password,
    required this.id,
    this.jti,
    this.profileImage,
    this.profileCreatedAt,
    this.lastUpdate,
    this.isVerified,
    this.isDeleted,
    this.isBlocked,
    this.isOnline,
    this.isProfileCompleted,
    this.isMobileVerified,
    this.isEmailVerified,
    this.follower,
    this.following,
    this.post,
    this.age,
    this.gender,
    this.bio,
    this.website,
    this.socialMedia,
    this.interest,
    this.profileViews,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'personId': personId,
      'name': name,
      'birthDate': birthDate?.millisecondsSinceEpoch,
      'email': email,
      'mobile': mobile,
      'username': username,
      'location': location,
      'password': password,
      'id': id,
      'jti': jti,
      'profileImage': profileImage,
      'profileCreatedAt': profileCreatedAt,
      'lastUpdate': lastUpdate?.toMap(),
      'isVerified': isVerified,
      'isDeleted': isDeleted,
      'isBlocked': isBlocked,
      'isOnline': isOnline,
      'isProfileCompleted': isProfileCompleted,
      'isMobileVerified': isMobileVerified,
      'isEmailVerified': isEmailVerified,
      'follower': follower,
      'following': following,
      'post': post,
      'age': age,
      'gender': gender,
      'bio': bio,
      'website': website,
      'socialMedia': socialMedia?.map((x) => x.toMap()).toList() ?? [],
      'interest': interest,
      'profileViews': profileViews,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      personId: map['personId'] != null ? map['personId'] as int : null,
      name: map['name'],
      birthDate: map['birthDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthDate'] as int)
          : null,
      email: map['email'],
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      username: map['username'],
      location: map['location'] != null ? map['location'] as String : null,
      password: map['password'],
      id: map['id'],
      jti: map['jti'] != null ? map['jti'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      profileCreatedAt: map['profileCreatedAt'] != null
          ? map['profileCreatedAt'] as String
          : null,
      lastUpdate: map['lastUpdate'] != null
          ? LastUpdate.fromMap(map['lastUpdate'] as Map<String, dynamic>)
          : null,
      isVerified: map['isVerified'] != null ? map['isVerified'] as bool : false,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : false,
      isBlocked: map['isBlocked'] != null ? map['isBlocked'] as bool : false,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : false,
      isProfileCompleted: map['isProfileCompleted'] != null
          ? map['isProfileCompleted'] as bool
          : false,
      isMobileVerified: map['isMobileVerified'] != null
          ? map['isMobileVerified'] as bool
          : null,
      isEmailVerified: map['isEmailVerified'] != null
          ? map['isEmailVerified'] as bool
          : null,
      follower: map['follower'] != null
          ? List<dynamic>.from(map['follower'] as List<dynamic>)
          : null,
      following: map['following'] != null
          ? List<dynamic>.from(map['following'] as List<dynamic>)
          : null,
      post: map['post'] != null
          ? List<dynamic>.from(map['post'] as List<dynamic>)
          : null,
      age: map['age'] != null ? map['age'] as int : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      website: map['website'] != null ? map['website'] as String : null,
      socialMedia: map['socialMedia'] != null
          ? List<SocialMedia>.from(
              (map['socialMedia'] as List<int>).map<SocialMedia?>(
                (x) => SocialMedia.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      interest: map['interest'] != null
          ? List<String>.from((map['interest'] as List<String>))
          : null,
      profileViews:
          map['profileViews'] != null ? map['profileViews'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LastUpdate {
  String? whatUpdated;
  dynamic previousData;
  DateTime? dateTime;
  LastUpdate({
    this.whatUpdated,
    required this.previousData,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'whatUpdated': whatUpdated,
      'previousData': previousData,
      'dateTime': dateTime?.millisecondsSinceEpoch,
    };
  }

  factory LastUpdate.fromMap(Map<String, dynamic> map) {
    return LastUpdate(
      whatUpdated:
          map['whatUpdated'] != null ? map['whatUpdated'] as String : null,
      previousData: map['previousData'] as dynamic,
      dateTime: map['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LastUpdate.fromJson(String source) =>
      LastUpdate.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SocialMedia {
  String? name;
  String? link;
  SocialMedia({
    this.name,
    this.link,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'link': link,
    };
  }

  factory SocialMedia.fromMap(Map<String, dynamic> map) {
    return SocialMedia(
      name: map['name'] != null ? map['name'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialMedia.fromJson(String source) =>
      SocialMedia.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Organization {
  String organizatioName;
  String organizatioType;
  String? organizatioEmail;
  String? organizatioMobile;
  String? organizatioLocation;
  String? organizatioWebsite;
  String? organizatioBio;
  String? organizatioProfileImage;
  String? organizatioCoverImage;
  String? organizatioId;
  String? country;
  String? headquaterState;
  String? headquaterCity;
  String? zipCode;
  List<UserModel>? userModel;
  bool? isVerifiedOrganization = false;
  bool? isBlockedOrganization = false;
  bool? isProfileCompletedOrganization = false;
  bool? isMobileVerifiedOrganization = false;
  bool? isEmailVerifiedOrganization = false;
  List<Document>? document;
  bool isRequiredDocumentVerified = false;
  Organization({
    required this.organizatioName,
    required this.organizatioType,
    this.organizatioEmail,
    this.organizatioMobile,
    this.organizatioLocation,
    this.organizatioWebsite,
    this.organizatioBio,
    this.organizatioProfileImage,
    this.organizatioCoverImage,
    this.organizatioId,
    this.country,
    this.headquaterState,
    this.headquaterCity,
    this.zipCode,
    this.userModel,
    this.isVerifiedOrganization,
    this.isBlockedOrganization,
    this.isProfileCompletedOrganization,
    this.isMobileVerifiedOrganization,
    this.isEmailVerifiedOrganization,
    this.document,
    required this.isRequiredDocumentVerified,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'organizatioName': organizatioName,
      'organizatioType': organizatioType,
      'organizatioEmail': organizatioEmail,
      'organizatioMobile': organizatioMobile,
      'organizatioLocation': organizatioLocation,
      'organizatioWebsite': organizatioWebsite,
      'organizatioBio': organizatioBio,
      'organizatioProfileImage': organizatioProfileImage,
      'organizatioCoverImage': organizatioCoverImage,
      'organizatioId': organizatioId,
      'country': country,
      'headquaterState': headquaterState,
      'headquaterCity': headquaterCity,
      'zipCode': zipCode,
      'userModel': userModel?.map((x) => x.toMap()).toList() ?? [],
      'isVerifiedOrganization': isVerifiedOrganization,
      'isBlockedOrganization': isBlockedOrganization,
      'isProfileCompletedOrganization': isProfileCompletedOrganization,
      'isMobileVerifiedOrganization': isMobileVerifiedOrganization,
      'isEmailVerifiedOrganization': isEmailVerifiedOrganization,
      'document': document?.map((x) => x.toMap()).toList() ?? [],
      'isRequiredDocumentVerified': isRequiredDocumentVerified,
    };
  }

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      organizatioName: map['organizatioName'] as String,
      organizatioType: map['organizatioType'] as String,
      organizatioEmail: map['organizatioEmail'] != null
          ? map['organizatioEmail'] as String
          : null,
      organizatioMobile: map['organizatioMobile'] != null
          ? map['organizatioMobile'] as String
          : null,
      organizatioLocation: map['organizatioLocation'] != null
          ? map['organizatioLocation'] as String
          : null,
      organizatioWebsite: map['organizatioWebsite'] != null
          ? map['organizatioWebsite'] as String
          : null,
      organizatioBio: map['organizatioBio'] != null
          ? map['organizatioBio'] as String
          : null,
      organizatioProfileImage: map['organizatioProfileImage'] != null
          ? map['organizatioProfileImage'] as String
          : null,
      organizatioCoverImage: map['organizatioCoverImage'] != null
          ? map['organizatioCoverImage'] as String
          : null,
      organizatioId:
          map['organizatioId'] != null ? map['organizatioId'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      headquaterState: map['headquaterState'] != null
          ? map['headquaterState'] as String
          : null,
      headquaterCity: map['headquaterCity'] != null
          ? map['headquaterCity'] as String
          : null,
      zipCode: map['zipCode'] != null ? map['zipCode'] as String : null,
      userModel: map['userModel'] != null
          ? List<UserModel>.from(
              (map['userModel'] as List<int>).map<UserModel?>(
                (x) => UserModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      isVerifiedOrganization: map['isVerifiedOrganization'] != null
          ? map['isVerifiedOrganization'] as bool
          : null,
      isBlockedOrganization: map['isBlockedOrganization'] != null
          ? map['isBlockedOrganization'] as bool
          : null,
      isProfileCompletedOrganization:
          map['isProfileCompletedOrganization'] != null
              ? map['isProfileCompletedOrganization'] as bool
              : null,
      isMobileVerifiedOrganization: map['isMobileVerifiedOrganization'] != null
          ? map['isMobileVerifiedOrganization'] as bool
          : null,
      isEmailVerifiedOrganization: map['isEmailVerifiedOrganization'] != null
          ? map['isEmailVerifiedOrganization'] as bool
          : null,
      document: map['document'] != null
          ? List<Document>.from(
              (map['document'] as List<int>).map<Document?>(
                (x) => Document.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      isRequiredDocumentVerified: map['isRequiredDocumentVerified'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Organization.fromJson(String source) =>
      Organization.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Document {
  String? documentName;
  String? documentType;
  dynamic documentImage;
  String? documentId;
  String? documentCreatedAt;
  String? documentLastUpdate;
  bool? isVerifiedDocument = false;
  bool? isRejectedDocument = false;
  bool? isProfileCompletedDocument = false;
  bool? isRequiredDocument;
  Document({
    this.documentName,
    this.documentType,
    required this.documentImage,
    this.documentId,
    this.documentCreatedAt,
    this.documentLastUpdate,
    this.isVerifiedDocument,
    this.isRejectedDocument,
    this.isProfileCompletedDocument,
    this.isRequiredDocument,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'documentName': documentName,
      'documentType': documentType,
      'documentImage': documentImage,
      'documentId': documentId,
      'documentCreatedAt': documentCreatedAt,
      'documentLastUpdate': documentLastUpdate,
      'isVerifiedDocument': isVerifiedDocument,
      'isRejectedDocument': isRejectedDocument,
      'isProfileCompletedDocument': isProfileCompletedDocument,
      'isRequiredDocument': isRequiredDocument,
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      documentName:
          map['documentName'] != null ? map['documentName'] as String : null,
      documentType:
          map['documentType'] != null ? map['documentType'] as String : null,
      documentImage: map['documentImage'] as dynamic,
      documentId:
          map['documentId'] != null ? map['documentId'] as String : null,
      documentCreatedAt: map['documentCreatedAt'] != null
          ? map['documentCreatedAt'] as String
          : null,
      documentLastUpdate: map['documentLastUpdate'] != null
          ? map['documentLastUpdate'] as String
          : null,
      isVerifiedDocument: map['isVerifiedDocument'] != null
          ? map['isVerifiedDocument'] as bool
          : null,
      isRejectedDocument: map['isRejectedDocument'] != null
          ? map['isRejectedDocument'] as bool
          : null,
      isProfileCompletedDocument: map['isProfileCompletedDocument'] != null
          ? map['isProfileCompletedDocument'] as bool
          : null,
      isRequiredDocument: map['isRequiredDocument'] != null
          ? map['isRequiredDocument'] as bool
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source) as Map<String, dynamic>);
}
