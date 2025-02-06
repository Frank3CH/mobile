import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @hello.
  ///
  /// In fr, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @welcome.
  ///
  /// In fr, this message translates to:
  /// **'Welcome !'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get login;

  /// No description provided for @seconnecter.
  ///
  /// In fr, this message translates to:
  /// **'Se Conneceter'**
  String get seconnecter;

  /// No description provided for @email.
  ///
  /// In fr, this message translates to:
  /// **'username'**
  String get email;

  /// No description provided for @password.
  ///
  /// In fr, this message translates to:
  /// **'Mot de Passe'**
  String get password;

  /// No description provided for @motdepasseoulier.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe Oublié'**
  String get motdepasseoulier;

  /// No description provided for @rememberme.
  ///
  /// In fr, this message translates to:
  /// **'Se Souvenir de Moi'**
  String get rememberme;

  /// No description provided for @pendingOrders.
  ///
  /// In fr, this message translates to:
  /// **'Commandes en attente'**
  String get pendingOrders;

  /// No description provided for @validatedOrders.
  ///
  /// In fr, this message translates to:
  /// **'Commandes validées (livraison en cours)'**
  String get validatedOrders;

  /// No description provided for @rejectedOrders.
  ///
  /// In fr, this message translates to:
  /// **'Commandes refusées'**
  String get rejectedOrders;

  /// No description provided for @completedOrders.
  ///
  /// In fr, this message translates to:
  /// **'Commandes Terminées'**
  String get completedOrders;

  /// No description provided for @detailscommandes.
  ///
  /// In fr, this message translates to:
  /// **'Détails de votre Commande'**
  String get detailscommandes;

  /// No description provided for @quantity.
  ///
  /// In fr, this message translates to:
  /// **'Quantité'**
  String get quantity;

  /// No description provided for @availabelquantity.
  ///
  /// In fr, this message translates to:
  /// **'Quantité Disponible'**
  String get availabelquantity;

  /// No description provided for @order.
  ///
  /// In fr, this message translates to:
  /// **'Commande'**
  String get order;

  /// No description provided for @statut.
  ///
  /// In fr, this message translates to:
  /// **'Statut'**
  String get statut;

  /// No description provided for @client.
  ///
  /// In fr, this message translates to:
  /// **'Client'**
  String get client;

  /// No description provided for @totalprice.
  ///
  /// In fr, this message translates to:
  /// **'Prix Total'**
  String get totalprice;

  /// No description provided for @noactivity.
  ///
  /// In fr, this message translates to:
  /// **'Aucune activité'**
  String get noactivity;

  /// No description provided for @total.
  ///
  /// In fr, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @products.
  ///
  /// In fr, this message translates to:
  /// **'Produits'**
  String get products;

  /// No description provided for @listmed.
  ///
  /// In fr, this message translates to:
  /// **'Liste des medicaments'**
  String get listmed;

  /// No description provided for @nonotifcation.
  ///
  /// In fr, this message translates to:
  /// **'Aucune notification'**
  String get nonotifcation;

  /// No description provided for @totalorder.
  ///
  /// In fr, this message translates to:
  /// **'Commande total'**
  String get totalorder;

  /// No description provided for @reference.
  ///
  /// In fr, this message translates to:
  /// **'Réference'**
  String get reference;

  /// No description provided for @details.
  ///
  /// In fr, this message translates to:
  /// **'Détails'**
  String get details;

  /// No description provided for @date.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @placeOrder.
  ///
  /// In fr, this message translates to:
  /// **'Passer une commande'**
  String get placeOrder;

  /// No description provided for @accountBalanceDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails Solde Comptable'**
  String get accountBalanceDetails;

  /// No description provided for @specification.
  ///
  /// In fr, this message translates to:
  /// **'Spécification'**
  String get specification;

  /// No description provided for @logout.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @confirmlogout.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer Déconnexion'**
  String get confirmlogout;

  /// No description provided for @questionlogout.
  ///
  /// In fr, this message translates to:
  /// **'Voulez vous vous déconnecter?'**
  String get questionlogout;

  /// No description provided for @price.
  ///
  /// In fr, this message translates to:
  /// **'Prix'**
  String get price;

  /// No description provided for @reduceQuantity.
  ///
  /// In fr, this message translates to:
  /// **'Réduire la quantité'**
  String get reduceQuantity;

  /// No description provided for @increaseQuantity.
  ///
  /// In fr, this message translates to:
  /// **'Augmenter la quantité'**
  String get increaseQuantity;

  /// No description provided for @invalidQuantity.
  ///
  /// In fr, this message translates to:
  /// **'Quantité invalide'**
  String get invalidQuantity;

  /// No description provided for @maxStockReached.
  ///
  /// In fr, this message translates to:
  /// **'Stock maximum atteint : {maxQuantity}'**
  String maxStockReached(Object maxQuantity);

  /// No description provided for @quantityNotAvailable.
  ///
  /// In fr, this message translates to:
  /// **'Quantité non disponible. Maximum : {maxQuantity}'**
  String quantityNotAvailable(Object maxQuantity);

  /// No description provided for @confirmDeletion.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer la suppression'**
  String get confirmDeletion;

  /// No description provided for @confirmDeletionMessage.
  ///
  /// In fr, this message translates to:
  /// **'Voulez-vous vraiment supprimer cet article du panier ?'**
  String get confirmDeletionMessage;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @itemRemoved.
  ///
  /// In fr, this message translates to:
  /// **'Article supprimé du panier'**
  String get itemRemoved;

  /// No description provided for @deleteItem.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'article'**
  String get deleteItem;

  /// No description provided for @panier.
  ///
  /// In fr, this message translates to:
  /// **'Votre Panier'**
  String get panier;

  /// No description provided for @yourorder.
  ///
  /// In fr, this message translates to:
  /// **'Votre Commande'**
  String get yourorder;

  /// No description provided for @command.
  ///
  /// In fr, this message translates to:
  /// **'Commandez'**
  String get command;

  /// No description provided for @noorderfound.
  ///
  /// In fr, this message translates to:
  /// **'Aucune Commande Trouvée'**
  String get noorderfound;

  /// No description provided for @accept.
  ///
  /// In fr, this message translates to:
  /// **'Accepter'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In fr, this message translates to:
  /// **'Rejeter'**
  String get reject;

  /// No description provided for @markasfinished.
  ///
  /// In fr, this message translates to:
  /// **'Marquer comme terminée'**
  String get markasfinished;

  /// No description provided for @validatefailed.
  ///
  /// In fr, this message translates to:
  /// **'une erreur est survenue , Réessayer Plus Tard'**
  String get validatefailed;

  /// No description provided for @rejectfailed.
  ///
  /// In fr, this message translates to:
  /// **'une erreur est survenue , Réessayer Plus Tard'**
  String get rejectfailed;

  /// No description provided for @backhome.
  ///
  /// In fr, this message translates to:
  /// **'Retour a l\'accueil'**
  String get backhome;

  /// No description provided for @orderconf.
  ///
  /// In fr, this message translates to:
  /// **'Confirmation de la commande'**
  String get orderconf;

  /// No description provided for @selectquantity.
  ///
  /// In fr, this message translates to:
  /// **'Selectionner la Quantité'**
  String get selectquantity;

  /// No description provided for @addtocart.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter au panier'**
  String get addtocart;

  /// No description provided for @addedsccess.
  ///
  /// In fr, this message translates to:
  /// **'Ajout avec Succés'**
  String get addedsccess;

  /// No description provided for @rechercherproduct.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher produits'**
  String get rechercherproduct;

  /// No description provided for @rechercher.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get rechercher;

  /// No description provided for @noproductfound.
  ///
  /// In fr, this message translates to:
  /// **'Aucun produit trouvé'**
  String get noproductfound;

  /// No description provided for @detsoldecomptable.
  ///
  /// In fr, this message translates to:
  /// **'Détails Solde comptable'**
  String get detsoldecomptable;

  /// No description provided for @echeance.
  ///
  /// In fr, this message translates to:
  /// **'Échéance'**
  String get echeance;

  /// No description provided for @orderref.
  ///
  /// In fr, this message translates to:
  /// **'Ref Commande'**
  String get orderref;

  /// No description provided for @ordercreator.
  ///
  /// In fr, this message translates to:
  /// **'Createur de Commande'**
  String get ordercreator;

  /// No description provided for @pendingOrder.
  ///
  /// In fr, this message translates to:
  /// **'Commande en attente'**
  String get pendingOrder;

  /// No description provided for @validatedOrder.
  ///
  /// In fr, this message translates to:
  /// **'Commande validée'**
  String get validatedOrder;

  /// No description provided for @completedOrder.
  ///
  /// In fr, this message translates to:
  /// **'Commande terminée'**
  String get completedOrder;

  /// No description provided for @rejectedOrder.
  ///
  /// In fr, this message translates to:
  /// **'Commande refusée'**
  String get rejectedOrder;

  /// No description provided for @solde.
  ///
  /// In fr, this message translates to:
  /// **'Solde'**
  String get solde;

  /// No description provided for @mlMy_activity.
  ///
  /// In fr, this message translates to:
  /// **'Mon Activité'**
  String get mlMy_activity;

  /// No description provided for @mlHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get mlHistory;

  /// No description provided for @mltotal.
  ///
  /// In fr, this message translates to:
  /// **'Toutes'**
  String get mltotal;

  /// No description provided for @mlinprogress.
  ///
  /// In fr, this message translates to:
  /// **'en cours'**
  String get mlinprogress;

  /// No description provided for @mlrefused.
  ///
  /// In fr, this message translates to:
  /// **'Refusé'**
  String get mlrefused;

  /// No description provided for @mlvalid.
  ///
  /// In fr, this message translates to:
  /// **'validé'**
  String get mlvalid;

  /// No description provided for @mlclosed.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get mlclosed;

  /// No description provided for @mlNotification.
  ///
  /// In fr, this message translates to:
  /// **'Notifications'**
  String get mlNotification;

  /// No description provided for @options.
  ///
  /// In fr, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @darkmode.
  ///
  /// In fr, this message translates to:
  /// **'DarkMode'**
  String get darkmode;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
