import 'dart:ui' as ui;

import 'package:chefaa/core/api_config/index.dart';
import 'package:chefaa/core/utils/map_utils/location_service.dart';
import 'package:chefaa/di/get_it.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/get_near_cubit.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/get_pharmacy_byuser_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Shared/icons.dart';
import '../../../Shared/theme/cubit/theme_cubit.dart';
import '../auth/domain/entities/user.dart';

class UserMapScreen extends StatefulWidget {
  const UserMapScreen({Key? key}) : super(key: key);

  @override
  State<UserMapScreen> createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {
  @override
  void initState() {
    super.initState();
  }

// declared method to get Images
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    print('data' + ' ' + data.toString());
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.isDark
                            ? Color.fromARGB(255, 23, 23, 23)
                            : Colors.grey[200],
                        hintText: 'lookFor'.tr(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: BlocBuilder<GetNearCubit, GetNearCubitState>(
                      builder: (context, state) {
                        if (state is GetNearCubitStateLoaded) {
                          return MapView(
                            pharmacies: [...state.users],
                          );
                        }

                        return SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            builder: (context, scrollController) =>
                BlocBuilder<GetNearCubit, GetNearCubitState>(
              builder: (context, state) {
                if (state is GetNearCubitStateLoaded) {
                  return Container(
                      color: Colors.white,
                      height: 300,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            ...[...state.users].map((e) => Container(
                                  color: Colors.grey[200],
                                  child: ListTile(
                                    title: Text(e.name.toString()),
                                    subtitle: Text(e.distance.toString()),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          getPhotoLink(e.mainPhoto!)),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ));
                }
                return Container(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              },
            ),
          )
        ],
      ),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({super.key, required this.pharmacies});
  final List<User> pharmacies;
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    print('data' + ' ' + data.toString());
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  final Set<Marker> _markers = {};

  @override
  void initState() {
    Future.wait(widget.pharmacies
            .map((e) async => Marker(
                // icon: BitmapDescriptor.fromBytes(await getImages(
                //     'assets/images/pharmacy-location.png', 130)),
                infoWindow: InfoWindow(
                    title: e.pharmacyName,
                    snippet: (e.distance! ~/ 1000).toString()),
                onTap: () {
                  showBottomSheet(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      context: context,
                      builder: (context) => PharmacyMapInfo(
                            user: e,
                          ));
                },
                position: LatLng(
                    e.address!.coordinates[1], e.address!.coordinates[0]),
                markerId: MarkerId(e.id)))
            .toSet())
        .then((value) {
      setState(() {
        _markers.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        onMapCreated: (c) {},
        markers: _markers,
        initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(LocationService.position!.latitude,
                LocationService.position!.longitude)));
  }
}

class PharmacyMapInfo extends StatefulWidget {
  const PharmacyMapInfo({super.key, required this.user});
  final User user;

  @override
  State<PharmacyMapInfo> createState() => _PharmacyMapInfoState();
}

class _PharmacyMapInfoState extends State<PharmacyMapInfo> {
  late GetPharmacyByUserCubit cubit;
  @override
  void initState() {
    cubit = getIt();
    cubit.getPharmacyByUser(widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetPharmacyByUserCubit>.value(
      value: cubit,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: BlocConsumer<GetPharmacyByUserCubit, GetPharmacyByUserState>(
          listener: (context, state) {
            if (state is GetPharmacyByUserStateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error.errorMessege)));
            }
          },
          buildWhen: (previous, current) =>
              current is GetPharmacyByUserStateLoaded,
          builder: (context, state) {
            if (state is GetPharmacyByUserStateLoaded)
              return Column(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                getPhotoLink(widget.user.mainPhoto!)))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Text(
                          widget.user.pharmacyName!,
                          style: TextStyle(
                              color: Color(0xff089BAB),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text((state.user.followCount ?? 0).toString()),
                          Text(
                            'Followers',
                            style: TextStyle(color: Colors.grey[500]),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is GetPharmacyByUserStateLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            if (state.user.isFollowed!)
                              cubit.unfollowPharmacy(widget.user.id);
                            else
                              cubit.followPharmacy(widget.user.id);
                          },
                          child: Text(
                            state.user.isFollowed!
                                ? 'un follow'
                                : 'follow'.tr(),
                            style: TextStyle(
                                color: !state.user.isFollowed!
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 12),
                          ),
                          color: !state.user.isFollowed!
                              ? Color(0xffcce7ea)
                              : Color(0xff089BAB),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minWidth: 100,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'msg'.tr(),
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          color: Color(0xffcce7ea),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minWidth: 100,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'contact'.tr(),
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          color: Color(0xffcce7ea),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minWidth: 100,
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 15,
                    width: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Location,
                          color: Color(0xff089BAB),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'address'.tr(),
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget.user.hours24 != null &&
                      widget.user.hours24 == true)
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Time_Circle,
                            color: Color(0xff089BAB),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'work24'.tr(),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                ],
              );
            // if (state is GetPharmacyByUserStateLoading)
            // return Center(
            //   child: CircularProgressIndicator(),
            // );
            if (state is GetPharmacyByUserStateErrorFirstTime)
              return Center(
                child: Text(state.error.errorMessege),
              );
            return SizedBox();
          },
        ),
      ),
    );
  }
}
