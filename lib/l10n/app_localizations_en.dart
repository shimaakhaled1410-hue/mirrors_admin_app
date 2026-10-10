// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mirrors Store';

  @override
  String get cm => 'cm';

  @override
  String get egp => 'EGP';

  @override
  String get whatsappError =>
      'Could not open WhatsApp. Please ensure it is installed on your device.';

  @override
  String get adminAccess => 'Admin Access';

  @override
  String get adminPinPrompt => 'Enter admin PIN to continue';

  @override
  String get invalidPin => 'Invalid PIN code';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get adminOrdersTitle => 'Orders Management';

  @override
  String get allOrders => 'All';

  @override
  String get changeStatus => 'Change Status';

  @override
  String get statusUpdatedSuccess => 'Order status updated successfully';

  @override
  String get callClient => 'Call';

  @override
  String get whatsappClient => 'WhatsApp';

  @override
  String get depositPaidLabel => 'Deposit Paid';

  @override
  String get remainingToPay => 'Remaining';

  @override
  String get noOrdersYet => 'No orders yet';

  @override
  String get statusReceived => 'New Order';

  @override
  String get statusPreparing => 'Preparing';

  @override
  String get statusShipping => 'Out for Delivery';

  @override
  String get statusDelivered => 'Delivered';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get itemsSummary => 'Order Items';

  @override
  String get statusUpdateFailed => 'Failed to update status';

  @override
  String get senderWalletLabel => 'Sender wallet number';

  @override
  String get statusDepositConfirmed => 'Deposit Confirmed';

  @override
  String get confirmDepositAction => 'Confirm Deposit Receipt';

  @override
  String get navOrders => 'Orders';

  @override
  String get navProduction => 'Production';

  @override
  String get productionTitle => 'Production & Workshop';

  @override
  String get totalUnitsRequired => 'Total Units';

  @override
  String get activeProductionOrders => 'Active Orders';

  @override
  String get noProductionOrders => 'No pending production orders';

  @override
  String get relatedOrders => 'Related Orders';

  @override
  String get shareProductionSummary => 'Share Production Summary';

  @override
  String get productionSummaryHeader => 'Workshop Production Plan';

  @override
  String get framedMirrors => 'Framed Mirrors';

  @override
  String get adhesiveMirrors => 'Double Adhesive Mirrors';

  @override
  String get filterWithShelf => 'With Shelf';
}
