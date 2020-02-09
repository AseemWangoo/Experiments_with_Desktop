import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Sprite extends StatefulWidget {
  final ImageProvider image;
  final int frameWidth;

  final int frameHeight;
  final num frame;

  Sprite({
    Key key,
    @required this.image,
    @required this.frameWidth,
    this.frameHeight,
    this.frame = 0,
  }) : super(key: key);

  @override
  _SpriteState createState() => _SpriteState();
}

class _SpriteState extends State<Sprite> {
  ImageStream _imageStream;
  ImageInfo _imageInfo;

  /// Subclasses rarely override this method because the framework always calls [build]
  /// after a dependency changes. Some subclasses do override this method because
  /// they need to do some expensive work (e.g., network fetches) when their dependencies change,
  /// and that work would be too expensive to do for every build.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getImage();
  }

  @override
  void didUpdateWidget(Sprite oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.image != oldWidget.image) {
      _getImage();
    }
  }

  void _getImage() {
    final ImageStream oldImageStream = _imageStream;
    var config = createLocalImageConfiguration(context);

    _imageStream = widget.image.resolve(config);
    if (_imageStream.key == oldImageStream?.key) {
      return;
    }

    final ImageStreamListener listener = ImageStreamListener(_updateImage);
    oldImageStream?.removeListener(listener);
    _imageStream.addListener(listener);
  }

  void _updateImage(ImageInfo imageInfo, bool synchronousCall) {
    setState(() => _imageInfo = imageInfo);
  }

  @override
  Widget build(BuildContext context) {
    ui.Image img = _imageInfo?.image;

    if (img == null) {
      return SizedBox();
    }

    int imgWidth = img.width;
    int frame = widget.frame.round();
    int frameW = widget.frameWidth, frameH = widget.frameHeight;

    int cols = (imgWidth / frameW).floor();
    int col = frame % cols, row = (frame / cols).floor();

    // print(
    //     '>>>>$imgWidth >>> $frame >>> $frameW >>>> $frameH >>>> $cols >>> $col >>>> $row');

    /// frameW and frameH multiplied by 1.0 as it expects double...
    /// first two params ensure the rectangle is drawn one after another...
    ui.Rect rect = ui.Rect.fromLTWH(
      col * frameW * 1.0, // 0 to 9 * 360,
      row * frameH * 1.0, // 0 to 3 * 720,
      frameW * 1.0,
      frameH * 1.0,
    );

    return CustomPaint(painter: _SpritePainter(img, rect));
  }

  @override
  void dispose() {
    _imageStream?.removeListener(ImageStreamListener(_updateImage));
    super.dispose();
  }
}

class _SpritePainter extends CustomPainter {
  ui.Image image;
  ui.Rect rect;

  _SpritePainter(this.image, this.rect);

  @override
  void paint(Canvas canvas, Size size) {
    /// Draws the subset of the given image described by the src
    /// argument into the canvas in the axis-aligned rectangle given by the dst argument.
    canvas.drawImageRect(
      image,
      rect,
      ui.Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(_SpritePainter oldPainter) {
    return oldPainter.image != image || oldPainter.rect != rect;
    // return true; // Works with this also, but above perf optimization,....
  }
}
