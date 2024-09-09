abstract class PrintStates{}
class InitialPrintState extends PrintStates{}
class LoadingPrinterState extends PrintStates{}
class SuccessPrinterState extends PrintStates{}
class PrintFaildState extends PrintStates{
  final String message ;

  PrintFaildState({required this.message});
}