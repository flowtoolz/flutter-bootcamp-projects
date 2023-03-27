void main() {
  Duck().function();
}

class Duck extends Animal with SwimmingAbility, FlyingAbility {
  // Question: why the fuck is there not even a compiler warning when two mixins have an equally named property ???
  function() {
    print(myNumber);
  }
}

mixin SwimmingAbility {
  swim() {
    print('swimming');
  }

  int myNumber = 10;
}

mixin FlyingAbility {

  swim() {
    print('flying');
  }

  int myNumber = 7;
}

class Animal {
  void move() {
    print('change position');
  }
}