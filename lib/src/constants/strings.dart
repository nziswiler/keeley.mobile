class Strings {
  // ====================
  // GENERAL STRINGS
  // ====================
  static const String cancel = 'Abbrechen';
  static const String close = 'Schliessen';
  static const String save = 'Speichern';
  static const String edit = 'Bearbeiten';
  static const String delete = 'Löschen';
  static const String add = 'Hinzufügen';
  static const String loading = 'Laden...';
  static const String requiredField = 'Pflichtfeld';
  static const String confirmDelete = 'Löschen bestätigen';
  static const String actions = 'Aktionen';
  static const String chf = 'CHF';
  static const String error = 'Fehler';
  static const String localeDe = 'de';
  static const String localeDeCh = 'de_CH';

  // ====================
  // ERROR MESSAGES
  // ====================
  static const String saveFaield = 'Speichern fehlgeschlagen';
  static const String pageNotFound =
      'Uuuups, diese Seite existiert nicht (mehr).';
  static const String errorLoadingData = 'Fehler beim Laden der Daten';
  static const String networkError =
      'Netzwerkfehler. Bitte überprüfen Sie Ihre Internetverbindung.';
  static const String authError =
      'Authentifizierungsfehler. Bitte loggen Sie sich erneut ein.';
  static const String permissionError = 'Keine Berechtigung für diese Aktion.';

  // ====================
  // AUTHENTICATION
  // ====================
  static const String signIn = 'Anmelden';
  static const String signUp = 'Registrieren';
  static const String logout = 'Abmelden';
  static const String email = 'E-Mail';
  static const String password = 'Passwort';
  static const String confirmPassword = 'Passwort bestätigen';
  static const String noAccountYet = 'Noch kein Konto? Jetzt registrieren';
  static const String alreadyHaveAccount =
      'Hast du bereits ein Konto? Hier anmelden';

  // Placeholders
  static const String emailPlaceholder = 'neil@nasa.com';
  static const String passwordPlaceholder = 'Passwort eingeben';
  static const String confirmPasswordPlaceholder = 'Passwort erneut eingeben';

  // Validation messages
  static const String invalidEmail = 'E-Mail Adresse ist ungültig';
  static const String passwordsDoNotMatch = 'Passwörter stimmen nicht überein';
  static const String passwordTooShort =
      'Passwort muss mindestens 6 Zeichen haben';

  // Auth error messages
  static const String signInFailed = 'Anmelden fehlgeschlagen';
  static const String signUpFailed = 'Registrierung fehlgeschlagen';

  // Auth confirmation messages
  static const String logoutAreYouSure =
      'Bist du sicher, dass du dich abmelden möchtest?';

  // ====================
  // NAVIGATION
  // ====================
  static const String dashboard = 'Dashboard';
  static const String bookings = 'Buchungen';
  static const String profile = 'Profil';

  // ====================
  // BOOKINGS
  // ====================
  static const String newBooking = 'Neue Buchung';
  static const String editBooking = 'Buchung bearbeiten';
  static const String deleteBooking = 'Buchung löschen';
  static const String amount = 'Betrag';
  static const String description = 'Beschreibung';
  static const String date = 'Datum';
  static const String category = 'Kategorie';
  static const String bookingType = 'Buchungstyp';
  static const String income = 'Einnahme';
  static const String expense = 'Ausgabe';
  static const String receipt = 'Beleg';

  // Placeholders
  static const String amountPlaceholder = '100.50';
  static const String descriptionPlaceholder = 'Beschreibung der Buchung';
  static const String selectDate = 'Datum auswählen';
  static const String selectCategory = 'Kategorie wählen';
  static const String receiptPlaceholder = 'Beleg hochladen';

  // Booking messages
  static const String saveBookingSuccess =
      'Buchung wurde erfolgreich gespeichert.';
  static const String noBookingsFound = 'Keine Buchungen gefunden';
  static const String noBookingsTitle = 'Keine Buchungen vorhanden';
  static const String noBookingsMessage = 'Erstellen Sie Ihre erste Buchung.';
  static const String bookingsLoadingError = 'Fehler beim Laden der Buchungen';
  static const String loadingBookings = 'Lade Buchungen...';
  static const String unnamedTransaction = 'Unbenannte Transaktion';
  static const String deleteBookingMessage =
      'Sind Sie sicher, dass Sie diese Buchung löschen möchten?';

  // Amount validation
  static const String invalidAmount = 'Ungültiger Betrag';
  static const String negativeValuesNotAllowed =
      'Negative Werte sind nicht erlaubt';
  static const String amountMustBeAtLeast = 'Betrag muss mindestens {0} sein';
  static const String amountMustBeAtMost = 'Betrag darf höchstens {0} sein';
  static const String amountGreaterThanZero =
      'Betrag muss grösser als Null sein';
  static const String descriptionCannotBeEmpty =
      'Die Beschreibung darf nicht leer sein';
  static const String bookingIdCannotBeEmpty =
      'Die Buchungs-ID darf nicht leer sein';

  // Category validation
  static const String invalidCategoryForIncome =
      'Für Einnahmen sind nur Gehalt oder Sonstiges erlaubt';
  static const String invalidCategoryForExpense =
      'Gehalt ist für Ausgaben nicht erlaubt';

  // ====================
  // CATEGORIES
  // ====================
  static const String categoryHousing = 'Wohnen';
  static const String categoryGroceries = 'Lebensmittel';
  static const String categoryTransport = 'Transport';
  static const String categoryLeisure = 'Freizeit';
  static const String categorySalary = 'Gehalt';
  static const String categoryOther = 'Sonstiges';

  // ====================
  // PROFILE
  // ====================
  static const String profileSettings = 'Mein Profil';
  static const String displayName = 'Wie darf Keeley dich nennen?';
  static const String displayNamePlaceholder = 'Neil';
  static const String updateDisplayNameFailed = 'Aktualisierung fehlgeschlagen';
  static const String updateDisplayNameSuccess =
      'Anzeigename erfolgreich aktualisiert';
  static const String deleteAccount = 'Konto löschen';
  static const String deleteAccountConfirmation = 'Konto löschen bestätigen';
  static const String deleteAccountMessage =
      'Bist du sicher, dass du dein Konto löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.';

  // Booking service errors and messages
  static const String failedToCreateBooking =
      'Buchung konnte nicht erstellt werden';
  static const String failedToUpdateBooking =
      'Buchung konnte nicht aktualisiert werden';
  static const String failedToDeleteBooking =
      'Buchung konnte nicht gelöscht werden';
  static const String bookingNotFound = 'Buchung nicht gefunden';
  static const String bookingNotFoundMessage =
      'Buchung mit ID {0} wurde nicht gefunden';
  static const String failedToLogBookingCreation =
      'Buchungserstellung konnte nicht protokolliert werden: {0}';
  static const String failedToLogBookingUpdate =
      'Buchungsaktualisierung konnte nicht protokolliert werden: {0}';
  static const String failedToLogBookingDeletion =
      'Buchungslöschung konnte nicht protokolliert werden: {0}';
  static const String defaultCategoryName = 'keine';
  static const String bookingValidationFailed =
      'Die Buchung ist ungültig. Bitte überprüfen Sie die Eingaben.';

  // ====================
  // ACCESSIBILITY
  // ====================
  static const String closeDialog = 'Dialog schliessen';
  static const String timeTrackingLogo = 'Time tracking logo';

  static const String retryAction = 'Erneut versuchen';
  static const String successToastTitle = 'Yuuhuu! Das hat funktioniert.';

  // ====================
  // DASHBOARD
  // ====================
  static const String dashboardGreeting = 'Hey, Neil!';
  static const String dashboardSubtitle = 'Lass uns den Nachmittag rocken!';
  static const String incomeExpenseTitle = 'Einnahmen & Ausgaben';
  static const String totalAmount = '1000 CHF';
  static const String recentBookingsTitle = 'Letzte Buchungen';

  // Greetings by time
  static const String morningGreeting = 'Guten Morgen, {0}! 😎';
  static const String afternoonGreeting = 'Hey, {0}! 👋';
  static const String eveningGreeting = 'Hi, {0}! ✨';
  static const String nightGreeting = '{0}, noch wach? 🌜';

  // Greeting subtexts by time
  static const String morningSubtext = 'Zeit, die Welt zu erobern!';
  static const String afternoonSubtext = 'Lass uns den Nachmittag rocken!';
  static const String eveningSubtext =
      'Noch Energie für ein paar kreative Ideen?';
  static const String nightSubtext = 'Die besten Einfälle kommen oft spät!';

  // Fallback greeting
  static const String fallbackGreetingName = 'Fellow Hustler';
  static const String fallbackGreeting = 'Hey Fellow Hustler! 👋';

  // Monthly stats
  static const String monthlyBalance = 'Monatssaldo';
  static const String monthlyIncome = 'Einnahmen';
  static const String monthlyExpenses = 'Ausgaben';

  // Category summary
  static const String categorySummaryTitle = 'Ausgaben nach Kategorien';
  static const String noCategoriesTitle = 'Keine Ausgaben vorhanden';
  static const String noCategoriesMessage =
      'Bisher wurden keine Ausgaben in diesem Monat erfasst.';
  static const String loadingCategories = 'Lade Kategorien...';
  static const String loadingCategoriesError =
      'Fehler beim Laden der Kategorien';

  // Monthly stats additional strings
  static const String loadingStats = 'Lade Statistiken...';
  static const String statsLoadingError = 'Fehler beim Laden der Statistiken';
  static const String monthlyOverview = 'Monatliche Übersicht';
}
