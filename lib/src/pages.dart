import 'package:animated_page_reveal/src/page_view_model.dart';
import 'package:flutter/material.dart';

// Page content logic
class PageContent extends StatelessWidget {
  const PageContent(
      {Key? key, required this.viewModel, this.percentVisible = 1.0})
      : super(key: key);

  final PageViewModel viewModel;
  final double percentVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Give the page as much width as possible
      width: double.infinity,
      // Set the page color
      color: viewModel.color,
      // Wrap the content with opacity widget to control its visibility
      child: Opacity(
        opacity: percentVisible,
        child: Column(
          // Make the conetnt in center
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Transform widget for page image
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 50.0 * (1 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Image.asset(
                  viewModel.imageAssetPath,
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ),
            // Transform widget for page title
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Text(
                  viewModel.title,
                  style: viewModel.titleStyle,
                ),
              ),
            ),
            // Transform widget for page description
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 75.0, right: 20.0, left: 20.0),
                child: Text(
                  viewModel.description,
                  style: viewModel.descriptionStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
