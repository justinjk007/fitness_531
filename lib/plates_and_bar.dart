// Here PlatesAndBar class stores a bar weight and the plates available as a
// map. Here these maps are kept dynamic so serialized json does not error out
// when read back in, however we only accept bool as keys in design

class PlatesAndBar {
  Map<String, dynamic> platesMap;
  double barWeight;

  // constructor
  PlatesAndBar(Map<String, dynamic> foo, double bar) {
    this.platesMap = foo;
    this.barWeight = bar;
  }

  // constructor
  PlatesAndBar.common() {
    // Store the default and most commonly found setups in gyms
    this.platesMap = {
      '2.5': true,
      '5': true,
      '10': true,
      '25': true,
      '35': false,
      '45': true,
      '55': false,
    };
    this.barWeight = 45;
  }
}
