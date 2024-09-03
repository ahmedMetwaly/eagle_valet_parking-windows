abstract class CalculateDurationStates {}

class InitialCalculateDuration extends CalculateDurationStates {}

class LoadingCalculateDuration extends CalculateDurationStates {}

class CompletedCalculationDuration extends CalculateDurationStates {}

class ErrorCalculationDuration extends CalculateDurationStates {
  final String error;

  ErrorCalculationDuration({required this.error});
}
