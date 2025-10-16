import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/features/order_details/data/models/info_model.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/custom_card_address.dart';
import 'package:tracking_app/features/order_details/presentation/widgets/info_card_address.dart';
import 'package:tracking_app/features/pick_up_location/presentation/cubit/pick_up_location_cubit.dart';
import 'package:tracking_app/features/pick_up_location/presentation/cubit/pick_up_location_states.dart';

class PickUpLocationView extends StatelessWidget {
  const PickUpLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments
            as Map<String, dynamic>? ??
        {};

    return BlocProvider(
      create: (context) =>
          getIt<PickUpLocationCubit>()
            ..initializeLocation(),
      child: PickUpLocationViewBody(args: args),
    );
  }
}

class PickUpLocationViewBody extends StatelessWidget {
  const PickUpLocationViewBody({
    super.key,
    required this.args,
  });

  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    debugPrint('🔍 PickUpLocationViewBody - Args: $args');

    return Scaffold(
      body:
          BlocConsumer<
            PickUpLocationCubit,
            PickUpLocationStates
          >(
            listener: (context, state) {
              debugPrint(
                '🔍 State changed: ${state.runtimeType}',
              );
              if (state is PickUpLocationError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: AppColors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              debugPrint(
                '🔍 Current state in builder: ${state.runtimeType}',
              );
              return Stack(
                children: [
                  // Google Map
                  _buildMap(state, context),

                  // App Bar
                  _buildAppBar(context),

                  // Bottom Sheet
                  if (state is PickUpLocationSuccess)
                    _buildBottomSheet(
                      context,
                      state,
                      args,
                    ),

                  // Loading indicator
                  if (state is PickUpLocationLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.pink,
                      ),
                    ),
                ],
              );
            },
          ),
    );
  }

  Widget _buildMap(
    PickUpLocationStates state,
    BuildContext context,
  ) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(
          31.241263060169246,
          29.967028692169325,
        ), // Flowery location
        zoom: 14.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        context
            .read<PickUpLocationCubit>()
            .setMapController(controller);
      },
      markers: state is PickUpLocationSuccess
          ? state.markers
          : {},
      polylines: state is PickUpLocationSuccess
          ? state.polylines
          : {},
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.pink,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            CupertinoIcons.back,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(
    BuildContext context,
    PickUpLocationSuccess state,
    Map<String, dynamic> args,
  ) {
    // Debug logging
    debugPrint('🔍 Bottom Sheet - Args received: $args');
    debugPrint(
      '🔍 Bottom Sheet - infoModels key exists: ${args.containsKey("infoModels")}',
    );
    debugPrint(
      '🔍 Bottom Sheet - selectedIndex: ${args["selectedIndex"]}',
    );

    final List<InfoModel>? infoModels =
        args["infoModels"] as List<InfoModel>?;
    final int selectedIndex =
        args["selectedIndex"] as int? ?? 0;

    debugPrint(
      '🔍 Bottom Sheet - infoModels is null: ${infoModels == null}',
    );
    debugPrint(
      '🔍 Bottom Sheet - infoModels length: ${infoModels?.length}',
    );

    // Show error message if no data
    if (infoModels == null || infoModels.isEmpty) {
      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: const Text(
            'No location data available',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.pink,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            20.heightBox,

            // Show the selected card first
            if (selectedIndex == 0) ...[
              // Store/Flower card first
              const Text(
                "Pickup Address",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              InfoCardAddress(
                infoModel: infoModels[0], // Store info
              ),
              20.heightBox,
              const Text(
                "User Address",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              if (infoModels.length > 1)
                InfoCardAddress(
                  infoModel: infoModels[1], // User info
                ),
            ] else ...[
              // User card first
              const Text(
                "User Address",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              if (infoModels.length > 1)
                InfoCardAddress(
                  infoModel: infoModels[1], // User info
                ),
              20.heightBox,
              const Text(
                "Pickup Address",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              InfoCardAddress(
                infoModel: infoModels[0], // Store info
              ),
            ],

            20.heightBox,
          ],
        ),
      ),
    );
  }
}
