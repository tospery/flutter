typedef HiGetUseridFunc = String? Function();
typedef BoolCallback = void Function(bool value);

enum HiRequestMode { none, loading, refresh, more }

enum HiStatusBarStyle { light, dark }

enum HiSimpleStyle {
  tile,
  space,
  button;

  factory HiSimpleStyle.fromValue(int value) =>
      {
        0: HiSimpleStyle.tile,
        1: HiSimpleStyle.space,
        2: HiSimpleStyle.button,
      }[value] ??
      HiSimpleStyle.tile;
}
