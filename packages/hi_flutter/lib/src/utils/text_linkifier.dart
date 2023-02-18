import 'package:flutter_linkify/flutter_linkify.dart';

class HiTextLinkifier extends Linkifier {
  final String text;

  HiTextLinkifier(this.text);

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];
    elements.forEach((element) {
      if (element is TextElement) {
        var array = element.text.split(text);
        if (array.length == 1) {
          list.add(element);
        } else {
          array.forEach((string) {
            if (string.isNotEmpty) {
              list.add(TextElement(string));
              list.add(LinkableElement(text, text));
            }
          });
        }
      } else {
        list.add(element);
      }
    });
    return list;
  }
}
