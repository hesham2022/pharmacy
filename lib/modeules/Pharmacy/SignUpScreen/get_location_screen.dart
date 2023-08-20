import 'package:chefaa/di/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../User/auth/domain/entities/sign_provider_params.dart';
import '../../User/auth/presentation/blocs/login_bloc/login_bloc.dart';
import '../../User/auth/presentation/blocs/login_bloc/login_event.dart';
import '../../User/auth/presentation/blocs/login_bloc/login_state.dart';
import 'ccity_model.dart';

class GetLocationScreen extends StatefulWidget {
  const GetLocationScreen(
      {Key? key, required this.city, required this.registerProvideParams})
      : super(key: key);
  final City city;
  final RegisterProviderParams registerProvideParams;
  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  Set<Marker> markers = <Marker>{};
  late LatLng latLng;
  @override
  void initState() {
    markers.add(Marker(
        markerId: MarkerId('select_locations'),
        position: LatLng(
            double.parse(widget.city.lat!), double.parse(widget.city.lng!))));
    latLng =
        LatLng(double.parse(widget.city.lat!), double.parse(widget.city.lng!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingUpBProviderloc>(
      create: (context) => getIt(),
      child: Scaffold(
        body: BlocConsumer<SingUpBProviderloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure)
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
          },
          builder: (context, state) {
            return Column(children: [
              Expanded(
                  child: GoogleMap(
                      markers: markers,
                      onCameraMove: (position) {
                        setState(() {
                          markers.add(Marker(
                              markerId: MarkerId('select_locations'),
                              position: LatLng(position.target.latitude,
                                  position.target.longitude)));
                          latLng = LatLng(position.target.latitude,
                              position.target.longitude);
                        });
                      },
                      initialCameraPosition: CameraPosition(
                          zoom: 12,
                          target: LatLng(double.parse(widget.city.lat!),
                              double.parse(widget.city.lng!))))),
              if (state is LoginLoading)
                Center(child: CircularProgressIndicator())
              else
                MaterialButton(
                  onPressed: () {
                    context.read<SingUpBProviderloc>().add(
                            LoginProviderSubmitted(widget.registerProvideParams
                                .copyWith(
                                    address: widget
                                        .registerProvideParams.address
                                        .copyWith(coordinates: [
                          latLng.longitude,
                          latLng.latitude
                        ]))));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFF089bab),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
            ]);
          },
        ),
      ),
    );
  }
}
