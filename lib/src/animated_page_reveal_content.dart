import 'dart:async';

import 'package:animated_page_reveal/src/page_dragger.dart';
import 'package:animated_page_reveal/src/page_reveal.dart';
import 'package:animated_page_reveal/src/page_view_model.dart';
import 'package:animated_page_reveal/src/pager_indicator.dart';
import 'package:animated_page_reveal/src/pages.dart';
import 'package:flutter/material.dart';

class AnimatedPageReveal extends StatefulWidget {
  /// Children pages.
  final List<PageViewModel> children;

  const AnimatedPageReveal({Key? key, required this.children})
      : super(key: key);

  @override
  _AnimatedPageRevealState createState() => _AnimatedPageRevealState();
}

class _AnimatedPageRevealState extends State<AnimatedPageReveal>
    with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger? animatedPageDragger;

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  _AnimatedPageRevealState()
      : slideUpdateStream = StreamController<SlideUpdate>() {
    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = AnimatedPageDragger(slideDirection,
                TransitionGoal.open, slidePercent, slideUpdateStream, this);
          } else {
            animatedPageDragger = AnimatedPageDragger(slideDirection,
                TransitionGoal.close, slidePercent, slideUpdateStream, this);

            nextPageIndex = activeIndex;
          }
          animatedPageDragger!.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger!.dispose();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    setContent(
        Color color,
        String title,
        String description,
        String imageAssetPath,
        String iconAssetPath,
        TextStyle? titleStyle,
        TextStyle? descriptionStyle) {
      return PageViewModel(
          color: color,
          title: title,
          titleStyle: titleStyle,
          description: description,
          descriptionStyle: descriptionStyle,
          iconAssetPath: iconAssetPath,
          imageAssetPath: imageAssetPath);
    }

    List<PageViewModel> _getChildrenList() {
      return widget.children.map((PageViewModel child) {
        return setContent(
            child.color,
            child.title,
            child.description,
            child.imageAssetPath,
            child.iconAssetPath,
            child.titleStyle,
            child.descriptionStyle);
      })
          // .toList()
          // .reversed
          .toList();
    }

    var pagesChildren = _getChildrenList();

    List<PageViewModel> pages = List.from(pagesChildren);
    return Scaffold(
      body: Stack(
        children: [
          PageContent(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          PageReveal(
            revealPercent: slidePercent,
            child: PageContent(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          PagerIndicator(
            viewModel: PagerIndicatorViewModel(
                pages, activeIndex, slideDirection, slidePercent),
          ),
          PageDragger(
            slideUpdateStream: slideUpdateStream,
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
          ),
        ],
      ),
    );
  }
}
