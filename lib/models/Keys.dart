class ApiKeys {
  final String key;
  final String value;

  ApiKeys({this.key, this.value});

  factory ApiKeys.fromJson(Map<String, dynamic> parsedJson) {
    return new ApiKeys(key: parsedJson['key'], value: parsedJson['value']);
  }
}
