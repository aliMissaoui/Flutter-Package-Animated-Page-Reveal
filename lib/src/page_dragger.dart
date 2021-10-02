import 'dart:async';
import 'dart:ui';

import 'package:animated_page_reveal/src/pager_indicator.dart';
import 'package:flutter/material.dart';

// Page dragger logic
class PageDragger extends StatefulWidget {
  final bool canDragLeftToRight;
  final bool canDragRightToLeft;
  final StreamController<SlideUpdate> slideUpdateStream;
  const PageDragger(
      {Key? key,
      required this.slideUpdateStream,
      required this.canDragLeftToRight,
      required this.canDragRightToLeft})
      : super(key: key);

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  static const fullTransitionPX = 300.0;
  Offset? dragStart;
  SlideDirection? slideDirection;
  double slidePercent = 0.0;

  onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart!.dx - newPosition.dx;

      if (dx > 0.0 && widget.canDragRightToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0 && widget.canDragLeftToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      if (slideDirection != SlideDirection.none) {
        slidePercent = (dx / fullTransitionPX).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }

      widget.slideUpdateStream.add(
        SlideUpdate(
          slideDirection!,
          slidePercent,
          UpdateType.dragging,
        ),
      );
    }
  }

  onDragEnd(DragEndDetails details) {
    widget.slideUpdateStream.add(
      SlideUpdate(
        SlideDirection.none,
        0.0,
        UpdateType.doneDragging,
      ),
    );
    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }
}

class AnimatedPageDragger {
  static const percentPerMilliSecond = 0.005;

  final SlideDirection slideDirection;
  final TransitionGoal transitionGoal;

  AnimationController? completionAnimationController;
  AnimatedPageDragger(this.slideDirection, this.transitionGoal, slidePercent,
      StreamController<SlideUpdate> slideUpdateStream, TickerProvider vsync) {
    final startlidePercent = slidePercent;
    double endSlidePercent;
    Duration duration;

    if (transitionGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;
      final slideRemaining = 1.0 - slidePercent;
      duration = Duration(
          milliseconds: (slideRemaining / percentPerMilliSecond).round());
    } else {
      endSlidePercent = 0.0;
      duration = Duration(
          milliseconds: (slidePercent / percentPerMilliSecond).round());
    }

    completionAnimationController = AnimationController(
        duration: duration, vsync: vsync)
      ..addListener(() {
        slidePercent = lerpDouble(
          startlidePercent,
          endSlidePercent,
          completionAnimationController!.value,
        );
        slideUpdateStream.add(
            SlideUpdate(slideDirection, slidePercent, UpdateType.animating));
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          slideUpdateStream.add(SlideUpdate(
              slideDirection, endSlidePercent, UpdateType.doneAnimating));
        }
      });
  }

  run() {
    completionAnimationController!.forward(from: 0.0);
  }

  dispose() {
    completionAnimationController!.dispose();
  }
}

enum TransitionGoal {
  open,
  close,
}
enum UpdateType {
  dragging,
  doneDragging,
  animating,
  doneAnimating,
}

class SlideUpdate {
  final UpdateType updateType;
  final SlideDirection direction;
  final double slidePercent;

  SlideUpdate(this.direction, this.slidePercent, this.updateType);
}
