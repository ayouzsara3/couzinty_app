bool arraysEqual(List<String> array1, List<String> array2) {
  // Check if the lengths are equal
  if (array1.length != array2.length) {
    return false;
  }

  // Iterate over each element and compare them
  for (int i = 0; i < array1.length; i++) {
    if (array1[i] != array2[i]) {
      return false;
    }
  }

  // If all elements match, return true
  return true;
}
