/// Default letters to fill in the empty spaces
const String wsLetters = 'ابتثجحخدذرزسشصضطظعغفقكلمنهوي';

/// All the orientations available to build the puzzle
enum WSOrientation {
  /// Horizontal orientation
  horizontal,

  /// Vertical orientation
  vertical,

  /// Diagonal down orientation
  diagonal,
}

/// The puzzle settings intetface
class WSSettings {
  /// The recommended height of the puzzle
  ///
  /// **Note:** This will automatically increment if
  /// the words cannot be placed properly in the puzzle
  int height;

  /// The recommended width of the puzzle
  ///
  /// **Note:** This will automatically increment if
  /// the words cannot be placed properly in the puzzle
  int width;

  /// The allowed orientations for the words placed in the puzzle
  final List<WSOrientation> orientations;

  /// The way in which empty spaces in the puzzle should be filled
  ///
  /// If `Function` then should return a string with single character
  /// Example:
  /// ```
  /// fillBlanks: () {
  ///   final fancyStrings = '@#$%^420';
  ///   return fancyStrings[Random().nextInt(fancyStrings.length)];
  /// }
  /// ```
  ///
  /// If `String` then should contain a set of unique characters
  /// Example:
  /// ```
  /// fillBlanks: '@#$%^420',
  /// ```
  /// If `bool` it will use the default functionality
  final dynamic fillBlanks;

  /// Allow the puzzle to be filled with blanks
  final bool allowExtraBlanks;

  /// Maximum number of attempts to fit the words in the puzzle
  final int maxAttempts;

  /// Maximum numbed of times the grid can grow
  /// depending on the length of the words and placement
  final int maxGridGrowth;

  /// Allow overlaping of words in the puzzle
  final bool preferOverlap;

  WSSettings({
    required this.width,
    required this.height,
    this.orientations = WSOrientation.values,
    this.fillBlanks,
    this.allowExtraBlanks = false,
    this.maxAttempts = 3,
    this.maxGridGrowth = 10,
    this.preferOverlap = false,
  });
}

/// Word location interface
class WSLocation implements WSPosition {
  /// The column position where the word starts
  @override
  final int x;

  /// The row position where the word starts
  @override
  final int y;

  /// The orientation the word placed in the puzzle
  final WSOrientation orientation;

  /// The numbed of overlaps the word has
  final int overlap;

  /// The word used
  String word;

  WSLocation({
    required this.x,
    required this.y,
    required this.orientation,
    required this.overlap,
    required this.word,
  });
}

// Word position interface
class WSPosition {
  /// The column position where the word starts
  final int x;

  /// The row position where the word starts
  final int y;

  WSPosition({
    this.x = 0,
    this.y = 0,
  });
}

/// New puzzle interface
class WSNewPuzzle {
  /// Two dimensional list containing the puzzle
  List<List<String>>? puzzle;

  /// List of word not placed in the puzzle
  List<String> wordsNotPlaced;

  /// List of warnings that occurred while creating the puzzle
  ///
  /// **Note:** Use this to notify the user of any issues
  List<String> warnings;

  /// List of errors that occurred while creating the puzzle
  ///
  /// **Note:** Check this before printing or viewing the puzzle
  List<String> errors;

  WSNewPuzzle({
    this.puzzle,
    List<String>? wordsNotPlaced,
    List<String>? warnings,
    List<String>? errors,
  })  : wordsNotPlaced = wordsNotPlaced ?? [],
        warnings = warnings ?? [],
        errors = errors ?? [];

  List<String> toList() {
    List<String> items = [];
    if (puzzle != null) {
      for (var i = 0, height = puzzle!.length; i < height; i++) {
        final List<String> row = puzzle![i];
        for (var j = 0, width = row.length; j < width; j++) {
          items.add(row[j] == '' ? ' ' : row[j]);
        }
      }
      return items;
    }
    return [];
  }
}

/// Orientation function interface
typedef WSOrientationFn = WSPosition Function(int x, int y, int i);

/// Check orientation function interface
typedef WSCheckOrientationFn = bool Function(int x, int y, int h, int w, int l);
