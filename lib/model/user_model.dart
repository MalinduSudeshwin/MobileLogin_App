class User {
  // Define final variables for user properties
  final String userCode;
  final String displayName;
  final String email;
  final String employeeCode;
  final String companyCode;

  User({
    required this.userCode,
    required this.displayName,
    required this.email,
    required this.employeeCode,
    required this.companyCode,
  });

// Factory constructor to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userCode: json['User_Code'],
      displayName: json['User_Display_Name'],
      email: json['Email'],
      employeeCode: json['User_Employee_Code'],
      companyCode: json['Company_Code'],
    );
  }

  factory User.fromJson1(Map<String, dynamic> json) {
    return User(
      userCode: json['userCode'],
      displayName: json['displayName'],
      email: json['email'],
      employeeCode: json['employeeCode'],
      companyCode: json['companyCode'],
    );
  }

  // Method to convert User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'userCode': userCode,
      'displayName': displayName,
      'email': email,
      'employeeCode': employeeCode,
      'companyCode': companyCode,
    };
  }
}
