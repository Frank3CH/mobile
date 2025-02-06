import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Log in';

  @override
  String get seconnecter => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get motdepasseoulier => 'Forgot Password';

  @override
  String get rememberme => 'Remember Me';

  @override
  String get pendingOrders => 'Pending Orders';

  @override
  String get validatedOrders => 'Validated Orders (Delivery in Progress)';

  @override
  String get rejectedOrders => 'Rejected Orders';

  @override
  String get completedOrders => 'Completed Orders';

  @override
  String get detailscommandes => 'Order Details';

  @override
  String get quantity => 'Quantity';

  @override
  String get availabelquantity => 'Available Qauntity';

  @override
  String get order => 'Order';

  @override
  String get statut => 'Status';

  @override
  String get client => 'Customer';

  @override
  String get totalprice => 'Total Price';

  @override
  String get noactivity => 'No activity';

  @override
  String get total => 'Total';

  @override
  String get products => 'Products';

  @override
  String get listmed => 'Medicines List';

  @override
  String get nonotifcation => 'No notification';

  @override
  String get totalorder => 'Total Order';

  @override
  String get reference => 'Reference';

  @override
  String get details => 'Détails';

  @override
  String get date => 'Date';

  @override
  String get placeOrder => 'Place an Order';

  @override
  String get accountBalanceDetails => 'Account Balance Details';

  @override
  String get specification => 'Specification';

  @override
  String get logout => 'Logout';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirmlogout => 'Confirm Logout';

  @override
  String get questionlogout => 'Are you sure you want to logout?';

  @override
  String get price => 'prix';

  @override
  String get reduceQuantity => 'Reduce quantity';

  @override
  String get increaseQuantity => 'Increase quantity';

  @override
  String get invalidQuantity => 'Invalid quantity';

  @override
  String maxStockReached(Object maxQuantity) {
    return 'Stock maximum atteint : $maxQuantity';
  }

  @override
  String quantityNotAvailable(Object maxQuantity) {
    return 'Quantité non disponible. Maximum : $maxQuantity';
  }

  @override
  String get confirmDeletion => 'Confirm deletion';

  @override
  String get confirmDeletionMessage => 'Are you sure you want to remove this item from the cart?';

  @override
  String get delete => 'Delete';

  @override
  String get itemRemoved => 'Item removed from cart';

  @override
  String get deleteItem => 'Delete item';

  @override
  String get panier => 'Your Cart';

  @override
  String get yourorder => 'Your Order';

  @override
  String get command => 'Command';

  @override
  String get noorderfound => 'no Order Found';

  @override
  String get accept => 'Accept';

  @override
  String get reject => 'Reject';

  @override
  String get markasfinished => 'Mark As Finished';

  @override
  String get validatefailed => 'there is an error , Try again Later';

  @override
  String get rejectfailed => 'there is an error , Try again Later';

  @override
  String get backhome => 'Back Home';

  @override
  String get orderconf => 'Order Confirmation';

  @override
  String get selectquantity => 'Select Quantity';

  @override
  String get addtocart => 'Add to Cart';

  @override
  String get addedsccess => 'Added to cart successfully';

  @override
  String get rechercherproduct => 'Search products';

  @override
  String get rechercher => 'Search';

  @override
  String get noproductfound => 'No Product Found';

  @override
  String get detsoldecomptable => 'Détails Solde comptable';

  @override
  String get echeance => 'Due';

  @override
  String get orderref => 'Ref order';

  @override
  String get ordercreator => 'Order Creator';

  @override
  String get pendingOrder => 'Pending Order';

  @override
  String get validatedOrder => 'Validated Order';

  @override
  String get completedOrder => 'Completed Order';

  @override
  String get rejectedOrder => 'Rejected Order';

  @override
  String get solde => 'balance';

  @override
  String get mlMy_activity => 'My Activity';

  @override
  String get mlHistory => 'history';

  @override
  String get mltotal => 'All';

  @override
  String get mlinprogress => 'All';

  @override
  String get mlrefused => 'Refused';

  @override
  String get mlvalid => 'validated';

  @override
  String get mlclosed => 'closed';

  @override
  String get mlNotification => 'Notifications';

  @override
  String get options => 'Options';

  @override
  String get darkmode => 'DarkMode';
}
