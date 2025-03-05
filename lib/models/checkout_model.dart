import 'dart:convert';

class CheckoutModel {
  String? type;
  String? id;
  Attributes? attributes;
  Relationships? relationships;
  DataLinks? links;
  String? vehicleId;
  String? vin;
  int? pricingId;

  CheckoutModel({
    this.type,
    this.id,
    this.attributes,
    this.relationships,
    this.links,
    this.vehicleId,
    this.vin,
    this.pricingId,
  });

  CheckoutModel copyWith({
    String? type,
    String? id,
    Attributes? attributes,
    Relationships? relationships,
    DataLinks? links,
  }) =>
      CheckoutModel(
        type: type ?? this.type,
        id: id ?? this.id,
        attributes: attributes ?? this.attributes,
        relationships: relationships ?? this.relationships,
        links: links ?? this.links,
      );

  factory CheckoutModel.fromRawJson(String str) =>
      CheckoutModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
        type: json["type"],
        id: json["id"],
        attributes: json["data"]["attributes"] == null
            ? null
            : Attributes.fromJson(json["data"]["attributes"]),
        relationships: json["data"]["relationships"] == null
            ? null
            : Relationships.fromJson(json["data"]["relationships"]),
        links: json["data"]["links"] == null
            ? null
            : DataLinks.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        'pricingId': pricingId,
        if (vehicleId != null) 'vehicleId': vehicleId,
        if (vin != null) 'vin': vin,
      };
}

class Attributes {
  int? storeId;
  int? variantId;
  int? customPrice;
  ProductOptions? productOptions;
  CheckoutOptions? checkoutOptions;
  CheckoutData? checkoutData;
  bool? preview;
  dynamic expiresAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? testMode;
  String? url;

  Attributes({
    this.storeId,
    this.variantId,
    this.customPrice,
    this.productOptions,
    this.checkoutOptions,
    this.checkoutData,
    this.preview,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
    this.testMode,
    this.url,
  });

  Attributes copyWith({
    int? storeId,
    int? variantId,
    int? customPrice,
    ProductOptions? productOptions,
    CheckoutOptions? checkoutOptions,
    CheckoutData? checkoutData,
    bool? preview,
    dynamic expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? testMode,
    String? url,
  }) =>
      Attributes(
        storeId: storeId ?? this.storeId,
        variantId: variantId ?? this.variantId,
        customPrice: customPrice ?? this.customPrice,
        productOptions: productOptions ?? this.productOptions,
        checkoutOptions: checkoutOptions ?? this.checkoutOptions,
        checkoutData: checkoutData ?? this.checkoutData,
        preview: preview ?? this.preview,
        expiresAt: expiresAt ?? this.expiresAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        testMode: testMode ?? this.testMode,
        url: url ?? this.url,
      );

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        storeId: json["store_id"],
        variantId: json["variant_id"],
        customPrice: json["custom_price"],
        productOptions: json["product_options"] == null
            ? null
            : ProductOptions.fromJson(json["product_options"]),
        checkoutOptions: json["checkout_options"] == null
            ? null
            : CheckoutOptions.fromJson(json["checkout_options"]),
        checkoutData: json["checkout_data"] == null
            ? null
            : CheckoutData.fromJson(json["checkout_data"]),
        preview: json["preview"],
        expiresAt: json["expires_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        testMode: json["test_mode"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "variant_id": variantId,
        "custom_price": customPrice,
        "product_options": productOptions?.toJson(),
        "checkout_options": checkoutOptions?.toJson(),
        "checkout_data": checkoutData?.toJson(),
        "preview": preview,
        "expires_at": expiresAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "test_mode": testMode,
        "url": url,
      };
}

class CheckoutData {
  String? email;
  String? name;
  BillingAddress? billingAddress;
  String? taxNumber;
  String? discountCode;
  Custom? custom;
  List<dynamic>? variantQuantities;

  CheckoutData({
    this.email,
    this.name,
    this.billingAddress,
    this.taxNumber,
    this.discountCode,
    this.custom,
    this.variantQuantities,
  });

  CheckoutData copyWith({
    String? email,
    String? name,
    BillingAddress? billingAddress,
    String? taxNumber,
    String? discountCode,
    Custom? custom,
    List<dynamic>? variantQuantities,
  }) =>
      CheckoutData(
        email: email ?? this.email,
        name: name ?? this.name,
        billingAddress: billingAddress ?? this.billingAddress,
        taxNumber: taxNumber ?? this.taxNumber,
        discountCode: discountCode ?? this.discountCode,
        custom: custom ?? this.custom,
        variantQuantities: variantQuantities ?? this.variantQuantities,
      );

  factory CheckoutData.fromRawJson(String str) =>
      CheckoutData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckoutData.fromJson(Map<String, dynamic> json) => CheckoutData(
        email: json["email"],
        name: json["name"],
        billingAddress: json["billing_address"] == null
            ? null
            : BillingAddress.fromJson(json["billing_address"]),
        taxNumber: json["tax_number"],
        discountCode: json["discount_code"],
        custom: json["custom"] == null ? null : Custom.fromJson(json["custom"]),
        variantQuantities: json["variant_quantities"] == null
            ? []
            : List<dynamic>.from(json["variant_quantities"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "billing_address": billingAddress?.toJson(),
        "tax_number": taxNumber,
        "discount_code": discountCode,
        "custom": custom?.toJson(),
        "variant_quantities": variantQuantities == null
            ? []
            : List<dynamic>.from(variantQuantities!.map((x) => x)),
      };
}

class BillingAddress {
  String? country;

  BillingAddress({
    this.country,
  });

  BillingAddress copyWith({
    String? country,
  }) =>
      BillingAddress(
        country: country ?? this.country,
      );

  factory BillingAddress.fromRawJson(String str) =>
      BillingAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
      };
}

class Custom {
  String? vin;
  String? userId;
  String? paymentId;
  String? pricingId;
  String? vehicleId;

  Custom({
    this.vin,
    this.userId,
    this.paymentId,
    this.pricingId,
    this.vehicleId,
  });

  Custom copyWith({
    String? vin,
    String? userId,
    String? paymentId,
    String? pricingId,
    String? vehicleId,
  }) =>
      Custom(
        vin: vin ?? this.vin,
        userId: userId ?? this.userId,
        paymentId: paymentId ?? this.paymentId,
        pricingId: pricingId ?? this.pricingId,
        vehicleId: vehicleId ?? this.vehicleId,
      );

  factory Custom.fromRawJson(String str) => Custom.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Custom.fromJson(Map<String, dynamic> json) => Custom(
        vin: json["vin"],
        userId: json["user_id"],
        paymentId: json["payment_id"],
        pricingId: json["pricing_id"],
        vehicleId: json["vehicle_id"],
      );

  Map<String, dynamic> toJson() => {
        "vin": vin,
        "user_id": userId,
        "payment_id": paymentId,
        "pricing_id": pricingId,
        "vehicle_id": vehicleId,
      };
}

class CheckoutOptions {
  bool? embed;
  bool? media;
  bool? logo;
  bool? desc;
  bool? discount;
  bool? skipTrial;
  int? quantity;
  bool? subscriptionPreview;
  String? backgroundColor;
  String? headingsColor;
  String? primaryTextColor;
  String? secondaryTextColor;
  String? linksColor;
  String? bordersColor;
  String? checkboxColor;
  String? activeStateColor;
  String? buttonColor;
  String? buttonTextColor;
  String? termsPrivacyColor;

  CheckoutOptions({
    this.embed,
    this.media,
    this.logo,
    this.desc,
    this.discount,
    this.skipTrial,
    this.quantity,
    this.subscriptionPreview,
    this.backgroundColor,
    this.headingsColor,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.linksColor,
    this.bordersColor,
    this.checkboxColor,
    this.activeStateColor,
    this.buttonColor,
    this.buttonTextColor,
    this.termsPrivacyColor,
  });

  CheckoutOptions copyWith({
    bool? embed,
    bool? media,
    bool? logo,
    bool? desc,
    bool? discount,
    bool? skipTrial,
    int? quantity,
    bool? subscriptionPreview,
    String? backgroundColor,
    String? headingsColor,
    String? primaryTextColor,
    String? secondaryTextColor,
    String? linksColor,
    String? bordersColor,
    String? checkboxColor,
    String? activeStateColor,
    String? buttonColor,
    String? buttonTextColor,
    String? termsPrivacyColor,
  }) =>
      CheckoutOptions(
        embed: embed ?? this.embed,
        media: media ?? this.media,
        logo: logo ?? this.logo,
        desc: desc ?? this.desc,
        discount: discount ?? this.discount,
        skipTrial: skipTrial ?? this.skipTrial,
        quantity: quantity ?? this.quantity,
        subscriptionPreview: subscriptionPreview ?? this.subscriptionPreview,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        headingsColor: headingsColor ?? this.headingsColor,
        primaryTextColor: primaryTextColor ?? this.primaryTextColor,
        secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
        linksColor: linksColor ?? this.linksColor,
        bordersColor: bordersColor ?? this.bordersColor,
        checkboxColor: checkboxColor ?? this.checkboxColor,
        activeStateColor: activeStateColor ?? this.activeStateColor,
        buttonColor: buttonColor ?? this.buttonColor,
        buttonTextColor: buttonTextColor ?? this.buttonTextColor,
        termsPrivacyColor: termsPrivacyColor ?? this.termsPrivacyColor,
      );

  factory CheckoutOptions.fromRawJson(String str) =>
      CheckoutOptions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckoutOptions.fromJson(Map<String, dynamic> json) =>
      CheckoutOptions(
        embed: json["embed"],
        media: json["media"],
        logo: json["logo"],
        desc: json["desc"],
        discount: json["discount"],
        skipTrial: json["skip_trial"],
        quantity: json["quantity"],
        subscriptionPreview: json["subscription_preview"],
        backgroundColor: json["background_color"],
        headingsColor: json["headings_color"],
        primaryTextColor: json["primary_text_color"],
        secondaryTextColor: json["secondary_text_color"],
        linksColor: json["links_color"],
        bordersColor: json["borders_color"],
        checkboxColor: json["checkbox_color"],
        activeStateColor: json["active_state_color"],
        buttonColor: json["button_color"],
        buttonTextColor: json["button_text_color"],
        termsPrivacyColor: json["terms_privacy_color"],
      );

  Map<String, dynamic> toJson() => {
        "embed": embed,
        "media": media,
        "logo": logo,
        "desc": desc,
        "discount": discount,
        "skip_trial": skipTrial,
        "quantity": quantity,
        "subscription_preview": subscriptionPreview,
        "background_color": backgroundColor,
        "headings_color": headingsColor,
        "primary_text_color": primaryTextColor,
        "secondary_text_color": secondaryTextColor,
        "links_color": linksColor,
        "borders_color": bordersColor,
        "checkbox_color": checkboxColor,
        "active_state_color": activeStateColor,
        "button_color": buttonColor,
        "button_text_color": buttonTextColor,
        "terms_privacy_color": termsPrivacyColor,
      };
}

class ProductOptions {
  String? name;
  String? description;
  List<dynamic>? media;
  String? redirectUrl;
  String? receiptButtonText;
  String? receiptLinkUrl;
  String? receiptThankYouNote;
  List<dynamic>? enabledVariants;
  String? confirmationTitle;
  String? confirmationMessage;
  String? confirmationButtonText;

  ProductOptions({
    this.name,
    this.description,
    this.media,
    this.redirectUrl,
    this.receiptButtonText,
    this.receiptLinkUrl,
    this.receiptThankYouNote,
    this.enabledVariants,
    this.confirmationTitle,
    this.confirmationMessage,
    this.confirmationButtonText,
  });

  ProductOptions copyWith({
    String? name,
    String? description,
    List<dynamic>? media,
    String? redirectUrl,
    String? receiptButtonText,
    String? receiptLinkUrl,
    String? receiptThankYouNote,
    List<dynamic>? enabledVariants,
    String? confirmationTitle,
    String? confirmationMessage,
    String? confirmationButtonText,
  }) =>
      ProductOptions(
        name: name ?? this.name,
        description: description ?? this.description,
        media: media ?? this.media,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        receiptButtonText: receiptButtonText ?? this.receiptButtonText,
        receiptLinkUrl: receiptLinkUrl ?? this.receiptLinkUrl,
        receiptThankYouNote: receiptThankYouNote ?? this.receiptThankYouNote,
        enabledVariants: enabledVariants ?? this.enabledVariants,
        confirmationTitle: confirmationTitle ?? this.confirmationTitle,
        confirmationMessage: confirmationMessage ?? this.confirmationMessage,
        confirmationButtonText:
            confirmationButtonText ?? this.confirmationButtonText,
      );

  factory ProductOptions.fromRawJson(String str) =>
      ProductOptions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductOptions.fromJson(Map<String, dynamic> json) => ProductOptions(
        name: json["name"],
        description: json["description"],
        media: json["media"] == null
            ? []
            : List<dynamic>.from(json["media"]!.map((x) => x)),
        redirectUrl: json["redirect_url"],
        receiptButtonText: json["receipt_button_text"],
        receiptLinkUrl: json["receipt_link_url"],
        receiptThankYouNote: json["receipt_thank_you_note"],
        enabledVariants: json["enabled_variants"] == null
            ? []
            : List<dynamic>.from(json["enabled_variants"]!.map((x) => x)),
        confirmationTitle: json["confirmation_title"],
        confirmationMessage: json["confirmation_message"],
        confirmationButtonText: json["confirmation_button_text"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
        "redirect_url": redirectUrl,
        "receipt_button_text": receiptButtonText,
        "receipt_link_url": receiptLinkUrl,
        "receipt_thank_you_note": receiptThankYouNote,
        "enabled_variants": enabledVariants == null
            ? []
            : List<dynamic>.from(enabledVariants!.map((x) => x)),
        "confirmation_title": confirmationTitle,
        "confirmation_message": confirmationMessage,
        "confirmation_button_text": confirmationButtonText,
      };
}

class DataLinks {
  String? self;

  DataLinks({
    this.self,
  });

  DataLinks copyWith({
    String? self,
  }) =>
      DataLinks(
        self: self ?? this.self,
      );

  factory DataLinks.fromRawJson(String str) =>
      DataLinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataLinks.fromJson(Map<String, dynamic> json) => DataLinks(
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
      };
}

class Relationships {
  Store? store;
  Store? variant;

  Relationships({
    this.store,
    this.variant,
  });

  Relationships copyWith({
    Store? store,
    Store? variant,
  }) =>
      Relationships(
        store: store ?? this.store,
        variant: variant ?? this.variant,
      );

  factory Relationships.fromRawJson(String str) =>
      Relationships.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        variant:
            json["variant"] == null ? null : Store.fromJson(json["variant"]),
      );

  Map<String, dynamic> toJson() => {
        "store": store?.toJson(),
        "variant": variant?.toJson(),
      };
}

class Store {
  StoreLinks? links;

  Store({
    this.links,
  });

  Store copyWith({
    StoreLinks? links,
  }) =>
      Store(
        links: links ?? this.links,
      );

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        links:
            json["links"] == null ? null : StoreLinks.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "links": links?.toJson(),
      };
}

class StoreLinks {
  String? related;
  String? self;

  StoreLinks({
    this.related,
    this.self,
  });

  StoreLinks copyWith({
    String? related,
    String? self,
  }) =>
      StoreLinks(
        related: related ?? this.related,
        self: self ?? this.self,
      );

  factory StoreLinks.fromRawJson(String str) =>
      StoreLinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreLinks.fromJson(Map<String, dynamic> json) => StoreLinks(
        related: json["related"],
        self: json["self"],
      );

  Map<String, dynamic> toJson() => {
        "related": related,
        "self": self,
      };
}
