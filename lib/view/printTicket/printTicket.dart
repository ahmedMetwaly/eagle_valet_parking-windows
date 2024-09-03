import 'package:eagle_valet_parking/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:thermal_printer/thermal_printer.dart';

class PrintTicket extends StatefulWidget {
  const PrintTicket({super.key});

  @override
  State<PrintTicket> createState() => _PrintTicketState();
}

List<PrinterDevice> devices = [];

class _PrintTicketState extends State<PrintTicket> {
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
        print('Connected to printer ${selectedPrinter.name}');
      } else {
        print('Failed to connect to printer ${selectedPrinter.name}');
      }
    });
  }

  Future<List<int>> generateReceipt() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    generator.spaceBetweenRows = 2;

    List<int> bytes = [];
    bytes += generator.text(S.current.Eagle_valet_parking,
        styles: const PosStyles(
            align: PosAlign.center, bold: true, width: PosTextSize.size4));
    bytes += generator.hr();
    bytes += generator.text("Ticket Number:",
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
        ));

                    bytes += generator.emptyLines(5);
    bytes += generator.text("  10",
        styles: const PosStyles(
          height: PosTextSize.size8,
            align: PosAlign.center, bold: true, width: PosTextSize.size8));
            bytes += generator.emptyLines(5);
    bytes += generator.hr();

    bytes += generator.text("Enter Date: 2nd septemper 2024",
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
        ));
    bytes += generator.text("Enter Time: 22:13:0",
        styles: const PosStyles(
          align: PosAlign.center,
        ));

    //  print(bytes.toString());
    return bytes;
  }

  Future sendBytesToPrint(
    List<int> bytes,
  ) async {
    await PrinterManager.instance
        .send(type: PrinterType.usb, bytes: bytes)
        .then((value) {
      if (value == true) {
        print('Printed successfully');
      } else {
        print('Failed to print');
      }
    });
  }

  Future cutReciept() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
   generator.cut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: ElevatedButton(
                child: Text("Scan"),
                onPressed: () async {
                  await scan();
                },
              )),
          Expanded(
              flex: 8,
              child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                    onTap: () async {
                       await connectDevice(devices[index]);
                      await sendBytesToPrint(await generateReceipt());
                       await cutReciept();
                    },
                    title: Text(devices[index].name)),
                itemCount: devices.length,
              )),
        ],
      ),
    );
  }
}
