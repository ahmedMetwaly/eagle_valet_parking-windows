class TranslteNumericaleRepo {
  String arabicToEnglishNumerals(String arabicTime) {
    const arabicNumerals = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const englishNumerals = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    // Replace each Arabic numeral with its English counterpart
    for (int i = 0; i < arabicNumerals.length; i++) {
      arabicTime = arabicTime.replaceAll(arabicNumerals[i], englishNumerals[i]);
    }

    return arabicTime;
  }

  String englishToArabicNumerals(String englishTime) {
    const arabicNumerals = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const englishNumerals = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    // Replace each English numeral with its Arabic counterpart
    for (int i = 0; i < englishNumerals.length; i++) {
      englishTime =
          englishTime.replaceAll(englishNumerals[i], arabicNumerals[i]);
    }

    return englishTime;
  }
}
