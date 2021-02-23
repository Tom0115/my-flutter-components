import 'package:flutter/material.dart';

class QlInput extends StatefulWidget {
  final Function onChanged; // input的文字
  final String hintText; // 提示字
  final TextStyle textStyle; // 文字样式
  final bool autoFocus; // 自动获取焦点
  final bool disabled; // 是否禁用
  final FocusNode focusNode; // 监听焦点
  final Color cursorColor; // 光标颜色
  final Color enabledBorder; // 未选中的边框颜色
  final Color focusedBorder; // 选中的边框颜色
  final TextEditingController controller; // 文本内容
  final String keyboardType; // 键盘类型
  final String size; // input尺寸
  final Widget leftIcon; // 左边icon
  final Widget rightIcon; // 右边icon
  final String type; // 输入框的类型
  final int maxLength; // 输入长度限制
  final Function onTap; // 点击输入框
  final bool showCursor; // 是否显示光标
  final bool readOnly; // 弹出键盘

  QlInput({
    this.onChanged,
    this.hintText,
    this.textStyle,
    this.autoFocus = false,
    this.disabled = false,
    this.focusNode,
    this.cursorColor,
    this.enabledBorder,
    this.focusedBorder,
    this.controller,
    this.keyboardType = 'text',
    this.size = 'medium',
    this.leftIcon,
    this.rightIcon,
    this.type = 'default',
    this.maxLength,
    this.onTap,
    this.showCursor = true,
    this.readOnly = false,
  });

  @override
  _QlInputState createState() => _QlInputState();
}

class _QlInputState extends State<QlInput> {
  // 默认input border
  final _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  // 密码和明文
  bool isObscure = true;

  // 当前字符长度
  int currentInputLength = 0;

  // 设置键盘类型
  TextInputType _setKeyboardType(keyboardType) {
    switch (keyboardType) {
      case 'multiline':
        return TextInputType.multiline;
        break;
      case 'number':
        return TextInputType.number;
        break;
      case 'phone':
        return TextInputType.phone;
        break;
      case 'datetime':
        return TextInputType.datetime;
        break;
      case 'emailAddress':
        return TextInputType.emailAddress;
        break;
      case 'url':
        return TextInputType.url;
        break;
      default:
        return TextInputType.text;
    }
  }

  // 设置多行
  int _setLines(keyboardType) {
    if (keyboardType == 'multiline') {
      return 5;
    } else {
      return 1;
    }
  }

  // 设置大小
  double _setSize(size) {
    const double big = 38;
    const double medium = 32;
    const double small = 26;
    const double mini = 22;

    switch (size) {
      case 'big':
        return big;
        break;
      case 'medium':
        return medium;
        break;
      case 'small':
        return small;
        break;
      case 'mini':
        return mini;
        break;
      default:
        return medium;
    }
  }

  // input padding 设置
  EdgeInsets _setInputPadding(leftIcon, rightIcon, maxLength) {
    if (maxLength != null) {
      return EdgeInsets.only(left: 10, right: 45);
    } else if (leftIcon == null && rightIcon == null) {
      return EdgeInsets.only(left: 10, right: 10);
    } else if (leftIcon != null && rightIcon == null) {
      return EdgeInsets.only(left: 35, right: 10);
    } else if (leftIcon == null && rightIcon != null) {
      return EdgeInsets.only(left: 10, right: 35);
    } else {
      return EdgeInsets.only(left: 35, right: 35);
    }
  }

  // 控制明文和暗文
  void _onObscureText() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  // 输入长度监听器
  void _inputLengthListener(value) {
    setState(() {
      currentInputLength = value.length;
    });
  }

  // 渲染input类型
  Widget _renderInputType(type) {
    switch (type) {
      case 'password':
        return _passwordInput();
        break;
      default:
        return _defaultInput();
    }
  }

  // 公共输入框(原子) isObscure 参数是为了 更好的管理明暗文状态
  Widget _input(bool isObscure) {
    return TextField(
      onChanged: (value) {
        if (widget.maxLength != null) {
          _inputLengthListener(value);
        }
        widget.onChanged(value);
      },
        showCursor: widget.showCursor,
      readOnly: widget.readOnly,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap();
        }
      },
      obscureText: isObscure,
      enabled: !widget.disabled,
      autofocus: widget.autoFocus,
      focusNode: widget.focusNode,
      style: widget.textStyle != null ? widget.textStyle : TextStyle(),
      keyboardType: _setKeyboardType(widget.keyboardType),
      maxLines: _setLines(widget.keyboardType),
      minLines: 1,
      controller: widget.controller,
      cursorWidth: 1,
      cursorColor: widget.cursorColor ?? Colors.black,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        // 隐藏输入最大值下标
        counterText: "",
        hintText: widget.hintText,
        contentPadding: widget.hintText == null ? EdgeInsets.symmetric(vertical: 7.5,) : EdgeInsets.zero,
        enabledBorder: _inputBorder,
        disabledBorder: _inputBorder,
        focusedBorder: OutlineInputBorder(
          //选中时外边框颜色
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  // 可配置输入框
  Widget _defaultInput() {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          padding: _setInputPadding(
              widget.leftIcon, widget.rightIcon, widget.maxLength),
          child: _input(false),
        ),

        // 前置元素
        Positioned(
          left: 5,
          child: SizedBox(
            child: widget.leftIcon,
          ),
        ),

        //后置元素
        Positioned(
          right: 5,
          child: SizedBox(
            child: widget.rightIcon,
          ),
        ),

        //最大输入值
        Positioned(
          right: 5,
          child: SizedBox(
            child: widget.maxLength != null ? Text('$currentInputLength/${widget.maxLength}') : null,
          ),
        ),
      ],
    );
  }

  // 密码框
  Widget _passwordInput() {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 35),
          child: _input(isObscure),
        ),
        Positioned(
          right: 5,
          child: GestureDetector(
            onTap: () => _onObscureText(),
            child: isObscure
                ? Icon(Icons.remove_red_eye)
                : Icon(Icons.remove_red_eye_outlined),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
            widget.onTap();
        }
      },
      child: Container(
        height: _setSize(widget.size),
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 249, 252, 1),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Color.fromRGBO(228, 233, 242, 1), width: 1),
        ),
        child: _renderInputType(widget.type),
      ),
    );
  }
}
