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
    return ("${weight.toInt()} x 5");
  }

  static String getRealSet(int repMax, int setNum, String weekID) {
    var val = getRealSetVals(repMax, setNum, weekID);
    return ("${val[0]} x ${val[1]}");
  }

  static List getRealSetVals(int repMax, int setNum, String weekID) {
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
        return null;
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
        return null;
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
        return null;
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
        return null;
      }
    } else {
      return null;
    }

    weight = weight + ((5 - (weight % 5)) % 5); // Rounding to the nearest 5
    return [weight, repNum];
  }

  static String getAssistanceSet(int repMax) {
    double weight;
    weight = repMax * 0.5; // 50% of RM
    weight = weight + ((5 - (weight % 5)) % 5); // Rounding to the nearest 5
    return ("${weight.toInt()} x 5 x 10");
  }

  static String plateCalculator(int repMax, int setNum, String weekID) {
    // index 0 returns the weight for this set
    double weight = getRealSetVals(repMax, setNum, weekID)[0];
    const double BAR_WEIGHT = 45; // lbs
    var plates = [45, 35, 25, 10, 5, 2.5];
    var plateCount = [0, 0, 0, 0, 0, 0];

    if (weight < BAR_WEIGHT) {
      return ("No plates required");
    }
    double weightAfterBar = weight - BAR_WEIGHT;

    for (int i = 0; i < plates.length; i++) {
      while (weightAfterBar / plates[i] >= 2) {
        weightAfterBar -= (plates[i] * 2);
        plateCount[i] += 2;
      }
    }
    String val = "Load ";
    for (int j = 0; j < plates.length; j++) {
      int plateNum = plateCount[j] ~/ 2;
      if (plateNum != 0) {
        val += "$plateNum ${plates[j]}lb plates ";
      }
    }
    return val;
  }
}
