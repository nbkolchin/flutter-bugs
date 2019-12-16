# bug_textfield_1372

Demonstration for flutter bug flutter/flutter#47089 .

## Steps to reproduce

1. Press `Show TextField`.
2. Press `Hide TextField`.
3. Press `Show TextField`.
4. Exception will appear.

It looks like text `selection` become `null` at some point.

## Possible Quick fix

In "real world application", adding following listener to `TextInputController`
hides exception: 

```dart
widget.filterController.addListener(() {
  final text = widget.filterController.text;
  if(widget.filterController.value.selection == null) {
    widget.filterController.value = widget.filterController.value.copyWith(
        // text: text,
        selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        // composing: TextRange.empty,
    );
  }
});
```

But this trick doesn't help in provided sample...

## Flutter environment

```
bash-3.2$ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, v1.12.13+hotfix.5, on Mac OS X 10.14.6 18G1012, locale en-RU)

[✓] Android toolchain - develop for Android devices (Android SDK version 29.0.2)
[✓] Xcode - develop for iOS and macOS (Xcode 11.3)
[✓] Android Studio (version 3.5)
[✓] VS Code (version 1.40.2)
[✓] Connected device (1 available)

• No issues found!
```

## Exception dump

```
I/flutter ( 9216): ══╡ EXCEPTION CAUGHT BY RENDERING LIBRARY ╞═════════════════════════════════════════════════════════
I/flutter ( 9216): The following assertion was thrown during paint():
I/flutter ( 9216): 'dart:ui/text.dart': Failed assertion: line 1372: '<optimized out>': is not true.
I/flutter ( 9216):
I/flutter ( 9216): Either the assertion indicates an error in the framework itself, or we should provide substantially
I/flutter ( 9216): more information in this error message to help you determine and fix the underlying cause.
I/flutter ( 9216): In either case, please report this assertion by filing a bug on GitHub:
I/flutter ( 9216):   https://github.com/flutter/flutter/issues/new?template=BUG.md
I/flutter ( 9216):
I/flutter ( 9216): The relevant error-causing widget was:
I/flutter ( 9216):   TextField
I/flutter ( 9216):   file:///Users/snob/work/experiments/dart/bug-reports/bug_textfield_1372/lib/main.dart:60:30
I/flutter ( 9216):
I/flutter ( 9216): When the exception was thrown, this was the stack:
I/flutter ( 9216): #2      new TextPosition (dart:ui/text.dart:1372:15)
I/flutter ( 9216): #3      RenderEditable._updateSelectionExtentsVisibility (package:flutter/src/rendering/editable.dart:367:7)
I/flutter ( 9216): #4      RenderEditable._paintContents (package:flutter/src/rendering/editable.dart:1956:7)
I/flutter ( 9216): #5      RenderEditable.paint (package:flutter/src/rendering/editable.dart:2012:7)
I/flutter ( 9216): #6      RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #7      PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #8      RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #9      RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #10     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #11     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #12     PaintingContext.pushLayer (package:flutter/src/rendering/object.dart:384:12)
I/flutter ( 9216): #13     RenderLeaderLayer.paint (package:flutter/src/rendering/proxy_box.dart:4796:13)
I/flutter ( 9216): #14     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #15     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #16     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #17     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #18     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #19     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #20     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #21     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #22     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #23     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #24     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #25     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #26     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #27     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #28     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #29     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #30     PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:135:11)
I/flutter ( 9216): #31     PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:95:5)
I/flutter ( 9216): #32     PaintingContext._compositeChild (package:flutter/src/rendering/object.dart:201:7)
I/flutter ( 9216): #33     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:182:7)
I/flutter ( 9216): #34     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #35     RenderCustomPaint.paint (package:flutter/src/rendering/custom_paint.dart:575:11)
I/flutter ( 9216): #36     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #37     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #38     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #39     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #40     PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:135:11)
I/flutter ( 9216): #41     PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:95:5)
I/flutter ( 9216): #42     PaintingContext._compositeChild (package:flutter/src/rendering/object.dart:201:7)
I/flutter ( 9216): #43     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:182:7)
I/flutter ( 9216): #44     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #45     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #46     PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:135:11)
I/flutter ( 9216): #47     PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:95:5)
I/flutter ( 9216): #48     PaintingContext._compositeChild (package:flutter/src/rendering/object.dart:201:7)
I/flutter ( 9216): #49     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:182:7)
I/flutter ( 9216): #50     _RenderDecoration.paint.doPaint (package:flutter/src/material/input_decorator.dart:1404:17)
I/flutter ( 9216): #51     _RenderDecoration.paint (package:flutter/src/material/input_decorator.dart:1439:12)
I/flutter ( 9216): #52     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #53     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #54     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #55     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #56     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #57     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #58     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #59     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #60     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #61     RenderMouseRegion.paint (package:flutter/src/rendering/proxy_box.dart:2787:13)
I/flutter ( 9216): #62     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #63     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #64     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #65     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #66     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #67     RenderBoxContainerDefaultsMixin.defaultPaint (package:flutter/src/rendering/box.dart:2508:15)
I/flutter ( 9216): #68     RenderFlex.paint (package:flutter/src/rendering/flex.dart:948:7)
I/flutter ( 9216): #69     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #70     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #71     RenderShiftedBox.paint (package:flutter/src/rendering/shifted_box.dart:70:15)
I/flutter ( 9216): #72     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #73     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #74     RenderBoxContainerDefaultsMixin.defaultPaint (package:flutter/src/rendering/box.dart:2508:15)
I/flutter ( 9216): #75     RenderCustomMultiChildLayoutBox.paint (package:flutter/src/rendering/custom_layout.dart:396:5)
I/flutter ( 9216): #76     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #77     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #78     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #79     _RenderInkFeatures.paint (package:flutter/src/material/material.dart:530:11)
I/flutter ( 9216): #80     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #81     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #82     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #83     PaintingContext.pushLayer (package:flutter/src/rendering/object.dart:384:12)
I/flutter ( 9216): #84     RenderPhysicalModel.paint (package:flutter/src/rendering/proxy_box.dart:1755:15)
I/flutter ( 9216): #85     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #86     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #87     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #88     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #89     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:184:13)
I/flutter ( 9216): #90     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:123:15)
I/flutter ( 9216): #91     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:2219:7)
I/flutter ( 9216): #92     PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:135:11)
I/flutter ( 9216): #93     PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:95:5)
I/flutter ( 9216): #94     PipelineOwner.flushPaint (package:flutter/src/rendering/object.dart:937:29)
I/flutter ( 9216): #95     RendererBinding.drawFrame (package:flutter/src/rendering/binding.dart:346:19)
I/flutter ( 9216): #96     WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:774:13)
I/flutter ( 9216): #97     RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:283:5)
I/flutter ( 9216): #98     SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1102:15)
I/flutter ( 9216): #99     SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1041:9)
I/flutter ( 9216): #100    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:957:5)
I/flutter ( 9216): #104    _invoke (dart:ui/hooks.dart:259:10)
I/flutter ( 9216): #105    _drawFrame (dart:ui/hooks.dart:217:3)
I/flutter ( 9216): (elided 5 frames from class _AssertionError and package dart:async)
I/flutter ( 9216):
I/flutter ( 9216): The following RenderObject was being processed when the exception was fired: RenderEditable#c26df relayoutBoundary=up18:
I/flutter ( 9216):   creator: _Editable-[GlobalKey#ec266] ← Semantics ← CompositedTransformTarget ←
I/flutter ( 9216):     IgnorePointer-[GlobalKey#1f9d4] ← Semantics ← _PointerListener ← Listener ←
I/flutter ( 9216):     RawGestureDetector-[LabeledGlobalKey<RawGestureDetectorState>#ffd05] ← _PointerListener ← Listener
I/flutter ( 9216):     ← _ScrollableScope ← RepaintBoundary ← ⋯
I/flutter ( 9216):   parentData: <none> (can use size)
I/flutter ( 9216):   constraints: BoxConstraints(w=312.0, 0.0<=h<=Infinity)
I/flutter ( 9216):   size: Size(312.0, 19.0)
I/flutter ( 9216):   cursorColor: Color(0x004285f4)
I/flutter ( 9216):   showCursor: ValueNotifier<bool>#4a016(true)
I/flutter ( 9216):   maxLines: 1
I/flutter ( 9216):   minLines: null
I/flutter ( 9216):   selectionColor: Color(0xff90caf9)
I/flutter ( 9216):   textScaleFactor: 1.0
I/flutter ( 9216):   locale: en_US
I/flutter ( 9216):   selection: TextSelection(baseOffset: 0, extentOffset: 0, affinity: null, isDirectional: false)
I/flutter ( 9216):   offset: ScrollPositionWithSingleContext#9a9e9(offset: 0.0, range: 0.0..0.0, viewport: 312.0,
I/flutter ( 9216):     ScrollableState, ClampingScrollPhysics, IdleScrollActivity#fc6a8, ScrollDirection.idle)
I/flutter ( 9216): This RenderObject had the following child:
I/flutter ( 9216):     text: TextSpan
I/flutter ( 9216): ════════════════════════════════════════════════════════════════════════════════════════════════════
```
