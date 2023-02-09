enum HiStatusBarStyle { light, dark }

enum HiRequestMode { none, load, pullRefresh, loadingMore, update, reload }

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
