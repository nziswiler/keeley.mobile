import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/bookings_controller.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/bookings_list_view.dart';
import 'package:keeley/src/utils/async_value_ui.dart';

class BookingsContent extends ConsumerWidget {
  const BookingsContent({
    super.key,
    required this.scrollController,
    required this.padding,
  });

  final ScrollController scrollController;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      bookingsControllerProvider,
      (_, state) => state.showExceptionToastOnError(context),
    );

    return BookingsListView(
      scrollController: scrollController,
      padding: padding,
    );
  }
}
