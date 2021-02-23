import 'package:flutter/material.dart';
import 'package:my_flutter_components/components/input/index.dart';
import 'package:my_flutter_components/components/select/select-item.dart';

class QlSelect extends StatefulWidget {
  final List<QlSelectItem> children;

  QlSelect({
    this.children,
  });

  @override
  _QlSelectState createState() => _QlSelectState();
}

class _QlSelectState extends State<QlSelect> {
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _globalKey,
      child: QlInput(
        hintText: '请选择',
        showCursor: false,
        readOnly: true,
        onTap: () {
          RenderBox renderBox = _globalKey.currentContext.findRenderObject();
          Rect box = renderBox.localToGlobal(Offset.zero) & renderBox.size;
          print(box);
          Navigator.push(context, _DropDownMenuRoute(position: box, menuHeight: 300));
        },
      ),
    );
  }
}

class _DropDownMenuRouteLayout extends SingleChildLayoutDelegate {

  final Rect position;
  final double menuHeight;

  _DropDownMenuRouteLayout({this.position, this.menuHeight});

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // TODO: implement getConstraintsForChild
    return BoxConstraints.loose(Size(position.right - position.left, 300));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // TODO: implement getPositionForChild
    return Offset(position.left, position.bottom);
  }

  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    return true;
  }

}

class _DropDownMenuRoute extends PopupRoute {

  final Rect position;
  final double menuHeight;

  _DropDownMenuRoute({this.position, this.menuHeight});

  @override
  // TODO: implement barrierColor
  Color get barrierColor => null;

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => true;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return CustomSingleChildLayout(
      delegate: _DropDownMenuRouteLayout(position: position, menuHeight: menuHeight),
      child: SizeTransition(
        sizeFactor: Tween<double>(
            begin: 0.0,
            end: 1.0
        ).animate(animation),
        child: Popup()
      ),
    );
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(milliseconds: 300);

}

class Popup extends StatefulWidget {
  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Text('wdw'),
    );
  }
}
