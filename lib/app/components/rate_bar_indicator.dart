import 'package:flutter/material.dart';

class RatingBarIndicator extends StatefulWidget {
  const RatingBarIndicator({
    Key? key,
    required this.itemBuilder,
    required this.unratedWidget,
    this.itemCount = 5,
    this.itemSize = 40.0,
    this.rating = 0.0,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;

  final Widget unratedWidget;

  final int itemCount;

  final double itemSize;

  final double rating;

  @override
  _RatingBarIndicatorState createState() => _RatingBarIndicatorState();
}

class _RatingBarIndicatorState extends State<RatingBarIndicator> {
  double _ratingFraction = 0.0;
  int _ratingNumber = 0;
  final bool _isRTL = false;

  @override
  void initState() {
    super.initState();
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _children,
    );
  }

  List<Widget> get _children {
    return List.generate(
      widget.itemCount,
      (index) {
        return _buildItems(index);
      },
    );
  }

  Widget _buildItems(int index) {
    return SizedBox(
      width: widget.itemSize,
      height: widget.itemSize,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: index + 1 < _ratingNumber
                ? widget.itemBuilder(context, index)
                : widget.unratedWidget,
          ),
          if (index + 1 == _ratingNumber)
            if (_isRTL)
              FittedBox(
                fit: BoxFit.contain,
                child: ClipRect(
                  clipper: _IndicatorClipper(
                    ratingFraction: _ratingFraction,
                    rtlMode: _isRTL,
                  ),
                  child: widget.itemBuilder(context, index),
                ),
              )
            else
              FittedBox(
                fit: BoxFit.contain,
                child: ClipRect(
                  clipper: _IndicatorClipper(
                    ratingFraction: _ratingFraction,
                  ),
                  child: widget.itemBuilder(context, index),
                ),
              ),
        ],
      ),
    );
  }
}

class _IndicatorClipper extends CustomClipper<Rect> {
  _IndicatorClipper({
    required this.ratingFraction,
    this.rtlMode = false,
  });

  final double ratingFraction;
  final bool rtlMode;

  @override
  Rect getClip(Size size) {
    return rtlMode
        ? Rect.fromLTRB(
            size.width - size.width * ratingFraction,
            0.0,
            size.width,
            size.height,
          )
        : Rect.fromLTRB(
            0.0,
            0.0,
            size.width * ratingFraction,
            size.height,
          );
  }

  @override
  bool shouldReclip(_IndicatorClipper oldClipper) {
    return ratingFraction != oldClipper.ratingFraction ||
        rtlMode != oldClipper.rtlMode;
  }
}
