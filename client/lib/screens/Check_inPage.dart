import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({Key? key}) : super(key: key);

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};

  String currentAddress = 'My Address';
  Position? currentposition;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress =
            "${place.locality},${place.subAdministrativeArea},${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.arrow_circle_down_sharp,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Clock In",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: MediaQuery.of(context)
                    .size
                    .width, // or use fixed size like 200
                height: MediaQuery.of(context).size.height / 2,
                child: GoogleMap(
                  initialCameraPosition: initialCameraPosition,
                  markers: markers,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController = controller;
                  },
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                      Expanded(
                        child: Text(
                          currentAddress,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
              currentposition != null
                  ? Text(
                      'Latitude = ' + currentposition!.latitude.toString(),
                    )
                  : Container(),
              currentposition != null
                  ? Text(
                      'Longitude = ' + currentposition!.longitude.toString(),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Entry Time: ${DateTime.now()}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      primary: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Position position = await _determinePosition();
                      googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 14)));
                      markers.clear();
                      markers.add(Marker(
                          markerId: const MarkerId('currentLocation'),
                          position:
                              LatLng(position.latitude, position.longitude)));

                      setState(() {});
                    },
                    child: const Icon(
                      Icons.my_location_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      primary: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[800],
                    padding: const EdgeInsets.all(14)),
                child: const Text("Mark Entry"),
                onPressed: () {},
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
