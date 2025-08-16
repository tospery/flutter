import 'package:flutter/material.dart';
import 'package:hi_dialog/hi_dialog.dart';

class HiAlertView extends StatelessWidget {
  ///标题
  final String title;

  ///内容
  final String content;

  ///左侧文字
  final String backText;

  ///右侧文字
  final String nextText;

  ///左侧事件
  final VoidCallback? backTap;

  ///右侧事件
  final VoidCallback? nextTap;

  ///左侧是否隐藏
  final bool backVisible;

  ///右侧是否隐藏
  final bool nextVisible;

  const HiAlertView({
    super.key,
    this.title = '',
    this.content = '',
    this.backText = '',
    this.nextText = '',
    this.backVisible = true,
    this.nextVisible = true,
    this.backTap,
    this.nextTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      ///透明样式
      type: MaterialType.transparency,

      ///dialog居中
      child: Center(
        ///取消ListView滑动阴影
        child: ScrollConfiguration(
          behavior: HiOverScrollBehavior(),

          ///ListView 的shrinkWrap属性可适应高度（有多少占多少）
          child: ListView(
            shrinkWrap: true,
            children: [
              ///背景及内容、边距、圆角等，必须包裹在ListView中
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ///标题、内容
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: context.textTheme.titleLarge?.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Text(
                          content,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: context.textTheme.titleMedium?.fontSize,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 0.5,
                        thickness: 0.5,
                        color: Colors.amber,
                      ),

                      ///确定、取消按钮
                      Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        direction: Axis.horizontal,
                        children: [
                          ///对半分
                          _buildTextButton(backTap, backText, backVisible),
                          _buildTextButton(nextTap, nextText, nextVisible)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///此处使用方法重新创建的原因是因为此处不需要频繁更新，不会造成过度创建
  _buildTextButton(VoidCallback? tap, String text, bool show) {
    return Visibility(
      visible: show,
      child: Expanded(
        flex: 1,
        child: TextButton(
          onPressed: () {
            dismissDialog();
            if (tap != null) {
              tap();
            }
          },
          style: ButtonStyle(
            shadowColor: WidgetStateProperty.all(Colors.green),
            animationDuration: const Duration(milliseconds: 200),
            padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
          ),
          child: Container(
            alignment: Alignment.center,
            height: 60,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 14, // R.constants.metric.fontSizeMedium,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
