class Keys {
  // ===================================
  // AUTHENTICATION KEYS
  // ===================================
  static const String emailField = 'emailField';
  static const String passwordField = 'passwordField';
  static const String confirmPasswordField = 'confirmPasswordField';
  static const String signInButton = 'signInButton';
  static const String signUpButton = 'signUpButton';
  static const String signOutButton = 'signOutButton';

  // ===================================
  // PROFILE KEYS
  // ===================================
  static const String displayName = 'displayName';
  static const String updateDisplayNameButton = 'updateDisplayNameButton';
  static const String deleteAccountButton = 'deleteAccountButton';

  // ===================================
  // BOOKING KEYS
  // ===================================
  static const String bookingsScreen = 'bookingsScreen';
  static const String bookingsListView = 'bookingsListView';
  static const String bookingCard = 'bookingCard';
  static const String bookingIcon = 'bookingIcon';

  // Booking Actions
  static const String dismissibleBooking = 'dismissibleBooking';
  static const String editBackground = 'editBackground';
  static const String deleteBackground = 'deleteBackground';
  static const String editBackgroundIcon = 'edit_background_icon';
  static const String editBackgroundText = 'edit_background_text';
  static const String deleteBackgroundIcon = 'delete_background_icon';
  static const String deleteBackgroundText = 'delete_background_text';

  // ===================================
  // FORM KEYS
  // ===================================
  static const String headerSection = 'headerSection';
  static const String closeButton = 'closeButton';
  static const String saveBookingButton = 'saveBookingButton';

  // Form Field IDs
  static const String email = 'email';
  static const String password = 'password';
  static const String confirmPassword = 'confirmPassword';
  static const String amountField = 'amountField';
  static const String descriptionField = 'descriptionField';
  static const String dateField = 'dateField';
  static const String bookingTypeField = 'bookingTypeField';
  static const String categoryField = 'categoryField';

  // ===================================
  // CATEGORY KEYS
  // ===================================
  static const String categoryOption = 'categoryOption';

  // ===================================
  // GENERAL UI KEYS
  // ===================================
  static const String floatingActionButton = 'floatingActionButton';

  // Navigation Keys
  static const String scaffoldWithNestedNavigation =
      'ScaffoldWithNestedNavigation';

  // Modal Keys
  static const String editBookingModal = 'edit_booking_modal';

  // Profile screen
  static const String displayNameField = 'displayNameField';
  static const String updateDisplayNameButton = 'updateDisplayNameButton';
  static const String signOutButton = 'signOutButton';
  static const String deleteAccountButton = 'deleteAccountButton';

  // Analytics event names
  static const String bookingCreatedEvent = 'booking_created';
  static const String bookingUpdatedEvent = 'booking_updated';
  static const String bookingDeletedEvent = 'booking_deleted';

  // Analytics parameter keys
  static const String userIdParam = 'user_id';
  static const String bookingIdParam = 'booking_id';
  static const String bookingTypeParam = 'booking_type';
  static const String categoryParam = 'category';
  static const String amountParam = 'amount';
  static const String timestampParam = 'timestamp';

  // Firestore field names
  static const String typeField = 'type';
  static const String createdOnField = 'createdOn';
  static const String createdByField = 'createdBy';
  static const String updatedOnField = 'updatedOn';
  static const String updatedByField = 'updatedBy';

  // Firestore collection paths
  static const String usersCollection = 'users';
  static const String bookingsCollection = 'bookings';

  // Error messages
  static const String userNullAssertion = 'User can\'t be null';

  // ===================================
  // DASHBOARD KEYS
  // ===================================
  static const String dashboardScreen = 'dashboardScreen';
  static const String dashboardHeader = 'dashboardHeader';
  static const String monthlyStatsCard = 'monthlyStatsCard';
  static const String categorySummaryCard = 'categorySummaryCard';
}
