import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KeeleyColorScheme extends ShadColorScheme {
  const KeeleyColorScheme._({
    required super.background,
    required super.foreground,
    required super.card,
    required super.cardForeground,
    required super.popover,
    required super.popoverForeground,
    required super.primary,
    required super.primaryForeground,
    required super.secondary,
    required super.secondaryForeground,
    required super.muted,
    required super.mutedForeground,
    required super.accent,
    required super.accentForeground,
    required super.destructive,
    required super.destructiveForeground,
    required super.border,
    required super.input,
    required super.ring,
    required super.selection,
  });

  // Light Theme
  const KeeleyColorScheme.light()
      : this._(
          background: const Color(0xFFFFFFFF), // 0 0% 100%
          foreground: const Color(0xFF0F172A), // 222.2 84% 4.9%
          card: const Color(0xFFFFFFFF), // 0 0% 100%
          cardForeground: const Color(0xFF0F172A), // 222.2 84% 4.9%
          popover: const Color(0xFFFFFFFF), // 0 0% 100%
          popoverForeground: const Color(0xFF0F172A), // 222.2 84% 4.9%
          primary: const Color(0xFFFF4265), // 349 100% 63% - Dein Pink-Rot
          primaryForeground: const Color(0xFFFFFFFF), // 0 0% 100%
          secondary: const Color(0xFFF1F5F9), // 210 40% 96.1%
          secondaryForeground: const Color(0xFF1E293B), // 222.2 47.4% 11.2%
          muted: const Color(0xFFF1F5F9), // 210 40% 96.1%
          mutedForeground: const Color(0xFF64748B), // 215.4 16.3% 46.9%
          accent: const Color(0xFFF1F5F9), // 210 40% 96.1%
          accentForeground: const Color(0xFF1E293B), // 222.2 47.4% 11.2%
          destructive: const Color(0xFFEF4444), // 0 84.2% 60.2%
          destructiveForeground: const Color(0xFFFEFEFE), // 210 40% 98%
          border: const Color(0xFFE2E8F0), // 214.3 31.8% 91.4%
          input: const Color(0xFFE2E8F0), // 214.3 31.8% 91.4%
          ring: const Color(0xFFFF4265), // 349 100% 63%
          selection: const Color(0x33FF4265), // Primary mit Transparenz
        );

  // Dark Theme
  const KeeleyColorScheme.dark()
      : this._(
          background: const Color(0xFF1A202C), // 213 30.3% 12.94%
          foreground: const Color(0xFFFBFCFD), // 90 40% 98.04%
          card: const Color(0xFF2D3748), // 213.91 26.44% 17.06%
          cardForeground: const Color(0xFFFBFCFD), // 90 40% 98.04%
          popover: const Color(0xFF2D3748), // 213.91 26.44% 17.06%
          popoverForeground: const Color(0xFFFBFCFD), // 90 40% 98.04%
          primary: const Color(0xFFFF4265), // 349 100% 63% - Gleiches Pink-Rot
          primaryForeground: const Color(0xFFFFFFFF), // 0 0% 100%
          secondary: const Color(0xFF2D3748), // 213.91 26.44% 17.06%
          secondaryForeground: const Color(0xFFFBFCFD), // 90 40% 98.04%
          muted: const Color(0xFF4A5568), // 218.82 17.89% 18.63%
          mutedForeground: const Color(0xFFD1D5DB), // 0 0% 82.35%
          accent: const Color(0xFF1A1B23), // 220.91 39.29% 10.98%
          accentForeground: const Color(0xFFFBFCFD), // 90 40% 98.04%
          destructive: const Color(0xFFEF4444), // 0 84.2% 60.2%
          destructiveForeground: const Color(0xFFFEFEFE), // 210 40% 98%
          border: const Color(0xFF4A5568), // 213.75 13.15% 25.83%
          input: const Color(0xFF718096), // 213.75 9.2% 34.12%
          ring: const Color(0xFFFF4265), // 349 100% 63%
          selection: const Color(0x33FF4265), // Primary mit Transparenz
        );
}

// Zusätzliche Chart-Farben basierend auf deinem CSS
class KeeleyChartColors {
  static const Color chart1 = Color(0xFFFF4265); // --chart-1: #FF4265
  static const Color chart2 = Color(0xFFF76E87); // --chart-2: #F76E87
  static const Color chart3 = Color(0xFFFFB057); // --chart-3: #FFB057
  static const Color chart4 = Color(0xFFF5CFA3); // --chart-4: #F5CFA3
  static const Color chart5 = Color(0xFFF5E7D6); // --chart-5: #F5E7D6

  static const List<Color> all = [chart1, chart2, chart3, chart4, chart5];
}

class Sizes {
  static const p4 = 4.0;
  static const p8 = 8.0;
  static const p12 = 12.0;
  static const p16 = 16.0;
  static const p20 = 20.0;
  static const p24 = 24.0;
  static const p32 = 32.0;
  static const p48 = 48.0;
  static const p64 = 64.0;
}

/// Constant gap widths
const gapW4 = SizedBox(width: Sizes.p4);
const gapW8 = SizedBox(width: Sizes.p8);
const gapW12 = SizedBox(width: Sizes.p12);
const gapW16 = SizedBox(width: Sizes.p16);
const gapW20 = SizedBox(width: Sizes.p20);
const gapW24 = SizedBox(width: Sizes.p24);
const gapW32 = SizedBox(width: Sizes.p32);
const gapW48 = SizedBox(width: Sizes.p48);
const gapW64 = SizedBox(width: Sizes.p64);

/// Constant gap heights
const gapH4 = SizedBox(height: Sizes.p4);
const gapH8 = SizedBox(height: Sizes.p8);
const gapH12 = SizedBox(height: Sizes.p12);
const gapH16 = SizedBox(height: Sizes.p16);
const gapH20 = SizedBox(height: Sizes.p20);
const gapH24 = SizedBox(height: Sizes.p24);
const gapH32 = SizedBox(height: Sizes.p32);
const gapH48 = SizedBox(height: Sizes.p48);
const gapH64 = SizedBox(height: Sizes.p64);
