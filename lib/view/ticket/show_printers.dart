import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thermal_printer/thermal_printer.dart';
import '../../bloc/print_cubit/print_cubit.dart';
import '../../bloc/sharedprefrences/sharedpref_bloc.dart';
import '../../bloc/sharedprefrences/sharedpref_state.dart';
import '../../generated/l10n.dart';
import '../../resources/routes.dart';
import '../../resources/values_manager.dart';

class ShowPrinters extends StatelessWidget {
  const ShowPrinters({super.key, required this.size, required this.devices});
  final Size size;
  final Set<PrinterDevice> devices;
  @override
  Widget build(BuildContext context) {
    Future connectDevice(PrinterDevice selectedPrinter,
        {bool reconnect = false, bool isBle = false, String? ipAddress}) async {
      await PrinterManager.instance
          .connect(
              type: PrinterType.usb,
              model: UsbPrinterInput(
                  name: selectedPrinter.name,
                  productId: selectedPrinter.productId,
                  vendorId: selectedPrinter.vendorId))
          .then((value) {
        if (value == true) {
          print(
              'Connected to printer ${selectedPrinter.name} with id ${selectedPrinter.productId}');
        } else {
          print('Failed to connect to printer ${selectedPrinter.name}');
        }
      });
    }

    return Container(
      height: size.height * 0.30,
      width: size.width * 0.4,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(SizeManager.bottomSheetRadius),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          )),
      child: BlocBuilder<SharedPrefBloc, SettingsStates>(
        builder: (BuildContext context, SettingsStates state) => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(PaddingManager.pInternalPadding),
                itemBuilder: (context, index) => ListTile(
                    onTap: () async {
                      await connectDevice(devices.elementAt(index))
                          .then((_) async {
                        await context
                            .read<SharedPrefBloc>()
                            .selectPrinter(
                              printerName: devices.elementAt(index).name,
                            )
                            .then((_) async => await context
                                .read<PrintCubit>()
                                .firstReceipt());
                      });
                    },
                    trailing: context.read<SharedPrefBloc>().printer ==
                            devices.elementAt(index).name
                        ? Icon(Icons.beenhere_rounded,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                    title: Text(devices.elementAt(index).name)),
                itemCount: devices.length,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            ElevatedButton(
                onPressed: () {
                  if (state is SettingsLoadedSuccessfully) {
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.onBoarding);
                  }
                },
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: size.width * 0.02)),
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary),
                ),
                child: Text(
                  S.current.done,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                )),
          ],
        ),
      ),
    );
  }
}
