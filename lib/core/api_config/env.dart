enum Environment { dev, prod }

class Env {
  static Environment current = Environment.dev;

  static String get baseUrl {
    switch (current) {
      case Environment.dev:
        return "https://rickandmortyapi.com/api";
      case Environment.prod:
        return "https://rickandmortyapi.com/api";
    }
  }
}
