import 'dart:ui';

import 'package:animated_page_reveal/src/page_view_model.dart';
import 'package:flutter/material.dart';

// Page indicator logic
class PagerIndicator extends StatelessWidget {
  const PagerIndicator({Key? key, required this.viewModel}) : super(key: key);

  final PagerIndicatorViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];

    for (var i = 0; i < viewModel.pages.length; ++i) {
      final page = viewModel.pages[i];

      double percentActive;

      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.slideDirection == SlideDirection.leftToRight);

      bubbles.add(
        PageBubble(
          viewModel: PageBubbleViewModel(
            page.iconAssetPath,
            page.color,
            isHollow,
            percentActive,
          ),
        ),
      );
    }

    const bubbleWidth = 55.0;
    final baseTranslation =
        ((viewModel.pages.length * bubbleWidth) / 2) - (bubbleWidth / 2);
    var translation = baseTranslation - (viewModel.activeIndex * bubbleWidth);

    if (viewModel.slideDirection == SlideDirection.leftToRight) {
      translation += bubbleWidth * viewModel.slidePercent;
    } else if (viewModel.slideDirection == SlideDirection.rightToLeft) {
      translation -= bubbleWidth * viewModel.slidePercent;
    }
    return Column(
      children: [
        Expanded(child: Container()),
        Transform(
          transform: Matrix4.translationValues(translation, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ),
        ),
      ],
    );
  }
}

// Slide directions
enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

// View Model for page indicator
class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
      this.pages, this.activeIndex, this.slideDirection, this.slidePercent);
}

// Page bubble logic
class PageBubble extends StatelessWidget {
  const PageBubble({Key? key, required this.viewModel}) : super(key: key);

  final PageBubbleViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55.0,
      height: 65.0,
      child: Center(
        child: Container(
          width: lerpDouble(20.0, 45.0, viewModel.activePercent),
          height: lerpDouble(20.0, 45.0, viewModel.activePercent),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: viewModel.isHollow
                ? const Color(0x88ffffff)
                    .withAlpha((0x88 * viewModel.activePercent).round())
                : const Color(0x88ffffff),
            border: Border.all(
              color: viewModel.isHollow
                  ? const Color(0x88ffffff).withAlpha(
                      (0x88 * (1.0 - viewModel.activePercent)).round())
                  : Colors.transparent,
              width: 3.0,
            ),
          ),
          child: Opacity(
            opacity: viewModel.activePercent,
            child: Image.asset(
              viewModel.iconAssetPath,
              color: viewModel.color,
            ),
          ),
        ),
      ),
    );
  }
}

// View Model for page bubble
class PageBubbleViewModel {
  final String iconAssetPath;
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
      this.iconAssetPath, this.color, this.isHollow, this.activePercent);
}
