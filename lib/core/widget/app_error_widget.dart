import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final bool isHorizontal;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Icon(
        Icons.error,
        size: 48.sp,
        color: Colors.redAccent,
      ),
      SizedBox(height: isHorizontal ? 0 : 12.h, width: isHorizontal ? 12.w : 0),
      Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
      if (onRetry != null) ...[
        SizedBox(height: isHorizontal ? 0 : 16.h, width: isHorizontal ? 16.w : 0),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ],
    ];

    return Center(
      child: isHorizontal
          ? Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
