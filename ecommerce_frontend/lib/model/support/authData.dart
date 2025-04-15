class AuthData {
  String accessToken;
  String refreshToken;
  String? error;  // Il campo error è opzionale
  int expiresIn;

  AuthData({
    required this.accessToken,
    required this.refreshToken,
    this.error,  // Campo opzionale
    required this.expiresIn,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      error: json.containsKey('error_description') ? json['error_description'] : null,
      expiresIn: json['expires_in'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'AuthenticationData{accessToken: $accessToken, refreshToken: $refreshToken, error: $error, expiresIn: $expiresIn}';
  }

  bool hasError() {
    return error != null;
  }
}