import 'package:dart_language/introduction/introduction.dart';

void main() {
  print('Hello, World!');
  setupVariables();
  controlFlowAndFunctions();
  calculateFibonacciAndPrintFilteredObjects();
  Spacecraft spacecraft = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  describeSpacecraft(spacecraft);
}
