abstract class ThemeEvent {}

class ChangeThemeEvent extends ThemeEvent {
  bool isDarkMode;
  ChangeThemeEvent(this.isDarkMode);
}

class RefreshThemeEvent extends ThemeEvent {}
