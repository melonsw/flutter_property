import 'package:cloud/widgets/plate/plate_keyboard.dart';
import 'package:cloud/widgets/plate/plate_styles.dart';
import 'package:flutter/material.dart';

/// 键盘控制器
class KeyboardController {
  KeyboardController();

  /// 车牌号码数组
  final List<String> _plateNumbers = ['', '', '', '', '', '', '', ''];

  /// 车牌号
  String _plateNumber = '';

  /// 当前光标位置
  int cursorIndex = 0;

  /// 键盘悬浮窗口
  OverlayEntry _keyboardOverlay;

  /// 键盘进入和退出动画控制器
  AnimationController _controller;

  /// 键盘可见状态
  bool _isKeyboardShowing = false;

  /// 主题
  PlateStyles _styles = PlateStyles.light;
  ValueNotifier<String> _valueNotifier;
  Function(int index, String value) _onPlateNumberChanged;

  /// 打开系统键盘
  Function() _openSystemKeyboard;

  set plateNumber(String plateNumber) {
    _plateNumber = plateNumber;
    List<String> numbers = plateNumber.split('');
    _plateNumbers.fillRange(0, _plateNumbers.length, '');
    _plateNumbers.replaceRange(0, numbers.length, numbers);
    cursorIndex = _plateNumber.length;
    _valueNotifier.value = plateNumber;
  }

  set valueNotifier(ValueNotifier<String> valueNotifier) {
    _valueNotifier = valueNotifier;
  }

  ValueNotifier<String> get valueNotifierData => _valueNotifier;

  String get plateNumber => _plateNumber;

  List<String> get plateNumbers => _plateNumbers;

  set animationController(AnimationController controller) =>
      _controller = controller;

  set styles(PlateStyles styles) => _styles = styles;

  set onPlateNumberChanged(onPlateNumberChanged(int index, String value)) =>
      _onPlateNumberChanged = onPlateNumberChanged;

  set openSystemKeyboard(openSystemKeyboard()) =>
      _openSystemKeyboard = openSystemKeyboard;

  /// 显示键盘
  void showKeyboard(BuildContext context) {
    if (_keyboardOverlay != null) {
      _keyboardOverlay.remove();
    }
    _keyboardOverlay = OverlayEntry(
      builder: (context) {
        return PlateKeyboard(
          plateNumbers: _plateNumbers,
          keyboardController: this,
          styles: _styles,
          newEnergy: true,
          onChange: _onPlateNumberChanged,
          animationController: _controller,
          onComplete: () => hideKeyboard(),
          onChangeSystem: _openSystemKeyboard,
        );
      },
    );
    Overlay.of(context).insert(_keyboardOverlay);
    if (!_isKeyboardShowing) {
      _controller.forward();
      _isKeyboardShowing = true;
    }
  }

  /// 隐藏键盘
  void hideKeyboard() {
    if (isKeyboardShowing()) {
      _controller.reverse();
    }
    _isKeyboardShowing = false;
  }

  /// 键盘是否可见
  bool isKeyboardShowing() {
    return _keyboardOverlay != null && _isKeyboardShowing;
  }

  /// 移除悬浮窗口
  void dispose() {
    if (_keyboardOverlay != null) {
      _keyboardOverlay.remove();
      _keyboardOverlay = null;
    }
  }
}
