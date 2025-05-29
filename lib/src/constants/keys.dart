class Keys {
  static const String emailPassword = 'email-password';
  static const String tabBar = 'tabBar';
  static const String accountTab = 'accountTab';
  static const String logout = 'logout';
  static const String alertDefault = 'alertDefault';
  static const String alertCancel = 'alertCancel';

  // Form field IDs
  static const String email = 'email';
  static const String password = 'password';
  static const String confirmPassword = 'confirmPassword';

  // Sign in screen
  static const String signInForm = 'signInForm';
  static const String signInButton = 'signInButton';
  static const String emailField = 'emailField';
  static const String passwordField = 'passwordField';

  // Sign up screen
  static const String signUpForm = 'signUpForm';
  static const String signUpButton = 'signUpButton';
  static const String confirmPasswordField = 'confirmPasswordField';

  // Edit booking screen
  static const String editBookingForm = 'editBookingForm';
  static const String saveBookingButton = 'saveBookingButton';
  static const String amountField = 'amountField';
  static const String descriptionField = 'descriptionField';
  static const String dateField = 'dateField';
  static const String bookingTypeField = 'bookingTypeField';
  static const String categoryField = 'categoryField';

  // Booking screen
  static const String bookingsScreen = 'bookingsScreen';
  static const String bookingCard = 'bookingCard';
  static const String bookingIcon = 'bookingIcon';
  static const String bookingSummaryCard = 'bookingSummaryCard';
  static const String dismissibleBooking = 'dismissibleBooking';
  static const String deleteBackground = 'deleteBackground';
  static const String editBackground = 'editBackground';
  static const String floatingActionButton = 'floatingActionButton';
  static const String bookingsListView = 'bookingsListView';

  // Booking category selector
  static const String categorySelector = 'categorySelector';
  static const String categoryOption = 'categoryOption';

  // Modal and dialogs
  static const String modalBottomSheet = 'modalBottomSheet';
  static const String formModal = 'formModal';
  static const String headerSection = 'headerSection';
  static const String closeButton = 'closeButton';

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
}
