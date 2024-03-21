import 'package:flutter/material.dart';
import 'package:jrx_flutter/src/data/bindable.dart';
import 'package:jrx_flutter/src/mixins/bindable_mixin.dart';
import 'package:jrx_flutter/src/mixins/widget_mixin.dart';

class BindableBuilder<T> extends StatefulWidget {
  final Bindable<T> bindable;
  final Widget Function(BuildContext context, T value) builder;

  const BindableBuilder({
    super.key,
    required this.bindable,
    required this.builder,
  });

  @override
  State<StatefulWidget> createState() => _BindableBuilderState<T>();
}

class _BindableBuilderState<T> extends State<BindableBuilder<T>> with BindableMixin, WidgetMixin {
  late Bindable<T> bindable;

  @override
  void initState() {
    super.initState();

    bindable = widget.bindable;
    linkBindable(widget.bindable, false);
  }

  @override
  void didUpdateWidget(covariant BindableBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.bindable != bindable) {
      linkBindable(widget.bindable, true);
    }
  }

  @override
  void dispose() {
    unuseAllBindables();

    super.dispose();
  }

  void linkBindable(Bindable<T> other, bool setToState) {
    unuseAllBindables();
    runAfterFrame(() {
      if (mounted) {
        setState(() {
          if (setToState) {
            bindable = other;
          }
        });
        useBindable(other, (_) {
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.bindable.value);
  }
}
