import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WidgetMask extends Stack {
  // The parameters are the ones which stack requires...
  WidgetMask({
    Key key,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection textDirection,
    StackFit fit = StackFit.loose,
    Clip overflow = Clip.hardEdge,
    @required Widget maskChild,
    @required Widget child,
  }) : super(
          key: key,
          alignment: alignment,
          textDirection: textDirection,
          fit: fit,
          clipBehavior: overflow,
          children: [maskChild, child],
        );

  /// This method should not do anything with the children of the
  /// render object. That should instead be handled by the
  /// method that overrides [RenderObjectElement.mount]
  /// in the object rendered by this object's [createElement] method.
  /// See, for example, [SingleChildRenderObjectElement.mount].
  @override
  RenderStack createRenderObject(BuildContext context) {
    return RenderWidgetMask(
        alignment: alignment,
        textDirection: textDirection ?? Directionality.of(context),
        fit: fit,
        overflow: clipBehavior);
  }

  // USING `RenderWidgetMask` instead of RenderStack
  @override
  void updateRenderObject(BuildContext context, RenderWidgetMask renderObject) {
    renderObject
      ..alignment = alignment
      ..textDirection = textDirection ?? Directionality.of(context)
      ..fit = fit
      ..clipBehavior = clipBehavior;
  }
}

class RenderWidgetMask extends RenderStack {
  RenderWidgetMask({
    List<RenderBox> children,
    AlignmentGeometry alignment,
    TextDirection textDirection,
    StackFit fit,
    Clip overflow,
  }) : super(
          children: children,
          alignment: alignment,
          textDirection: textDirection,
          fit: fit,
          clipBehavior: overflow,
        );

  // USES defaultPaint(context, offset);
  // Paints each child by walking the child list forwards.
  // But we override...

  @override
  void paintStack(PaintingContext context, Offset offset) {
    if (firstChild == null) return;

    // Skip painting the maskChild
    // ignore: prefer_function_declarations_over_variables
    final paintContent = (PaintingContext context, Offset offset) {
      RenderBox child = (firstChild.parentData as StackParentData).nextSibling;

      while (child != null) {
        final childParentData = child.parentData as StackParentData;

        // Here, we used lastChild, instead of child....
        context.paintChild(lastChild, offset + childParentData.offset);
        child = childParentData.nextSibling;
      }
    };

    // Here, we paint the masked child.....
    // ignore: prefer_function_declarations_over_variables
    final paintMaskedChild = (PaintingContext context, Offset offset) {
      context.paintChild(
        firstChild,
        offset + (firstChild.parentData as StackParentData).offset,
      );
    };

    /// Rect myRect = Offset.zero & const Size(100.0, 100.0);
    /// same as: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0)
    // ignore: prefer_function_declarations_over_variables
    final paintAll = (PaintingContext context, Offset offset) {
      paintContent(context, offset);
      context.canvas.saveLayer(
        offset & size,
        Paint()..blendMode = BlendMode.dstIn,
      );
      paintMaskedChild(context, offset);
      context.canvas.restore();
    };

    /// The offset argument indicates an offset to apply to all the children
    /// (the rendering created by painter).
    /// The alpha argument is the alpha value to use when blending the painting
    /// done by painter. An alpha value of 0 means the painting is fully transparent
    /// and an alpha value of 255 means the painting is fully opaque.
    context.pushOpacity(offset, 255, paintAll);
  }
}

/*

  ACTUAL RENDER STACK
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection textDirection,
    StackFit fit = StackFit.loose,
    Overflow overflow = Overflow.clip,

 */
