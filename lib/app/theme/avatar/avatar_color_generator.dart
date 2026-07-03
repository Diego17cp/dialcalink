import 'avatar_color_scheme.dart';
import 'avatar_palette.dart';

class AvatarColorGenerator {
  const AvatarColorGenerator._();

  static AvatarColorScheme fromSeed(String seed) {
    final hash = seed.hashCode.abs();

    return AvatarPalette.schemes[
      hash % AvatarPalette.schemes.length
    ];
  }
}