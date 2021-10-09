class Token {
  String accessToken;
  String tokenType;

  Token({
    required this.accessToken,
    required this.tokenType
  });

  factory Token.fromJson(Map<String, dynamic> token) => Token(
    accessToken: token['access_token'],
    tokenType: token['token_type']
  );
}
