import 'package:flutter/painting.dart';

/// Dominus color palette tokens (dark).
///
/// Sourced from the Dominus Figma design system (`Color` collection, Dark
/// mode). Wine-red brand, brass accent, plus role and status colors.
/// Dominus ships dark-only; light values are intentionally omitted.
abstract class DominusColors {
  // ---------------------------------------------------------------------------
  // Backgrounds — bg/*
  // ---------------------------------------------------------------------------

  /// App canvas / scaffold background.
  static const Color bgCanvas = Color(0xFF0E0B0F);

  /// Default surface (cards, containers).
  static const Color bgSurface = Color(0xFF17131A);

  /// Elevated surface (sheets, popovers, raised cards).
  static const Color bgSurfaceElevated = Color(0xFF221B28);

  // ---------------------------------------------------------------------------
  // Borders — border/*
  // ---------------------------------------------------------------------------

  /// Subtle divider / hairline.
  static const Color borderSubtle = Color(0xFF2A2430);

  /// Default / emphasized border.
  static const Color borderDefault = Color(0xFF3A3340);

  // ---------------------------------------------------------------------------
  // Text — text/*
  // ---------------------------------------------------------------------------

  /// Primary text — headings, body copy.
  static const Color textPrimary = Color(0xFFF5F1F4);

  /// Secondary text — labels, metadata.
  static const Color textSecondary = Color(0xFFB6ABB8);

  /// Muted text — hints, placeholders.
  static const Color textMuted = Color(0xFF7C7280);

  /// Foreground on top of [brandPrimary].
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Brand — brand/* (Wine)
  // ---------------------------------------------------------------------------

  /// Main brand wine-red.
  static const Color brandPrimary = Color(0xFF9B2242);

  /// Brand hovered state.
  static const Color brandPrimaryHover = Color(0xFFB12C50);

  /// Brand pressed state.
  static const Color brandPrimaryPress = Color(0xFF7E1A36);

  /// Subtle brand-tinted surface.
  static const Color brandPrimarySubtle = Color(0xFF2A121A);

  /// Brand-tinted border for primary surfaces (derived).
  static const Color brandPrimaryBorder = Color(0xFF5A2334);

  // ---------------------------------------------------------------------------
  // Accent — accent/* (Brass)
  // ---------------------------------------------------------------------------

  /// Brass accent.
  static const Color brass = Color(0xFFC9A66B);

  /// Subtle brass-tinted surface.
  static const Color brassSubtle = Color(0xFF2A2417);

  // ---------------------------------------------------------------------------
  // Roles — role/* (Dominus domain)
  // ---------------------------------------------------------------------------

  /// Dom role color (brass).
  static const Color roleDom = Color(0xFFC9A66B);

  /// Sub role color (rose).
  static const Color roleSub = Color(0xFFC77A93);

  /// Subtle rose-tinted surface for sub-role accents (derived).
  static const Color roleSubSubtle = Color(0xFF2A171D);

  // ---------------------------------------------------------------------------
  // Status — status/*
  // ---------------------------------------------------------------------------

  /// Success indicator.
  static const Color success = Color(0xFF4E9A6B);

  /// Success surface (derived dark tint).
  static const Color successSurface = Color(0xFF15271C);

  /// Success foreground text (derived light tint).
  static const Color successText = Color(0xFF8FD9AB);

  /// Warning indicator.
  static const Color warning = Color(0xFFD89A3F);

  /// Warning surface (derived dark tint).
  static const Color warningSurface = Color(0xFF2A2113);

  /// Warning foreground text (derived light tint).
  static const Color warningText = Color(0xFFEEC07A);

  /// Danger / destructive indicator.
  static const Color danger = Color(0xFFE5484D);

  /// Danger surface (derived dark tint).
  static const Color dangerSurface = Color(0xFF2E1517);

  /// Danger foreground text (derived light tint).
  static const Color dangerText = Color(0xFFF2999B);

  /// Safeword — highest-priority stop signal.
  static const Color safeword = Color(0xFFFF3B30);

  /// Safeword / urgency surface (derived dark tint).
  static const Color safewordSurface = Color(0xFF2E1413);

  /// Info indicator.
  static const Color info = Color(0xFF6E97F0);

  /// Info surface (derived dark tint).
  static const Color infoSurface = Color(0xFF15203A);

  /// Info foreground text (derived light tint).
  static const Color infoText = Color(0xFFA8C2F7);

  /// Pure white.
  static const Color white = Color(0xFFFFFFFF);
}
