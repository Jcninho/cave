String normalize(String value) => value
    .trim()
    .replaceAll(RegExp(r'\s+'), ' ')
    .split(' ')
    .where((w) => w.isNotEmpty)
    .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
    .join(' ');
