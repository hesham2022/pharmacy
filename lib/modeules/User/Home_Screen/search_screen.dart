// create search page

import 'package:chefaa/modeules/User/Home_Screen/search_cubit/search_cubit.dart';
import 'package:chefaa/modeules/User/Home_Screen/search_cubit/state.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../Shared/components/components.dart';
import '../../../core/api_config/api_constants.dart';
import '../../../di/get_it.dart';
import '../../view_stores/store_details.dart';

class SearchPharmaciesPage extends StatefulWidget {
  const SearchPharmaciesPage({super.key});

  @override
  State<SearchPharmaciesPage> createState() => _SearchPharmaciesPageState();
}

class _SearchPharmaciesPageState extends State<SearchPharmaciesPage> {
  String searchTerm = '';
  void setSearchTerm(String term) {
    searchTerm = term;

    // setState(() {
    // });
  }

  final ScrollController _scrollController = ScrollController();

  late SearchPharmaciesCubit searchPharmaciesCubit;
  void initialzeCubit() {
    searchPharmaciesCubit = getIt<SearchPharmaciesCubit>();
  }

  late Position position;

  @override
  void initState() {
    initialzeCubit();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      position = value;
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        searchPharmaciesCubit.search(search: searchTerm);
      }
    });
    super.initState();
  }

  Widget searchBarWidget() {
    return TextFormField(
      onSaved: (newValue) {
        showAboutDialog(context: context);
      },
      onChanged: (value) {
        setSearchTerm(value);
        searchPharmaciesCubit.search(search: value, isNew: true);
      },
      decoration: InputDecoration(
        // close search button
        suffixIcon: IconButton(
          onPressed: () {
            setSearchTerm('');
            searchPharmaciesCubit.search(search: '');
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        contentPadding: const EdgeInsets.all(10.0),
        // isDense: true,
        // isCollapsed: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1),
        ),
        prefixIcon: const Icon(Icons.search),
        hintText: tr('search_for_job_company'),
        hintStyle: const TextStyle(
          color: Color(0xff818181),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      cursorColor: Colors.grey,
      cursorHeight: 16,
    );
  }

  String getPharmacyDistance(User user) {
    final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        (user.address!.coordinates[1]),
        (user.address!.coordinates[0]));
    return (distance / 1000).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchPharmaciesCubit>(
      create: (context) => searchPharmaciesCubit,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 40),
          child: Column(
            children: [
              // create search bar
              searchBarWidget(),

              Expanded(
                child: BlocBuilder<SearchPharmaciesCubit, GetpharmaciesState>(
                  builder: (context, state) {
                    if (state.status == GetpharmaciesPharmacies.error) {
                      return const Center(child: Text('Error'));
                    }
                    final pharmacies = state.pharmacies;
                    if (pharmacies.isEmpty &&
                        state.status == GetpharmaciesPharmacies.loaded)
                      return Center(child: Text('No Jobs Available'.tr()));
                    return RefreshIndicator(
                      onRefresh: () async {},
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        children: [
                          ...List.generate(
                            pharmacies.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      StoreDetails(
                                        pharmacyId: pharmacies[index].id,
                                      ));
                                },
                                child: Card(
                                  color: Colors.white,
                                  elevation: 1.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        getPhotoLink(
                                                            pharmacies[index]
                                                                .mainPhoto!)),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: TextSpan(
                                                      text: pharmacies[index]
                                                          .name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color: Colors.black)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  pharmacies[index]
                                                          .address!
                                                          .governorate +
                                                      ' / ' +
                                                      pharmacies[index]
                                                          .address!
                                                          .region,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                              ]),
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  color: Colors.grey[200],
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${getPharmacyDistance(pharmacies[index])}  ' +
                                                            ' كم ',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            fontSize: 13),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.location_pin,
                                                        color:
                                                            Color(0xff089BAB),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xfff6b921),
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  pharmacies[index]
                                                      .ratingsAverage
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (state.status == GetpharmaciesPharmacies.initial)
                            Container(
                                margin: EdgeInsets.only(bottom: 20),
                                alignment: Alignment.center,
                                child: Text('Search For Jobs'.tr()))
                          else if (state.reached)
                            Container(
                                margin: EdgeInsets.only(bottom: 20),
                                alignment: Alignment.center,
                                child: Text('No More Pharmacies'.tr()))
                          else
                            const Center(
                                child: Column(
                              children: [
                                CircularProgressIndicator(),
                              ],
                            )),
                        ],
                      ),
                    );
                  },
                ),
              )
              // create search result
            ],
          ),
        ),
      ),
    );
  }
}
