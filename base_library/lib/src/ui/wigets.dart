import 'package:base_library/src/res/index.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key key,
    this.width,
    this.height = 50,
    this.margin,
    this.radius,
    this.bgColor,
    this.highlightColor,
    this.splashColor,
    this.child,
    this.text,
    this.style,
    this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry margin;

  final double radius;
  final Color bgColor;
  final Color highlightColor;
  final Color splashColor;

  final Widget child;

  final String text;
  final TextStyle style;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Color _bgColor = bgColor ?? Theme.of(context).primaryColor;
    BorderRadius _borderRadius = BorderRadius.circular(radius ?? (height / 2));
    return new Container(
      width: width,
      height: height,
      margin: margin,
      child: new Material(
        borderRadius: _borderRadius,
        color: _bgColor,
        child: new InkWell(
          borderRadius: _borderRadius,
          onTap: () => onPressed(),
          child: child ??
              new Center(
                child: new Text(
                  text,
                  style:
                      style ?? new TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
        ),
      ),
    );
  }
}

class LoginItem extends StatefulWidget {
  const LoginItem({
    Key key,
    this.prefixIcon,
    this.hasSuffixIcon = false,
    this.hintText,
    this.controller,
  }) : super(key: key);

  final IconData prefixIcon;
  final bool hasSuffixIcon;
  final String hintText;
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() {
    return LoginItemState();
  }
}

class LoginItemState extends State<LoginItem> {
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasSuffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new IconButton(
            iconSize: 28,
            icon: new Icon(
              widget.prefixIcon,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {}),
        Gaps.hGap30,
        new Expanded(
          child: new TextField(
              obscureText: _obscureText,
              controller: widget.controller,
              style: new TextStyle(color: Colours.gray_66, fontSize: 14),
              decoration: new InputDecoration(
                hintText: widget.hintText,
                hintStyle: new TextStyle(color: Colours.gray_99, fontSize: 14),
                suffixIcon: widget.hasSuffixIcon
                    ? new IconButton(
                        icon: new Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colours.gray_66,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        })
                    : null,
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colours.green_de)),
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colours.green_de)),
              )),
        ),
      ],
    );
  }
}
