import 'package:carpass/models/checkout_model.dart';
import 'package:carpass/models/custom_response.dart';
import 'package:carpass/models/pricing_model.dart';
import 'package:carpass/models/vehicle_model.dart';
import 'package:carpass/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class ReportRepository {
  final IntegrationAPI _api = IntegrationAPI();
  final _url = 'reports';

  Future<CustomResponse<List<VehicleModel>>> unlock(
      {required String vin, required String vehicleId}) async {
    return await _api
        .post('$_url/unlock', {'vin': vin, 'vehicleId': vehicleId}).then(
            (value) async {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        return CustomResponse(statusCode: value.statusCode, success: true);
      } else {
        return CustomResponse(
          success: false,
          statusCode: value.statusCode,
          message: value.data['message'],
        );
      }
    });
  }

  Future<CustomResponse<List<PricingModel>>?> getPricing() async {
    return await _api.get('/pricing').then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        return CustomResponse(
          data: value.data
              .map<PricingModel>((e) => PricingModel.fromJson(e))
              .toList(),
          success: true,
          statusCode: value.statusCode,
        );
      }
      return CustomResponse(
          data: null,
          success: false,
          statusCode: value.statusCode,
          message: value.data['message']);
    });
  }

  Future<CustomResponse<void>> checkout(
      {required CheckoutModel checkout}) async {
    print(checkout.toJson());
    return await _api
        .post('/payments/checkout', checkout.toJson())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        var model = CheckoutModel.fromJson(value.data);
        if (kIsWeb) {
          html.window.location.href = model.attributes!.url!;
        } else {
          final url = Uri.parse(model.attributes!.url!);
          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            throw 'No se pudo abrir la URL';
          }
        }

        return CustomResponse(
          data: null,
          success: true,
          statusCode: value.statusCode,
          message: value.data['message'],
        );
      }
      return CustomResponse(
        data: null,
        success: true,
        statusCode: value.statusCode,
        message: value.data['message'],
      );
    });
  }
}
