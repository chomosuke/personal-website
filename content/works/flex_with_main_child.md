# flex_with_main_child
2022

[Source Code](https://github.com/chomosuke/chomosuke.com)

## Summary
A Flutter Flex (i.e. Column or Row) that sizes itself to its main child in the cross axis direction.

## Description
- As I am making [catballchard](./catballchard.md) using [Flutter](../skills/flutter.md), I came across a scenario where I wanted to display an image with some descriptions below. I wanted the image widget to follow its own size and I wanted to make sure the description widget have the same width as the image widget.
- After some searches online, I came across several people in various online forms wanting to achieve similar things. However, it doesn't seem like an easy solution exist.
- To solve the problem for me and others, I decided to create a [Dart](../skills/dart.md) package.
- The package would contain a widget called `FlexWithMainChild` that would lay out all its children in either a row or a column. The widget will then make sure its own size is the same as the main child.
- By passing the children of the `FlexWithMainChild` to Flutter's built in `Flex` widget, I was able to achieve the desired functionality with relative ease while also maintaining many functionalities of the built-in `Flex` widget so that anyone using the built-in widget can have an easier time transitioning to my widget.
- While my package only got 6 likes on [pub.dev](https://pub.dev/packages/flex_with_main_child), it did ended up helping me and 2 other people online achieving our desired outcome.
