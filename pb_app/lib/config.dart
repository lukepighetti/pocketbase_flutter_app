class Config {
  static const baseUrl = String.fromEnvironment(
    'baseUrl',
    defaultValue: 'http://192.168.100.8:8090',
  );

  static const skipLogin = true;
}
