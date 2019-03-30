class Calc {
  static String getWarmup(int repMax, int setNum) {
    double weight;
    if (setNum == 1) {
      weight = repMax * 0.4; // 40% of RM
    } else if (setNum == 2) {
      weight = repMax * 0.5; // 50% of RM
    } else if (setNum == 3) {
      weight = repMax * 0.6; // 60% of RM
    } else {
      return ("Can't calculate reps for set: $setNum");
    }
    weight = weight + ((5 - (weight % 5)) % 5); // Rounding to the nearest 5
    return ("$weight x 5");
  }
}
