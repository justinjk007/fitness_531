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

  static String getRealSet(int repMax, int setNum, String weekID) {
    double weight;
    int repNum = 5;
    if (weekID == 'week1') {
      repNum = 5;
      if (setNum == 1) {
        weight = repMax * 0.65;
      } else if (setNum == 2) {
        weight = repMax * 0.75;
      } else if (setNum == 3) {
        weight = repMax * 0.85;
      } else {
        return ("Can't calculate reps for set: $setNum");
      }
    } else if (weekID == 'week2') {
      repNum = 3;
      if (setNum == 1) {
        weight = repMax * 0.70;
      } else if (setNum == 2) {
        weight = repMax * 0.80;
      } else if (setNum == 3) {
        weight = repMax * 0.90;
      } else {
        return ("Can't calculate reps for set: $setNum");
      }
    } else if (weekID == 'week3') {
      if (setNum == 1) {
        repNum = 5;
        weight = repMax * 0.75;
      } else if (setNum == 2) {
        repNum = 3;
        weight = repMax * 0.85;
      } else if (setNum == 3) {
        repNum = 1;
        weight = repMax * 0.95;
      } else {
        return ("Can't calculate reps for set: $setNum");
      }
    } else if (weekID == 'week4') {
      repNum = 5;
      if (setNum == 1) {
        weight = repMax * 0.40;
      } else if (setNum == 2) {
        weight = repMax * 0.50;
      } else if (setNum == 3) {
        weight = repMax * 0.60;
      } else {
        return ("Can't calculate reps for set: $setNum");
      }
    } else {
      return ("Can't calculate reps for $weekID");
    }

    weight = weight + ((5 - (weight % 5)) % 5); // Rounding to the nearest 5
    return ("$weight x $repNum");
  }
}
