class UserData {
  String? gender;
  String? age;
  String? socialLife;
  String? socialMediaUsage;
  String? sleepPatterns;
  String? academicFocus;

  UserData({
    this.gender,
    this.age,
    this.socialLife,
    this.socialMediaUsage,
    this.sleepPatterns,
    this.academicFocus,
  });

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'age': age,
      'socialLife': socialLife,
      'socialMediaUsage': socialMediaUsage,
      'sleepPatterns': sleepPatterns,
      'academicFocus': academicFocus,
    }; 
  }
}
