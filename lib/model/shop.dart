class Shop {
  final String imagePath;
  final String shopName;
  final String mail;
  final String about;

  const Shop({
    required this.imagePath,
    required this.shopName,
    required this.mail,
    required this.about, required shopUserName, required adressPhysique, required String shopID, required shopUserID, required phoneNumber, required String shopUrlImg,
  });

  get shopUserName => null;

  get shopUserID => null;

  get adressPhysique => null;

  get shopUrlImg => null;

   Shop copy({
    String? imagePath,
    String? shopName,
    String? mail,
    String? about,
   
  }) =>
      Shop(
        imagePath: imagePath ?? this.imagePath,
        shopName: shopName ?? this.shopName,
        mail: mail ?? this.mail,
        about: about ?? this.about, shopUserName: null, adressPhysique: null, shopID: '', shopUserID: null, phoneNumber: null, shopUrlImg: '',
       );


  static Shop fromJson(Map<String, dynamic> json) => Shop(
        imagePath: json['imagePath'],
        shopName: json['shopName'],
        mail: json['mail'],
        about: json['about'], shopUserName: null, adressPhysique: null, shopID: '', shopUserID: null, phoneNumber: null, shopUrlImg: '',
         
      );
  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'shopName': shopName,
        'mail': mail,
        'about': about,
      };
}
