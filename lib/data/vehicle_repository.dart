import 'package:carpass/models/custom_response.dart';
import 'package:carpass/models/vehicle_model.dart';
import 'package:carpass/services/api_service.dart';

class VehicleRepository {
  final IntegrationAPI _api = IntegrationAPI();
  final _url = 'vehicles';

  Future<CustomResponse<List<VehicleModel>>> getAll() async {
    return await _api.get(_url).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        return CustomResponse(
            data: value.data["result"]
                .map<VehicleModel>((e) => VehicleModel.fromJson(e))
                .toList(),
            statusCode: value.statusCode,
            success: true);
      } else {
        return CustomResponse(
          success: false,
          statusCode: value.statusCode,
          message: value.data['message'],
        );
      }
    });
  }

  Future<CustomResponse<VehicleModel>> getById(String id) async {
    return await _api.get('$_url/$id').then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        return CustomResponse(
            data: VehicleModel.fromJson(value.data),
            success: true,
            statusCode: value.statusCode);
      }
      return CustomResponse(
          data: null,
          success: false,
          statusCode: value.statusCode,
          message: value.data['message']);
    });
  }
}
