import 'package:flutter/material.dart';

class QlSelectItem extends StatelessWidget {
  // 选项的值
  final value;

  // 选项的标签
  final label;

  // 是否禁用该选项
  final disabled;

  QlSelectItem({
    this.value,
    this.label,
    this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(label),
    );
  }
}
