class Calculations {
  static String benchAndPressWarmup(int repMax, int setNum) {
    int weight;
    if (setNum == 1) {
      weight = repMax * 0.4; // 40% of RM
    } else if (setNum == 2) {
      weight = repMax * 0.5; // 50% of RM
    } else if (setNum == 3) {
      weight = repMax * 0.6; // 60% of RM
    } else {
      return ("Can't calculate reps for set: $setNum");
    }
    weight = ((weight + 4) / 5) * 5; // Rounding to the nearest 5
    return ("$weight x 5");
  }
}
