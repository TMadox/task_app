import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:loading_indicator/loading_indicator.dart';

class NewFutureBuilder<T extends Object> extends StatefulWidget {
  final Widget Function(BuildContext, T) builder;
  final FutureManager<T> futureManager;
  const NewFutureBuilder({
    super.key,
    required this.builder,
    required this.futureManager,
  });

  @override
  State<NewFutureBuilder<T>> createState() => _NewFutureBuilderState<T>();
}

class _NewFutureBuilderState<T extends Object> extends State<NewFutureBuilder<T>> {
  late final FutureManager<T> dataManager;

  @override
  void initState() {
    dataManager = widget.futureManager;
    super.initState();
  }

  @override
  void dispose() {
    dataManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureManagerBuilder<T>(
      futureManager: dataManager,
      ready: widget.builder,
      error: (error) => Text(error.exception.toString()),
      loading: const Center(
        child: SizedBox(
          height: 50,
          child: LoadingIndicator(
            indicatorType: Indicator.ballBeat,
          ),
        ),
      ),
    );
  }
}
