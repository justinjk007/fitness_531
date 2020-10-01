import 'plates_and_bar.dart';

class Calc {
  static String getWarmup(int repMax, int setNum) {
    var val = getWarmupVals(repMax, setNum);
    return ("${val[0].toInt()} x ${val[1]}");
  }

  static List getWarmupVals(int repMax, int setNum) {
    double weight;
    final int repNum = 5;
    if (setNum == 1) {
      weight = repMax * 0.4; // 40% of RM
    } else if (setNum == 2) {
      weight = repMax * 0.5; // 50% of RM
    } else if (setNum == 3) {
      weight = repMax * 0.6; // 60% of RM
    } else {
      return null;
    }

    weight = weight + ((5 - (weight % 5)) % 5); // Rounding to the nearest 5
    return [weight, repNum];
  }

  static String getRealSet(int repMax, int setNum, String weekID) {
    var val = getRealSetVals(repMax, setNum, weekID);
    return ("${val[0].toInt()} x ${val[1]}");
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
    return ("${getAssistanceSetVals(repMax).toInt()} x 5 x 10");
  }

  static double getAssistanceSetVals(int repMax) {
    double weight;
    weight = repMax * 0.5; // 50% of RM
    weight = weight + ((5 - (weight % 5)) % 5); // Rounding to the nearest 5
    return weight;
  }

  static Map getPlateCalculatorMap(
    double weight,
    PlatesAndBar barbell,
  ) {
    var plates = [45.0, 35.0, 25.0, 10.0, 5.0, 2.5]; // This should have floats
    Map<double, int> platesMap = {
      // key => value
      45: 0,
      35: 0,
      25: 0,
      10: 0,
      5: 0,
      2.5: 0,
    };

    var plateCount = [0, 0, 0, 0, 0, 0]; // Initial plate count

    if (weight < barbell.barWeight) {
      return platesMap;
    }
    double weightAfterBar = weight - barbell.barWeight;

    for (int i = 0; i < plates.length; i++) {
      while (weightAfterBar / plates[i] >= 2) {
        weightAfterBar -= (plates[i] * 2);
        plateCount[i] += 2;
      }
    }
    for (int j = 0; j < plates.length; j++) {
      int plateNum = plateCount[j] ~/ 2; // We only want one side's plate
      if (plateNum != 0) {
        platesMap[plates[j]] = plateNum;
      }
    }
    return platesMap;
  }
}
