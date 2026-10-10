// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'متجر المرايات';

  @override
  String get cm => 'سم';

  @override
  String get egp => 'ج.م';

  @override
  String get whatsappError =>
      'تعذر فتح تطبيق واتساب. يرجى التأكد من تثبيته على جهازك.';

  @override
  String get adminAccess => 'دخول الإدارة';

  @override
  String get adminPinPrompt => 'أدخل رمز PIN للمتابعة';

  @override
  String get invalidPin => 'رمز PIN غير صحيح';

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';

  @override
  String get adminOrdersTitle => 'إدارة الطلبات';

  @override
  String get allOrders => 'الكل';

  @override
  String get changeStatus => 'تغيير الحالة';

  @override
  String get statusUpdatedSuccess => 'تم تحديث حالة الطلب بنجاح';

  @override
  String get callClient => 'اتصال';

  @override
  String get whatsappClient => 'واتساب';

  @override
  String get depositPaidLabel => 'العربون المدفوع';

  @override
  String get remainingToPay => 'المتبقي عند الاستلام';

  @override
  String get noOrdersYet => 'لا توجد طلبات حتى الآن';

  @override
  String get statusReceived => 'طلب جديد';

  @override
  String get statusPreparing => 'جاري التجهيز';

  @override
  String get statusShipping => 'مع المندوب';

  @override
  String get statusDelivered => 'تم التسليم';

  @override
  String get statusCancelled => 'ملغي';

  @override
  String get itemsSummary => 'المنتجات المطلوبة';

  @override
  String get statusUpdateFailed => 'فشل تحديث الحالة';

  @override
  String get senderWalletLabel => 'رقم المحفظة المحول منها';

  @override
  String get statusDepositConfirmed => 'تم تأكيد العربون';

  @override
  String get confirmDepositAction => 'تأكيد استلام العربون';

  @override
  String get navOrders => 'الطلبات';

  @override
  String get navProduction => 'التصنيع والورشة';

  @override
  String get productionTitle => 'التصنيع والورشة';

  @override
  String get totalUnitsRequired => 'إجمالي القطع المطلوبة';

  @override
  String get activeProductionOrders => 'أوردرات قيد التنفيذ';

  @override
  String get noProductionOrders => 'لا توجد أوردرات تصنيع معلقة حالياً';

  @override
  String get relatedOrders => 'الطلبات التابعة';

  @override
  String get shareProductionSummary => 'مشاركة أمر الشغل';

  @override
  String get productionSummaryHeader => 'أمر تشغيل الورشة';

  @override
  String get framedMirrors => 'مرايات بإطار';

  @override
  String get adhesiveMirrors => 'مرايات لصق دبل';

  @override
  String get filterWithShelf => 'مرايا برَف';
}
