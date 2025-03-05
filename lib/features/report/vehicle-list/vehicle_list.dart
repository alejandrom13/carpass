import 'package:carpass/features/report/providers/vehicle_provider.dart';
import 'package:carpass/features/report/providers/user_provider.dart';
import 'package:carpass/models/vehicle_model.dart';
import 'package:carpass/theme/CustomIcons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VehicleList extends ConsumerWidget {
  const VehicleList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var vehicles = ref.watch(vehicleProvider);
    var user = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset('assets/logo.png', height: 25),
        actions: [
          user.when(
            data: (data) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                backgroundColor: Colors.white,
                label: Text(
                  '${data.credits} Créditos',
                  style: TextStyle(color: Color.fromRGBO(63, 183, 125, 1)),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    width: 1,
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                ),
              ),
            ),
            error: (error, stackTrace) => SizedBox.shrink(),
            loading: () => SizedBox.shrink(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Escribe un VIN',
                hintStyle: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(75, 75, 75, 1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color.fromRGBO(232, 232, 232, 1),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    CupertinoIcons.search,
                    size: 30,
                  ),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(CupertinoIcons.barcode_viewfinder),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.transparent)),
                    backgroundColor: Color.fromRGBO(243, 243, 243, 1),
                    label: Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Marca',
                            style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Icon(
                            Icons.expand_more_rounded,
                            size: 20,
                          ),
                        ],
                      ),
                    )),
                SizedBox(width: 10),
                Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.transparent)),
                    backgroundColor: Color.fromRGBO(243, 243, 243, 1),
                    label: Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Año',
                            style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Icon(
                            Icons.expand_more_rounded,
                            size: 20,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            vehicles.when(
              data: (data) => Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Color.fromRGBO(232, 232, 232, 1)),
                      ),
                      child: VehicleCard(
                          context: context, model: data[index], ref: ref),
                    );
                  },
                ),
              ),
              error: (error, stack) => Text(error.toString()),
              loading: () => Expanded(
                child: Skeletonizer(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) => VehicleCard(
                      context: context,
                      ref: ref,
                      model: VehicleModel(
                        isUnlock: true,
                        id: '0',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        manufacturer: '',
                        trim: '',
                        type: '',
                        plantCountry: '',
                        plantCity: '',
                        brand: 'Toyota',
                        model: 'Corolla',
                        year: 2010,
                        vin: 'KM8J33A46KU040279',
                        imageUrl:
                            'https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_001.jpg',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile VehicleCard(
      {required BuildContext context,
      required VehicleModel model,
      required ref}) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(232, 232, 232, 1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.network(model.imageUrl ??
            'https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_001.jpg'),
      ),
      title: Text('${model.brand} ${model.model} ${model.year}'.toUpperCase(),
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          )),
      subtitle: Text(model.vin.toUpperCase(),
          style: GoogleFonts.dmSans(
              fontSize: 11, color: Color.fromRGBO(75, 75, 75, 1))),
      trailing: SizedBox(
        // width: 80,
        child: ElevatedButton.icon(
          onPressed: () {
            ref.read(vehicleProvider.notifier).getById(model.id);
            context.go('/vehicle/view/${model.id}');
          },
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            backgroundColor: Color.fromRGBO(243, 243, 243, 1),
            // primary: Color.fromRGBO(0, 0, 0, 1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          label: Text('Ver',
              style: GoogleFonts.dmSans(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              )),
          icon: Icon(CustomIcons.eye, color: Colors.black),
        ),
      ),
    );
  }
}
