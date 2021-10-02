<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Animated Page Reveal
**Animated Page Reveal** package lets you add an animated page reaveal to your Flutter app that dispaly a set of pages with your desired content.


## Features
The AnimatedPageReveal widget is built to be a tool you can use to showcase a content in your Flutter app (ex: onBoarding screen). By default the position of content is set to `Center` and by using the `ViewPageModel`, you can add as many pages as you like with your desired content. 

* *Animated Pages*

By making a drag on the screen (leftToRight or rightToLeft) one page fades out and another comes in with a cool animation. The bottom icons indicate the position of the active page as well as both the seen & unseen pages remaining for the user to interact with.

*The package will handle the animation by itself.*

![animatedPageReveal](https://user-images.githubusercontent.com/68671238/135723534-5301fe7e-e2f7-4896-a94d-c31b84c2b8b0.png)
 
<hr>

## Getting started

1. Add the latest version of package to your `pubspec.yaml` (and run `dart pub get`):
```dart
dependencies:
  animated_page_reveal: ^1.0.0
```
2. Import the package and use it in your Flutter App.
```dart
import 'package:animated_page_reveal/animated_page_reveal.dart';
```
<hr>

## Usage

There are a number of properties that you can modify:

* title (Title text of the page)
* description (Body text of the page)
* color (Color of the page)
* imageAssetPath (Image of the page)
* iconAssetPath (Page bottom icon indicator)
* titleStyle (Title text Style)
* descriptionStyle (Body text style)

**Example Usage (Complete with all params):**
<table>
 <tr>
 <td>
      
```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AnimatedPageReveal(children: [
        PageViewModel(
          title: 'Choose your place',
          description:
              'Pick the right destination according to the season because it is a key factor for a successful trip',
          color: const Color(0xff195932),
          imageAssetPath: 'assets/images/trip.png',
          iconAssetPath: 'assets/images/placeicon.png',
          titleStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          descriptionStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        PageViewModel(
          title: 'Book your flight',
          description:
              'Found a flight that matches your destination and schedule? \nBook it just a few taps',
          color: const Color(0xff19594E),
          imageAssetPath: 'assets/images/flight.png',
          iconAssetPath: 'assets/images/planicon.png',
          titleStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          descriptionStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        PageViewModel(
          title: 'Explore the world',
          description:
              'Easily discover new places and share them with your friends. \nMaybe you will plan together your next trip?',
          color: const Color(0xff193A59),
          imageAssetPath: 'assets/images/explore.png',
          iconAssetPath: 'assets/images/searchicon.png',
          titleStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          descriptionStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
```
   </td>
   <td>
     Here's what it looks like:
     
<hr>


https://user-images.githubusercontent.com/68671238/135723631-75829e02-65df-421c-8b1b-23c69aadfa15.mp4


   </td>
  </tr>
  </table>
<hr>

## Next Goals
We are working on some improvements including:

- [ ] Change color of the bottom circle icon indicator.
- [ ] Add a button to exit to another screen.

## Issues & Feedback
Please file an [issue!](https://github.com/aliMissaoui/Flutter-Package-Animated-Page-Reveal/issues) to send feedback or report a bug. Thank you!

