import 'app_localizations.dart';

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get hello => 'مرحبا';

  @override
  String get welcome => 'أهلاً وسهلاً';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get seconnecter => 'تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get motdepasseoulier => 'نسيت كلمة المرور';

  @override
  String get rememberme => 'تذكرني';

  @override
  String get pendingOrders => 'الطلبات المعلقة';

  @override
  String get validatedOrders => 'الطلبات المؤكدة (جارٍ التسليم)';

  @override
  String get rejectedOrders => 'الطلبات المرفوضة';

  @override
  String get completedOrders => 'الطلبات المكتملة';

  @override
  String get detailscommandes => 'تفاصيل الطلب';

  @override
  String get quantity => 'الكمية';

  @override
  String get availabelquantity => 'الكمية المتاحة';

  @override
  String get order => 'طلب';

  @override
  String get statut => 'الحالة';

  @override
  String get client => 'العميل';

  @override
  String get totalprice => 'السعر الإجمالي';

  @override
  String get noactivity => 'لا يوجد نشاط';

  @override
  String get total => 'الإجمالي';

  @override
  String get products => 'المنتجات';

  @override
  String get listmed => 'قائمة الأدوية';

  @override
  String get nonotifcation => 'لا توجد إشعارات';

  @override
  String get totalorder => 'إجمالي الطلبات';

  @override
  String get reference => 'المرجع';

  @override
  String get details => 'التفاصيل';

  @override
  String get date => 'التاريخ';

  @override
  String get placeOrder => 'إتمام الطلب';

  @override
  String get accountBalanceDetails => 'تفاصيل الرصيد المحاسبي';

  @override
  String get specification => 'المواصفات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirmlogout => 'تأكيد تسجيل الخروج';

  @override
  String get questionlogout => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get price => 'السعر';

  @override
  String get reduceQuantity => 'تقليل الكمية';

  @override
  String get increaseQuantity => 'زيادة الكمية';

  @override
  String get invalidQuantity => 'كمية غير صالحة';

  @override
  String maxStockReached(Object maxQuantity) {
    return 'تم الوصول إلى الحد الأقصى للمخزون: $maxQuantity';
  }

  @override
  String quantityNotAvailable(Object maxQuantity) {
    return 'الكمية غير متاحة. الحد الأقصى: $maxQuantity';
  }

  @override
  String get confirmDeletion => 'تأكيد الحذف';

  @override
  String get confirmDeletionMessage => 'هل أنت متأكد أنك تريد إزالة هذا العنصر من السلة؟';

  @override
  String get delete => 'حذف';

  @override
  String get itemRemoved => 'تمت إزالة العنصر من السلة';

  @override
  String get deleteItem => 'حذف العنصر';

  @override
  String get panier => 'سلة التسوق الخاصة بك';

  @override
  String get yourorder => 'طلبك';

  @override
  String get command => 'طلب';

  @override
  String get noorderfound => 'لم يتم العثور على طلب';

  @override
  String get accept => 'قبول';

  @override
  String get reject => 'رفض';

  @override
  String get markasfinished => 'وضع علامة كمكتمل';

  @override
  String get validatefailed => 'حدث خطأ، حاول مرة أخرى لاحقًا';

  @override
  String get rejectfailed => 'حدث خطأ، حاول مرة أخرى لاحقًا';

  @override
  String get backhome => 'العودة إلى الصفحة الرئيسية';

  @override
  String get orderconf => 'تأكيد الطلب';

  @override
  String get selectquantity => 'اختر الكمية';

  @override
  String get addtocart => 'إضافة إلى السلة';

  @override
  String get addedsccess => 'تمت الإضافة إلى السلة بنجاح';

  @override
  String get rechercherproduct => 'البحث عن المنتجات';

  @override
  String get rechercher => 'بحث';

  @override
  String get noproductfound => 'لم يتم العثور على منتج';

  @override
  String get detsoldecomptable => 'تفاصيل الرصيد المحاسبي';

  @override
  String get echeance => 'الاستحقاق';

  @override
  String get orderref => 'مرجع الطلب';

  @override
  String get ordercreator => 'منشئ الطلب';

  @override
  String get pendingOrder => 'الطلبات المعلقة';

  @override
  String get validatedOrder => 'الطلبات المصادق عليها';

  @override
  String get completedOrder => 'الطلبات المنجزة';

  @override
  String get rejectedOrder => 'الطلبات المرفوضة';

  @override
  String get solde => 'الرصيد';

  @override
  String get mlMy_activity => 'نشاطي التجاري';

  @override
  String get mlHistory => 'التاريخ';

  @override
  String get mltotal => 'الكل';

  @override
  String get mlinprogress => 'قيد التنفيذ';

  @override
  String get mlrefused => 'مرفوضة';

  @override
  String get mlvalid => 'مصادق عليه';

  @override
  String get mlclosed => 'مغلقة';

  @override
  String get mlNotification => 'إشعارات';

  @override
  String get options => 'خيارات';

  @override
  String get darkmode => 'الوضع المظلم';
}
