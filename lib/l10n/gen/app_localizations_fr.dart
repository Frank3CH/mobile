import 'app_localizations.dart';

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get welcome => 'Welcome !';

  @override
  String get login => 'Connexion';

  @override
  String get seconnecter => 'Se Conneceter';

  @override
  String get email => 'username';

  @override
  String get password => 'Mot de Passe';

  @override
  String get motdepasseoulier => 'Mot de passe Oublié';

  @override
  String get rememberme => 'Se Souvenir de Moi';

  @override
  String get pendingOrders => 'Commandes en attente';

  @override
  String get validatedOrders => 'Commandes validées (livraison en cours)';

  @override
  String get rejectedOrders => 'Commandes refusées';

  @override
  String get completedOrders => 'Commandes Terminées';

  @override
  String get detailscommandes => 'Détails de votre Commande';

  @override
  String get quantity => 'Quantité';

  @override
  String get availabelquantity => 'Quantité Disponible';

  @override
  String get order => 'Commande';

  @override
  String get statut => 'Statut';

  @override
  String get client => 'Client';

  @override
  String get totalprice => 'Prix Total';

  @override
  String get noactivity => 'Aucune activité';

  @override
  String get total => 'Total';

  @override
  String get products => 'Produits';

  @override
  String get listmed => 'Liste des medicaments';

  @override
  String get nonotifcation => 'Aucune notification';

  @override
  String get totalorder => 'Commande total';

  @override
  String get reference => 'Réference';

  @override
  String get details => 'Détails';

  @override
  String get date => 'Date';

  @override
  String get placeOrder => 'Passer une commande';

  @override
  String get accountBalanceDetails => 'Détails Solde Comptable';

  @override
  String get specification => 'Spécification';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirmlogout => 'Confirmer Déconnexion';

  @override
  String get questionlogout => 'Voulez vous vous déconnecter?';

  @override
  String get price => 'Prix';

  @override
  String get reduceQuantity => 'Réduire la quantité';

  @override
  String get increaseQuantity => 'Augmenter la quantité';

  @override
  String get invalidQuantity => 'Quantité invalide';

  @override
  String maxStockReached(Object maxQuantity) {
    return 'Stock maximum atteint : $maxQuantity';
  }

  @override
  String quantityNotAvailable(Object maxQuantity) {
    return 'Quantité non disponible. Maximum : $maxQuantity';
  }

  @override
  String get confirmDeletion => 'Confirmer la suppression';

  @override
  String get confirmDeletionMessage => 'Voulez-vous vraiment supprimer cet article du panier ?';

  @override
  String get delete => 'Supprimer';

  @override
  String get itemRemoved => 'Article supprimé du panier';

  @override
  String get deleteItem => 'Supprimer l\'article';

  @override
  String get panier => 'Votre Panier';

  @override
  String get yourorder => 'Votre Commande';

  @override
  String get command => 'Commandez';

  @override
  String get noorderfound => 'Aucune Commande Trouvée';

  @override
  String get accept => 'Accepter';

  @override
  String get reject => 'Rejeter';

  @override
  String get markasfinished => 'Marquer comme terminée';

  @override
  String get validatefailed => 'une erreur est survenue , Réessayer Plus Tard';

  @override
  String get rejectfailed => 'une erreur est survenue , Réessayer Plus Tard';

  @override
  String get backhome => 'Retour a l\'accueil';

  @override
  String get orderconf => 'Confirmation de la commande';

  @override
  String get selectquantity => 'Selectionner la Quantité';

  @override
  String get addtocart => 'Ajouter au panier';

  @override
  String get addedsccess => 'Ajout avec Succés';

  @override
  String get rechercherproduct => 'Rechercher produits';

  @override
  String get rechercher => 'Rechercher';

  @override
  String get noproductfound => 'Aucun produit trouvé';

  @override
  String get detsoldecomptable => 'Détails Solde comptable';

  @override
  String get echeance => 'Échéance';

  @override
  String get orderref => 'Ref Commande';

  @override
  String get ordercreator => 'Createur de Commande';

  @override
  String get pendingOrder => 'Commande en attente';

  @override
  String get validatedOrder => 'Commande validée';

  @override
  String get completedOrder => 'Commande terminée';

  @override
  String get rejectedOrder => 'Commande refusée';

  @override
  String get solde => 'Solde';

  @override
  String get mlMy_activity => 'Mon Activité';

  @override
  String get mlHistory => 'Historique';

  @override
  String get mltotal => 'Toutes';

  @override
  String get mlinprogress => 'en cours';

  @override
  String get mlrefused => 'Refusé';

  @override
  String get mlvalid => 'validé';

  @override
  String get mlclosed => 'Terminé';

  @override
  String get mlNotification => 'Notifications';

  @override
  String get options => 'Options';

  @override
  String get darkmode => 'DarkMode';
}
