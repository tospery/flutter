import 'package:linkify/linkify.dart';

class PlainLinkifier extends Linkifier {
  final String plain;

  PlainLinkifier(this.plain);

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];
    elements.forEach((element) {
      if (element is TextElement) {
        var array = element.text.split(plain);
        if (array.length == 1) {
          list.add(element);
        } else {
          for (var i = 0; i < array.length; i++) {
            var string = array[i];
            if (string.isEmpty) {
              list.add(LinkableElement(plain, plain));
            } else {
              list.add(TextElement(string));
              // YJX_TODO
              // if (i != array.length - 1) {
              //   list.add(PlainElement(plain));
              // }
            }
          }
        }
      } else {
        list.add(element);
      }
    });
    return list;
  }
}

class PlainElement extends LinkableElement {
  final String plain;

  PlainElement(this.plain) : super(plain, 'plain:$plain');

  @override
  String toString() {
    return "PlainElement: '$plain' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  bool equals(other) =>
      other is PlainElement && super.equals(other) && other.plain == plain;
}
