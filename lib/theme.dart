// import 'package:flutter/material.dart';

// // Custom Theme Extension for Pet App-specific colors
// class PetAppThemeExtension extends ThemeExtension<PetAppThemeExtension> {
//   final Color backgroundCircle1;
//   final Color backgroundCircle2;
//   final Color boneColor;
//   final Color heartColor;

//   PetAppThemeExtension({
//     required this.backgroundCircle1,
//     required this.backgroundCircle2,
//     required this.boneColor,
//     required this.heartColor,
//   });

//   @override
//   PetAppThemeExtension copyWith({
//     Color? backgroundCircle1,
//     Color? backgroundCircle2,
//     Color? boneColor,
//     Color? heartColor,
//   }) {
//     return PetAppThemeExtension(
//       backgroundCircle1: backgroundCircle1 ?? this.backgroundCircle1,
//       backgroundCircle2: backgroundCircle2 ?? this.backgroundCircle2,
//       boneColor: boneColor ?? this.boneColor,
//       heartColor: heartColor ?? this.heartColor,
//     );
//   }

//   @override
//   PetAppThemeExtension lerp(ThemeExtension<PetAppThemeExtension>? other, double t) {
//     if (other is! PetAppThemeExtension) {
//       return this;
//     }
//     return PetAppThemeExtension(
//       backgroundCircle1: Color.lerp(backgroundCircle1, other.backgroundCircle1, t)!,
//       backgroundCircle2: Color.lerp(backgroundCircle2, other.backgroundCircle2, t)!,
//       boneColor: Color.lerp(boneColor, other.boneColor, t)!,
//       heartColor: Color.lerp(heartColor, other.heartColor, t)!,
//     );
//   }
// }

// // Pet App Theme
// class PetAppTheme {
//   static ThemeData get lightTheme {
//     return ThemeData(
//       // Primary Color
//       primaryColor: Color(0xFFEF6C00), // Warm orange
//       scaffoldBackgroundColor: Color(0xFFE6F0FA), // Light blue background

//       // App Bar Theme
//       appBarTheme: AppBarTheme(
//         backgroundColor: Color(0xFFE6F0FA),
//         elevation: 0,
//         iconTheme: IconThemeData(color: Color(0xFFEF6C00)),
//         titleTextStyle: TextStyle(
//           color: Color(0xFFEF6C00),
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Poppins',
//         ),
//       ),

//       // Text Theme
//       textTheme: TextTheme(
//         headlineLarge: TextStyle(
//           fontSize: 40,
//           fontWeight: FontWeight.bold,
//           color: Color(0xFFEF6C00),
//           fontFamily: 'Poppins',
//           shadows: [
//             Shadow(
//               color: Colors.black.withOpacity(0.1),
//               offset: Offset(2, 2),
//               blurRadius: 5,
//             ),
//           ],
//         ),
//         headlineMedium: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: Color(0xFFEF6C00),
//           fontFamily: 'Poppins',
//         ),
//         bodyMedium: TextStyle(
//           fontSize: 16,
//           color: Colors.black87,
//           fontFamily: 'Poppins',
//         ),
//         bodySmall: TextStyle(
//           fontSize: 14,
//           color: Colors.black54,
//           fontFamily: 'Poppins',
//         ),
//         labelLarge: TextStyle(
//           fontSize: 16,
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Poppins',
//         ),
//       ),

//       // Card Theme (for the bottom container, though not used in OTPScreen)
//       cardTheme: CardTheme(
//         color: Colors.white,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         shadowColor: Colors.black.withOpacity(0.1),
//         margin: EdgeInsets.zero,
//       ),

//       // Input Decoration Theme (for TextField)
//       // inputDecorationTheme: InputDecorationTheme(
//       //   filled: true,
//       //   fillColor: Color(0xFFE6F0FA),
//       //   prefixIconColor: Color(0xFFEF6C00),
//       //   hintStyle: TextStyle(
//       //     color: Color(0xFFEF6C00).withOpacity(0.3),
//       //     fontFamily: 'Poppins',
//       //   ),
//       //   border: InputBorder.none, // Ensure no border to allow custom shapes
//       //   focusedBorder: InputBorder.none,
//       //   enabledBorder: InputBorder.none,
//       // ),

//       // Elevated Button Theme
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xFFEF6C00),
//           foregroundColor: Colors.white,
//           minimumSize: Size(double.infinity, 50),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25),
//           ),
//           elevation: 5,
//           textStyle: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Poppins',
//           ),
//         ),
//       ),

//       // Icon Theme
//       iconTheme: IconThemeData(
//         color: Color(0xFFEF6C00),
//       ),

//       // Extensions for custom pet app colors
//       extensions: <ThemeExtension<dynamic>>[
//         PetAppThemeExtension(
//           backgroundCircle1: Color(0xFFFFE082).withOpacity(0.3), // Soft yellow circle
//           backgroundCircle2: Color(0xFFB2DFDB).withOpacity(0.3), // Soft teal circle
//           boneColor: Color(0xFFFFA726), // Orange for bones
//           heartColor: Color(0xFFFF5252), // Red for hearts
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';

// Custom Theme Extension for Pet App-specific colors
class PetAppThemeExtension extends ThemeExtension<PetAppThemeExtension> {
  final Color backgroundCircle1;
  final Color backgroundCircle2;
  final Color boneColor;
  final Color heartColor;

  PetAppThemeExtension({
    required this.backgroundCircle1,
    required this.backgroundCircle2,
    required this.boneColor,
    required this.heartColor,
  });

  @override
  PetAppThemeExtension copyWith({
    Color? backgroundCircle1,
    Color? backgroundCircle2,
    Color? boneColor,
    Color? heartColor,
  }) {
    return PetAppThemeExtension(
      backgroundCircle1: backgroundCircle1 ?? this.backgroundCircle1,
      backgroundCircle2: backgroundCircle2 ?? this.backgroundCircle2,
      boneColor: boneColor ?? this.boneColor,
      heartColor: heartColor ?? this.heartColor,
    );
  }

  @override
  PetAppThemeExtension lerp(ThemeExtension<PetAppThemeExtension>? other, double t) {
    if (other is! PetAppThemeExtension) {
      return this;
    }
    return PetAppThemeExtension(
      backgroundCircle1: Color.lerp(backgroundCircle1, other.backgroundCircle1, t)!,
      backgroundCircle2: Color.lerp(backgroundCircle2, other.backgroundCircle2, t)!,
      boneColor: Color.lerp(boneColor, other.boneColor, t)!,
      heartColor: Color.lerp(heartColor, other.heartColor, t)!,
    );
  }
}

// Pet App Theme
class PetAppTheme {
  // Light Theme (unchanged)
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFFEF6C00),
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFE6F0FA),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFEF6C00)),
        titleTextStyle: TextStyle(
          color: Color(0xFFEF6C00),
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Color(0xFFEF6C00),
          fontFamily: 'Poppins',
          shadows: [
            Shadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
          ],
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFFEF6C00),
          fontFamily: 'Poppins',
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontFamily: 'Poppins',
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: Colors.black54,
          fontFamily: 'Poppins',
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        shadowColor: Colors.black.withOpacity(0.1),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF6C00),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 5,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFFEF6C00),
      ),
      extensions: <ThemeExtension<dynamic>>[
        PetAppThemeExtension(
          backgroundCircle1: const Color(0xFFFFE082).withOpacity(0.3),
          backgroundCircle2: const Color(0xFFB2DFDB).withOpacity(0.3),
          boneColor: const Color(0xFFFFA726),
          heartColor: const Color(0xFFFF5252),
        ),
      ],
    );
  }

  // Updated Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      // Primary Color (retained for consistency)
      primaryColor: const Color(0xFFEF6C00), // Warm orange
      scaffoldBackgroundColor: const Color(0xFF121A26), // Slightly lighter dark blue background

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121A26),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFEF6C00)),
        titleTextStyle: TextStyle(
          color: Color(0xFFEF6C00),
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Color(0xFFEF6C00),
          fontFamily: 'Poppins',
          shadows: [
            Shadow(
              color: Colors.black87,
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
          ],
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFFEF6C00),
          fontFamily: 'Poppins',
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.white, // Brighter white for better contrast
          fontFamily: 'Poppins',
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: Color(0xFFCFD8DC), // Light gray for secondary text
          fontFamily: 'Poppins',
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: const Color(0xFF1E2A38), // Lighter dark shade for cards to create contrast
        elevation: 5, // Added elevation for depth
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        shadowColor: Colors.black.withOpacity(0.4), // Darker shadow for depth
        margin: EdgeInsets.zero,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF6C00),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 5,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          shadowColor: const Color(0xFFEF6C00).withOpacity(0.3), // Subtle glow effect
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: Color(0xFFEF6C00),
      ),

      // Extensions for custom pet app colors (brighter for dark theme)
      extensions: <ThemeExtension<dynamic>>[
        PetAppThemeExtension(
          backgroundCircle1: const Color(0xFFFFE082).withOpacity(0.4), // Brighter yellow
          backgroundCircle2: const Color(0xFFB2DFDB).withOpacity(0.4), // Brighter teal
          boneColor: const Color(0xFFFFA726), // Full opacity for vibrancy
          heartColor: const Color(0xFFFF5252), // Full opacity for vibrancy
        ),
      ],
    );
  }
}