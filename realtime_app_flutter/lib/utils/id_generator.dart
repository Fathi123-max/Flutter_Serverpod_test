import 'dart:math';

String generateId() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      16,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ),
  );
}