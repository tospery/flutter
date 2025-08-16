class HiNetwork {
  // final List<String> codeKeys;
  // final List<String> messageKeys;
  // final List<String> dataKeys;
  final String codeKeys;
  final String messageKeys;
  final String dataKeys;

  static HiNetwork? _instance;
  static HiNetwork shared() {
    _instance ??= HiNetwork._();
    return _instance!;
  }

  HiNetwork._({
    String? codeKeys,
    String? messageKeys,
    String? dataKeys,
  })  : this.codeKeys = codeKeys ?? 'code',
        this.messageKeys = messageKeys ?? 'message',
        this.dataKeys = dataKeys ?? 'data';

  static Future<bool> ready({
    String? codeKeys,
    String? messageKeys,
    String? dataKeys,
  }) async {
    _instance ??= HiNetwork._(
      codeKeys: codeKeys,
      messageKeys: messageKeys,
      dataKeys: dataKeys,
    );
    return true;
  }
}
