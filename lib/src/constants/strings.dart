class Strings {
  // ====================
  // GENERAL STRINGS
  // ====================
  static const String cancel = 'Abbrechen';
  static const String close = 'Schließen';
  static const String save = 'Speichern';
  static const String edit = 'Bearbeiten';
  static const String delete = 'Löschen';
  static const String add = 'Hinzufügen';
  static const String loading = 'Laden...';
  static const String requiredField = 'Pflichtfeld';

  // ====================
  // ERROR MESSAGES
  // ====================
  static const String pageNotFound =
      'Uuuups, diese Seite existiert nicht (mehr).';

  // ====================
  // AUTHENTICATION
  // ====================
  static const String signIn = 'Anmelden';
  static const String signUp = 'Registrieren';
  static const String logout = 'Abmelden';
  static const String email = 'E-Mail';
  static const String password = 'Passwort';
  static const String confirmPassword = 'Passwort bestätigen';

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
  static const String saveBooking = 'Speichern';
  static const String amount = 'Betrag';
  static const String description = 'Beschreibung';
  static const String date = 'Datum';
  static const String category = 'Kategorie';
  static const String bookingType = 'Buchungstyp';
  static const String income = 'Einnahme';
  static const String expense = 'Ausgabe';

  // Placeholders
  static const String amountPlaceholder = '100.50';
  static const String descriptionPlaceholder = 'Beschreibung der Buchung';
  static const String selectDate = 'Datum auswählen';
  static const String selectCategory = 'Kategorie wählen';

  // Currency
  static const String chf = 'CHF';

  // Booking messages
  static const String saveBookingFailed = 'Speichern fehlgeschlagen';
  static const String saveBookingSuccess =
      'Buchung wurde erfolgreich gespeichert.';
  static const String noBookingsFound = 'Keine Buchungen gefunden';
  static const String unnamedTransaction = 'Unbenannte Transaktion';
  static const String confirmDelete = 'Löschen bestätigen';
  static const String deleteBookingMessage =
      'Sind Sie sicher, dass Sie diese Buchung löschen möchten?';

  // Amount validation
  static const String invalidAmount = 'Ungültiger Betrag';
  static const String negativeValuesNotAllowed =
      'Negative Werte sind nicht erlaubt';
  static const String amountMustBeAtLeast = 'Betrag muss mindestens {0} sein';
  static const String amountMustBeAtMost = 'Betrag darf höchstens {0} sein';

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
  static const String updateDisplayName = 'Speichern';
  static const String updateDisplayNameFailed = 'Aktualisierung fehlgeschlagen';
  static const String updateDisplayNameSuccess =
      'Anzeigename erfolgreich aktualisiert';
  static const String deleteAccount = 'Konto löschen';
  static const String deleteAccountConfirmation = 'Konto löschen bestätigen';
  static const String deleteAccountMessage =
      'Bist du sicher, dass du dein Konto löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.';
  static const String actions = 'Aktionen';

  // ====================
  // ACCESSIBILITY
  // ====================
  static const String closeDialog = 'Dialog schliessen';
  static const String timeTrackingLogo = 'Time tracking logo';

  static const String retryAction = 'Erneut versuchen';

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

  // ====================
  // AUTH NAVIGATION
  // ====================
  static const String noAccountYet = 'Noch kein Konto? Jetzt registrieren';
  static const String alreadyHaveAccount =
      'Hast du bereits ein Konto? Hier anmeldn';
}
