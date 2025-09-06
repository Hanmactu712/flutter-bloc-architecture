enum Environment { development, testing, staging, production }

class EnvironmentConfig {
  final String baseApiUrl;
  final Environment environment;

  EnvironmentConfig({
    required this.baseApiUrl,
    this.environment = Environment.development,
  });

  static EnvironmentConfig development = EnvironmentConfig(
    baseApiUrl: "http://192.168.1.6:5000",
    environment: Environment.development,
  );

  static EnvironmentConfig production = EnvironmentConfig(
    baseApiUrl: "https://api.example.net",
    environment: Environment.production,
  );

  static EnvironmentConfig staging = EnvironmentConfig(
    baseApiUrl: "http://[Ip_address]:9001",
    environment: Environment.staging,
  );

  static EnvironmentConfig testing = EnvironmentConfig(
    baseApiUrl: "http://[Ip_address]:8001",
    environment: Environment.testing,
  );
}
