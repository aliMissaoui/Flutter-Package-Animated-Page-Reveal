import 'package:flutter/material.dart';

/// Provides data for the pages.
class PageViewModel {
  /// Title of the page content.
  final String title;

  /// Description for the page content.
  final String description;

  /// Text Style of the page title.
  final TextStyle? titleStyle;

  /// Text Style of the page description.
  final TextStyle? descriptionStyle;

  /// Page color.
  final Color color;

  /// Main image of the page.
  final String imageAssetPath;

  /// bottom indicator image of the page.
  final String iconAssetPath;

  /// Provides data for the pages.
  PageViewModel({
    required this.title,
    required this.description,
    this.titleStyle,
    this.descriptionStyle,
    required this.color,
    required this.imageAssetPath,
    required this.iconAssetPath,
  });
}
