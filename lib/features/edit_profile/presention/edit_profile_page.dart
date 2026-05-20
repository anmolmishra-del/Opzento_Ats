import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/edit_profile_cubit.dart';
import '../state/edit_profile_state.dart';

class EditProfilePage
    extends StatefulWidget {

  const EditProfilePage({
    super.key,
  });

  @override
  State<EditProfilePage> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState
    extends State<EditProfilePage> {

  final nameController =
      TextEditingController();

  final roleController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final locationController =
      TextEditingController();

  final companyController =
      TextEditingController();

  final designationController =
      TextEditingController();

  final websiteController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (_) =>
          EditProfileCubit(),

      child: Scaffold(

        appBar: AppBar(
          title: const Text(
            "Edit Profile",
          ),
        ),

        body: BlocConsumer<
            EditProfileCubit,
            EditProfileState>(

          listener: (context, state) {

            if (state.status ==
                EditProfileStatus.success) {

              ScaffoldMessenger.of(context)
                  .showSnackBar(

                SnackBar(
                  content:
                      Text(state.message),
                ),
              );

              Navigator.pop(context);
            }

            if (state.status ==
                EditProfileStatus.error) {

              ScaffoldMessenger.of(context)
                  .showSnackBar(

                SnackBar(
                  content:
                      Text(state.message),
                ),
              );
            }
          },

          builder: (context, state) {

            final cubit =
                context.read<
                    EditProfileCubit>();

            return SingleChildScrollView(

              padding:
                  const EdgeInsets.all(20),

              child: Column(

                children: [

                  const SizedBox(height: 20),

                  Stack(
                    children: [

                      const CircleAvatar(
                        radius: 55,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),

                      Positioned(

                        bottom: 0,
                        right: 0,

                        child: Container(

                          padding:
                              const EdgeInsets.all(
                                  8),

                          decoration:
                              const BoxDecoration(
                            color:
                                Colors.deepPurple,
                            shape:
                                BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  buildField(
                    controller:
                        nameController,
                    label: "Name",
                    icon: Icons.person,
                  ),

                  buildField(
                    controller:
                        roleController,
                    label: "Role",
                    icon: Icons.work,
                  ),

                  buildField(
                    controller:
                        emailController,
                    label: "Email",
                    icon: Icons.email,
                  ),

                  buildField(
                    controller:
                        phoneController,
                    label: "Phone",
                    icon: Icons.phone,
                  ),

                  buildField(
                    controller:
                        locationController,
                    label: "Location",
                    icon:
                        Icons.location_on,
                  ),

                  buildField(
                    controller:
                        companyController,
                    label: "Company",
                    icon: Icons.business,
                  ),

                  buildField(
                    controller:
                        designationController,
                    label: "Designation",
                    icon: Icons.badge,
                  ),

                  buildField(
                    controller:
                        websiteController,
                    label: "Website",
                    icon: Icons.language,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(

                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(

                      onPressed: () {

                        cubit.saveProfile(

                          name:
                              nameController.text,

                          role:
                              roleController.text,

                          email:
                              emailController.text,

                          phone:
                              phoneController.text,

                          location:
                              locationController
                                  .text,

                          company:
                              companyController
                                  .text,

                          designation:
                              designationController
                                  .text,

                          website:
                              websiteController
                                  .text,
                        );
                      },

                      style:
                          ElevatedButton.styleFrom(

                        backgroundColor:
                            Colors.deepPurple,

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                                  16),
                        ),
                      ),

                      child:
                          state.status ==
                                  EditProfileStatus.loading

                              ? const CircularProgressIndicator(
                                  color:
                                      Colors.white,
                                )

                              : const Text(

                                  "Save Changes",

                                  style: TextStyle(
                                    color:
                                        Colors.white,
                                    fontSize: 17,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildField({

    required TextEditingController
        controller,

    required String label,

    required IconData icon,
  }) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child: TextField(

        controller: controller,

        decoration: InputDecoration(

          labelText: label,

          prefixIcon: Icon(icon),

          border:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
                    16),
          ),
        ),
      ),
    );
  }
}