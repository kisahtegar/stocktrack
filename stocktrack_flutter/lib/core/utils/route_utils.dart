enum AppPage {
  signIn,
  dashboard,
  error,
  underConstruction,
}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.signIn:
        return '/signin';
      case AppPage.dashboard:
        return '/dashboard';
      case AppPage.error:
        return '/error';
      case AppPage.underConstruction:
        return '/under-construction';
    }
  }

  String get toName {
    switch (this) {
      case AppPage.signIn:
        return 'SIGNIN';
      case AppPage.dashboard:
        return 'DASHBOARD';
      case AppPage.error:
        return 'ERROR';
      case AppPage.underConstruction:
        return 'UNDERCONSTRUCTION';
    }
  }
}
