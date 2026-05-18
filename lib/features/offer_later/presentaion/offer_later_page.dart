import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/offer_later/cubit/offer_later_cubit.dart';
import 'package:opsento_ats/features/offer_later/state/offer_later_state.dart';

class OfferLetterPage extends StatelessWidget {
  const OfferLetterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OfferLetterCubit(),
      child: BlocBuilder<OfferLetterCubit, OfferLetterState>(
        builder: (context, state) {
          final cubit = context.read<OfferLetterCubit>();

          return Scaffold(
            appBar: AppBar(title: const Text("Offer Letter Generator")),

            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ================= OFFER BOX =================
                  Container(
                    height: 200,
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        state.isGenerated
                            ? state.offerText
                            : "Offer Letter Preview will appear here...",
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ================= PACKAGE =================
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Package (CTC)",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: cubit.setPackage,
                  ),

                  const SizedBox(height: 12),

                  /// ================= REPORTING =================
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Reporting To",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: cubit.setReporting,
                  ),

                  const SizedBox(height: 12),

                  /// ================= LOCATION =================
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Location",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: cubit.setLocation,
                  ),

                  const SizedBox(height: 12),

                  /// ================= JOINING DATE =================
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Expected Joining Date",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: cubit.setJoiningDate,
                  ),

                  const SizedBox(height: 20),

                  /// ================= GENERATE BUTTON =================
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: cubit.generateOffer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Generate Offer Letter"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}