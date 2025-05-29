class Strings {
  // Generic strings
  static const String ok = 'OK';
  static const String cancel = 'Abbrechen';
  static const String close = 'Schließen';

  // Logout
  static const String logout = 'Abmelden';
  static const String logoutAreYouSure =
      'Bist du sicher, dass du dich abmelden möchtest?';
  static const String logoutFailed = 'Abmelden fehlgeschlagen';

  // Sign In Page
  static const String signIn = 'Anmelden';
  static const String signInWithEmailPassword =
      'Anmelden mit E-Mail und Passwort';
  static const String signInFailed = 'Anmelden fehlgeschlagen';
  static const String signInLoading = 'Anmelden...';
  static const String validationFailedMessage = 'Validierung fehlgeschlagen';

  // Sign Up Page
  static const String signUp = 'Registrieren';
  static const String signUpWithEmailPassword =
      'Registrieren mit E-Mail und Passwort';
  static const String signUpFailed = 'Registrierung fehlgeschlagen';
  static const String signUpLoading = 'Registrieren...';
  static const String confirmPassword = 'Passwort bestätigen';
  static const String confirmPasswordPlaceholder = 'Passwort erneut eingeben';
  static const String passwordsDoNotMatch = 'Passwörter stimmen nicht überein';
  static const String passwordTooShort =
      'Passwort muss mindestens 6 Zeichen haben';

  // Form fields
  static const String email = 'E-Mail';
  static const String password = 'Passwort';
  static const String emailPlaceholder = 'neil@nasa.com';
  static const String passwordPlaceholder = 'Passwort eingeben';
  static const String chf = 'CHF';

  // Validation errors
  static const String requiredField = 'Pflichtfeld';
  static const String invalidEmail = 'E-Mail Adresse ist ungültig';

  // Dashboard
  static const String dashboard = 'Dashboard';

  // Bookings
  static const String bookings = 'Buchungen';

  // Account page
  static const String account = 'Profil';
  static const String accountPage = 'Profil Seite';

  // Edit booking screen
  static const String newBooking = 'Neue Buchung';
  static const String editBooking = 'Buchung bearbeiten';
  static const String saveBooking = 'Speichern';
  static const String savingBooking = 'Speichern...';
  static const String amount = 'Betrag';
  static const String amountPlaceholder = '100.50';
  static const String description = 'Beschreibung';
  static const String descriptionPlaceholder = 'Beschreibung der Buchung';
  static const String date = 'Datum';
  static const String selectDate = 'Datum auswählen';
  static const String category = 'Kategorie';
  static const String selectCategory = 'Kategorie wählen';
  static const String bookingType = 'Buchungstyp';
  static const String income = 'Einnahme';
  static const String expense = 'Ausgabe';
  static const String saveBookingFailed = 'Speichern fehlgeschlagen';
  static const String saveBookingSuccess =
      'Buchung wurde erfolgreich gespeichert.';

  // Categories
  static const String categoryHousing = 'Wohnen';
  static const String categoryGroceries = 'Lebensmittel';
  static const String categoryTransport = 'Transport';
  static const String categoryLeisure = 'Freizeit';
  static const String categorySalary = 'Gehalt';
  static const String categoryOther = 'Sonstiges';

  // Loading states
  static const String loading = 'Laden...';

  // Currency input validation
  static const String invalidAmount = 'Ungültiger Betrag';
  static const String negativeValuesNotAllowed =
      'Negative Werte sind nicht erlaubt';
  static const String amountMustBeAtLeast = 'Betrag muss mindestens';
  static const String amountMustBeAtMost = 'Betrag darf höchstens';
  static const String invalidCategoryForIncome =
      'Für Einnahmen sind nur Gehalt oder Sonstiges erlaubt';
  static const String invalidCategoryForExpense =
      'Gehalt ist für Ausgaben nicht erlaubt';

  // Bookings screen
  static const String noBookingsFound = 'Keine Buchungen gefunden';
  static const String deleteBooking = 'Buchung löschen';
  static const String unnamedTransaction = 'Unbenannte Transaktion';
  static const String confirmDelete = 'Löschen bestätigen';
  static const String deleteBookingMessage =
      'Sind Sie sicher, dass Sie diese Buchung löschen möchten?';

  // Icons and accessibility
  static const String bookingIcon = 'Buchungssymbol';
  static const String incomeIcon = 'Einnahmensymbol';
  static const String expenseIcon = 'Ausgabensymbol';
  static const String closeDialog = 'Dialog schliessen';

  // Empty placeholder
  static const String add = 'Hinzufügen';
}
