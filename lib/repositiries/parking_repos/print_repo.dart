import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:thermal_printer/thermal_printer.dart';
import 'package:eagle_valet_parking/resources/image_manager.dart';
import 'package:flutter/services.dart';

import 'package:image/image.dart' as img;

class PrintTicketRepo {
  Future<Set<PrinterDevice>> scan() async {
    Set<PrinterDevice> devices = {};
    try {
      // Find printers
      PrinterManager.instance
          .discovery(type: PrinterType.usb, isBle: false)
          .listen((device) {
        print(devices);
        devices.add(device);
      });
    } catch (error) {
      throw Exception(error);
    }
    return devices;
  }

  Future connectPrinter(String selectedPrinter,
      {bool reconnect = false, bool isBle = false, String? ipAddress}) async {
    try {
      await PrinterManager.instance
          .connect(
              type: PrinterType.usb,
              model: UsbPrinterInput(
                name: selectedPrinter,
              ))
          .then((value) {
        if (value == true) {
          print('Connected to printer $selectedPrinter');
        } else {
          print('Failed to connect to printer $selectedPrinter');
        }
      });
    } catch (error) {
      throw Exception(error);
    }
  }

  Future generateReceipt({
    required String ticketNumber,
    String? enterDate,
    String? enterTime,
    String? parkingFee,
    String? leavingDate,
    String? leavingTime,
    String? duration,
  }) async {
    CapabilityProfile profile = await CapabilityProfile.load();
    Generator generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];
    bytes += generator.text("Eagle valet parking",
        styles: const PosStyles(
            bold: true, width: PosTextSize.size2, height: PosTextSize.size2));

    final ByteData data = await rootBundle.load(ImageManager.printLogo);
    if (data.lengthInBytes > 0) {
      final Uint8List imageBytes = data.buffer.asUint8List();
      final decodedImage = img.decodeImage(imageBytes)!;
      img.Image originalImg =
          img.copyResize(decodedImage, width: 380, height: 130);
      img.fill(originalImg, color: img.ColorRgb8(255, 255, 255));

      final img.Image resizedImage = img.copyResize(
        decodedImage,
        width: 384,
      );
      final img.Image grayscaleImage = img.grayscale(resizedImage);
      bytes += generator.feed(1);
      bytes += generator.text("   ");
      bytes += generator.imageRaster(
        grayscaleImage,
      );
      bytes += generator.feed(1);
    }

    bytes += generator.hr();

    bytes += generator.row([
      PosColumn(
          width: 12,
          text: parkingFee == null
              ? "Ticket Number:                               "
              : "Parking fee:                                 ",
          styles: const PosStyles(
            align: PosAlign.left,
            bold: true,
          )),
    ]);
    bytes += generator.text(
        parkingFee == null ? ticketNumber : "$parkingFee LE",
        styles: const PosStyles(
            align: PosAlign.center,
            bold: true,
            width: PosTextSize.size5,
            height: PosTextSize.size5));

    bytes += generator.hr();

    (enterDate == null && leavingDate == null)
        ? null
        : bytes += generator.text(
            leavingDate == null
                ? "Date: $enterDate                     "
                : "Date: $leavingDate                   ",
            styles: const PosStyles(
              align: PosAlign.left,
              bold: true,
            ));
    (enterTime == null && leavingTime == null)
        ? null
        : bytes += generator.text(
            leavingTime == null
                ? "Entering Time: $enterTime                      "
                : "Leaving Time: $leavingTime                     ",
            styles: const PosStyles(
              align: PosAlign.left,
              bold: true,
            ));
    parkingFee == null
        ? null
        : bytes += generator.text("Duration of time: $duration      ",
            styles: const PosStyles(
              align: PosAlign.left,
              bold: true,
            ));
    // bytes += generator.emptyLines(8);
    bytes += generator.cut();

    //  print(bytes.toString());
    await PrinterManager.instance.send(type: PrinterType.usb, bytes: bytes);
    //return bytes;
  }

  Future firstReceipt() async {
    CapabilityProfile profile = await CapabilityProfile.load();
    Generator generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    final ByteData data = await rootBundle.load(ImageManager.printLogo);
    if (data.lengthInBytes > 0) {
      final Uint8List imageBytes = data.buffer.asUint8List();
      final decodedImage = img.decodeImage(imageBytes)!;
      img.Image originalImg =
          img.copyResize(decodedImage, width: 380, height: 130);
      img.fill(originalImg, color: img.ColorRgb8(255, 255, 255));

      final img.Image resizedImage = img.copyResize(
        decodedImage,
        width: 384,
      );
      final img.Image grayscaleImage = img.grayscale(resizedImage);
      bytes += generator.feed(1);
      bytes += generator.text("   ");
      bytes += generator.imageRaster(
        grayscaleImage,
      );
      bytes += generator.feed(1);
    }

    bytes += generator.text("Connect with us on linked in and whats app.");
    bytes += generator.text("Whats app: 01124408206                     ");
    bytes += generator.text("Linkedin:                                  ");
    bytes += generator.text("www.linkedin.com/in/ahmed-mohamed-metwaly/ ");
    bytes += generator.feed(1);

    bytes += generator.text("Thank yor for choosing us.                 ");
    bytes += generator.text("We will be happy to serve you again.       ");
    bytes += generator.feed(2);

    bytes += generator.text("                         Eng/ Ahmed Metwaly");

    bytes += generator.cut();
    await PrinterManager.instance.send(type: PrinterType.usb, bytes: bytes);
  }
}
