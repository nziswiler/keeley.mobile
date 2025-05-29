import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/common/widgets/app_bar.dart';
import 'package:keeley/src/common/widgets/shad_floating_action_button.dart';
import 'package:keeley/src/constants/keys.dart';
import 'package:keeley/src/constants/strings.dart';
import 'package:keeley/src/features/bookings/presentation/controllers/bookings_controller.dart';
import 'package:keeley/src/features/bookings/presentation/screens/bookings_screen/widgets/bookings_list_view.dart';
import 'package:keeley/src/features/bookings/presentation/screens/edit_booking_screen/edit_booking_screen.dart';
import 'package:keeley/src/utils/async_value_ui.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(Keys.bookingsScreen),
      extendBodyBehindAppBar: true,
      appBar: ScrollableAppBar(
        title: Strings.bookings,
        scrollController: _scrollController,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<AsyncValue>(
            bookingsControllerProvider,
            (_, state) => state.showExceptionToastOnError(context),
          );

          return BookingsListView(scrollController: _scrollController);
        },
      ),
      floatingActionButton: ShadFloatingActionButton.add(
        key: const Key(Keys.floatingActionButton),
        onPressed: _showCreateBookingModal,
        tooltip: Strings.newBooking,
      ),
    );
  }

  void _showCreateBookingModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => const EditBookingScreen(),
    );
  }
}
