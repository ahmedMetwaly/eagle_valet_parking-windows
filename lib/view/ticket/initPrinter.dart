import 'package:eagle_valet_parking/generated/l10n.dart';
import 'package:eagle_valet_parking/resources/values_manager.dart';
import 'package:eagle_valet_parking/view/home/widgets/myAppBar.dart';
import 'package:eagle_valet_parking/view/home/widgets/my_bottom_navigation_bar.dart';
import 'package:eagle_valet_parking/view/ticket/show_printers.dart';
import 'package:flutter/material.dart';
import 'package:thermal_printer/thermal_printer.dart';

class InitPrinter extends StatefulWidget {
  const InitPrinter({super.key});

  @override
  State<InitPrinter> createState() => _InitPrinterState();
}

Set<PrinterDevice> devices = {};

@override
class _InitPrinterState extends State<InitPrinter> {
  
  Future scan() async {
    // Find printers
    PrinterManager.instance
        .discovery(type: PrinterType.usb, isBle: false)
        .listen((device) {
      setState(() {
        print(devices);
        devices.add(device);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar(context),
      bottomNavigationBar: MyBottomNavigationBar(size: size),
      body: Padding(
        padding: const EdgeInsets.all(PaddingManager.pMainPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  //  await init();
                  await scan();
                },
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                      horizontal: devices.isEmpty
                          ? size.width * 0.08
                          : size.width * 0.2,
                      vertical: devices.isEmpty
                          ? size.height * 0.04
                          : size.height * 0.03)),
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                ),
                child: Text(
                  S.current.scan_printers,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              devices.isEmpty
                  ? const SizedBox()
                  : Expanded(child: ShowPrinters(size: size, devices: devices)),
            ],
          ),
        ),
      ),
    );
  }
}
