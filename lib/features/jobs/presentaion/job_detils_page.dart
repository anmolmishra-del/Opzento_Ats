import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/my_applications/cubit/my_application_cubit.dart';
import 'package:opsento_ats/features/my_applications/presentaion/my_appication_page.dart';
import '../state/job_state.dart';
import 'create_job.dart';

class CreateJobdetailsPage extends StatelessWidget {

  final JobData job;
final bool isRecruiter;
  const CreateJobdetailsPage({
    super.key,
    required this.job,
    required this.isRecruiter
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,

        title: const Text(
          "Job Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),

        actions: [

          // IconButton(
          //   onPressed: () {},

          //   icon: const Icon(
          //     Icons.more_vert,
          //     color: Colors.black,
          //   ),
          // ),
        ],
      ),

     bottomNavigationBar: SafeArea(
       child: Container(
         padding: const EdgeInsets.all(16),
       
         decoration: BoxDecoration(
           // color: Colors.white,
       
           boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 10,
        ),
           ],
         ),
       
         child: isRecruiter
       
        // RECRUITER BUTTONS
        ? Row(
            children: [
       
              Expanded(
                child: ElevatedButton.icon(
       
                  onPressed: () {
       
                    Navigator.push(
                      context,
       
                      MaterialPageRoute(
                        builder: (_) =>
                            CreateJobPage(
                          job: job,
                          
                        ),
                      ),
                    );
                  },
       
                  icon: const Icon(
                    Icons.edit,
                  ),
       
                  label: const Text(
                    "Edit Job",
                  ),
       
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepPurple,
       
                    foregroundColor:
                        Colors.white,
       
                    elevation: 0,
       
                    minimumSize:
                        const Size(
                      double.infinity,
                      58,
                    ),
       
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              16),
                    ),
                  ),
                ),
              ),
       
              const SizedBox(width: 16),
       
              Expanded(
                child: OutlinedButton.icon(
       
                  onPressed: () {
       
                    Navigator.pop(context);
                  },
       
                  icon: const Icon(
                    Icons.close,
                  ),
       
                  label: const Text(
                    "Close Job",
                  ),
       
                  style:
                      OutlinedButton.styleFrom(
                    foregroundColor:
                        Colors.red,
       
                    side: const BorderSide(
                      color: Colors.red,
                    ),
       
                    minimumSize:
                        const Size(
                      double.infinity,
                      58,
                    ),
       
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              16),
                    ),
                  ),
                ),
              ),
            ],
          )
       
        // CANDIDATE BUTTON
        : ElevatedButton.icon(
       
            onPressed: () {
       
              final cubit =
                  context.read<
                      MyApplicationCubit>();
       
              cubit.applyJob(
                title: job.title,
      
                company:
                    job.department,
       
    type:
        job.type,
                experience:
                    job.experience,
       
                location:
                    job.location,
       
                salary:
                    job.salary,
       candidateName: 'shankar',
                status:
                    job.status,
              );
       
              Navigator.push(
                context,
       
                MaterialPageRoute(
                  builder: (_) =>
                      const MyApplicationPage(),
                ),
              );
            },
       
            icon: const Icon(
              Icons.send,
            ),
       
            label: const Text(
              "Apply Now",
            ),
       
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.deepPurple,
       
              foregroundColor:
                  Colors.white,
       
              elevation: 0,
       
              minimumSize:
                  const Size(
                double.infinity,
                58,
              ),
       
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                        16),
              ),
            ),
          ),
       ),
     ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
        
            // HEADER
            Container(
              padding: const EdgeInsets.all(10),
        
              decoration: BoxDecoration(
                color:
                    const Color(0xffF7F4FF),
        
                borderRadius:
                    const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
              ),
        
              child: Column(
                children: [
        
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
        
                    children: [
        
                     Column(
                       children: [
                         Container(
                         
                           height: 38,
                           width: 38,
                         
                           decoration: BoxDecoration(
                         
                             color:
                                 const Color(0xffEEEAFB),
                         
                             borderRadius:
                                 BorderRadius.circular(10),
                         
                             border: Border.all(
                               color: Colors.grey.shade300,
                             ),
                           ),
                         
                           child: const Icon(
                             Icons.work_outline,
                         
                             color: Color(0xff5B3FFF),
                         
                             size: 24,
                           ),
                         ),
                       ],
                     ),
                      const SizedBox(width: 18),
        
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
        
                          children: [
        
                            Text(
                              job.title,
        
                              style:
                                  const TextStyle(
                                fontSize: 25,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
        
                            const SizedBox(height: 6),
        
                            Text(
                              job.department,
        
                              style:
                                  const TextStyle(
                                color:
                                    Colors.deepPurple,
        
                                fontSize: 15,
        
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
        
                            // const SizedBox(height: 18),
        
//                             Row(
//                               children: [
        
//                                 Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.location_on,
//                                       size: 16,
//                                       color:
//                                           Colors.grey,
//                                     ),
//                                   ],
//                                 ),
        
//                                 const SizedBox(width: 4),
        
//                                Expanded(
//   child: Text(
//     job.location,

//     maxLines: 1,

//     overflow:
//         TextOverflow.ellipsis,

//     style: const TextStyle(
//       fontSize: 13,
//     ),
//   ),
// ),
//                               ],
//                             ),
        
                            // const SizedBox(height: 10),
        
                            Row(
                              children: [
        
                                const Icon(
                                  Icons.work_outline,
                                  size: 16,
                                  color:
                                      Colors.grey,
                                ),
        
                                const SizedBox(width: 4),
        
                                Text(
                                  job.experience,
        
            style: const TextStyle(
              fontSize: 13,
            ),
                                ),
        
                                const SizedBox(width: 24),
        
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.currency_rupee,
                                      size: 16,
                                      color:
                                          Colors.grey,
                                    ),
                                      const SizedBox(width: 6),
                                  ],
                                ),
        
                                // const SizedBox(width: 6),
        
                                Text(
                                  job.salary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
         Padding(
 padding:
      const EdgeInsets.only(
    left: 50,),           child: Row(
             crossAxisAlignment:
                   CrossAxisAlignment.start,
           
                                children: [
                   
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color:
                                            Colors.grey,
                                      ),
                                    ],
                                  ),
                   
                                  const SizedBox(width: 4),
                   
                                 Expanded(
             child: Text(
               job.location,
           
               maxLines: 3,
           
               overflow:
                   TextOverflow.ellipsis,
           
               style: const TextStyle(
                 fontSize: 13,
               ),
             ),
           ),
                                ],
                              ),
         ),
                  const SizedBox(height: 20),
Padding(
  padding: const EdgeInsets.only(left: 50),
  child: Row(
  
    // mainAxisAlignment:
    //     MainAxisAlignment.center,
  
    children: [
  
      _tag(job.type),
  
      const SizedBox(width: 12),
  
      _tag(job.status),
    ],
  ),
),
                ],
              ),
            ),
        
            Padding(
          padding: const EdgeInsets.all(10),
        
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
        
            children: [
        
              // JOB DESCRIPTION
              Container(
        
                width: double.infinity,
        
                padding:
          const EdgeInsets.all(10),
        
                decoration: BoxDecoration(
        
        borderRadius:
            BorderRadius.circular(
                10),
        
        border: Border.all(
          color:
              Colors.grey.shade300,
        ),
                ),
        
                child: Column(
        
        crossAxisAlignment:
            CrossAxisAlignment.start,
        
        children: [
        
          _title(
            "Job Description",
          ),
        
          const SizedBox(
              height: 10),
        
          Text(
            job.description,
        
            style:
                const TextStyle(
              fontSize: 16,
              height: 1.7,
            ),
          ),
        ],
                ),
              ),
        
              const SizedBox(height: 10),
        
              // RESPONSIBILITIES
              Container(
        
                width: double.infinity,
        
                padding:
          const EdgeInsets.all(10),
        
                decoration: BoxDecoration(
        
        borderRadius:
            BorderRadius.circular(
                10),
        
        border: Border.all(
          color:
              Colors.grey.shade300,
        ),
                ),
        
                child: Column(
        
        crossAxisAlignment:
            CrossAxisAlignment.start,
        
        children: [
        
          _title(
            "Responsibilities",
          ),
        
          const SizedBox(
              height: 18),
        
          ...job.responsibilities
              .map(
            (e) => _bullet(e),
          ),
        ],
                ),
              ),
        
              const SizedBox(height: 10),
        
              // REQUIREMENTS
              Container(
        
                width: double.infinity,
        
                padding:
          const EdgeInsets.all(10),
        
                decoration: BoxDecoration(
        
        borderRadius:
            BorderRadius.circular(
                10),
        
        border: Border.all(
          color:
              Colors.grey.shade300,
        ),
                ),
        
                child: Column(
        
        crossAxisAlignment:
            CrossAxisAlignment.start,
        
        children: [
        
          _title(
            "Requirements",
          ),
        
          const SizedBox(
              height: 18),
        
          ...job.requirements
              .map(
            (e) => _bullet(e),
          ),
        ],
                ),
              ),
            
        
                  const SizedBox(height: 12),
        
                  // Divider(
                  //   color: Colors.grey.shade300,
                  // ),
        
                  const SizedBox(height: 20),
        
                  _title("Job Details"),
        
                  const SizedBox(height: 14),
        
                  Row(
                    children: [
        
                      Expanded(
                        child: _detailCard(
                          Icons.business_center,
                          "Department",
                          job.department,
                        ),
                      ),
        
                      const SizedBox(width: 16),
        
                      Expanded(
                        child: _detailCard(
                          Icons.work,
                          "Experience",
                          job.experience,
                        ),
                      ),
                    ],
                  ),
        
                  const SizedBox(height: 20),
        
                  Row(
                    children: [
        
                      Expanded(
                        child: _detailCard(
                          Icons.location_on,
                          "Location",
                          job.location,
                        ),
                      ),
        
                      const SizedBox(width: 16),
        
                      Expanded(
                        child: _detailCard(
                          Icons.currency_rupee,
                          "Salary",
                          job.salary,
                        ),
                      ),
                    ],
                  ),
        
                  const SizedBox(height: 20),
        
                  Row(
                    children: [
        
                      Expanded(
                        child: _detailCard(
                          Icons.timer,
                          "Job Type",
                          job.type,
                        ),
                      ),
        
                      const SizedBox(width: 16),
        
                      Expanded(
                        child: _detailCard(
                          Icons.check_circle,
                          "Status",
                          job.status,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Text(
      text,

      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            "• ",

            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 18,
            ),
          ),

          Expanded(
            child: Text(
              text,

              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: Colors.green.shade100,

        borderRadius:
            BorderRadius.circular(5),
      ),

      child: Text(
        text,

        style: TextStyle(
          color: Colors.green.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

 Widget _detailCard(
  IconData icon,
  String title,
  String value,
) {

  return Container(

    width: double.infinity,

    padding:
        const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 14,
    ),

    decoration: BoxDecoration(

      borderRadius:
          BorderRadius.circular(14),

      border: Border.all(
        color: Colors.grey.shade300,
      ),

      color: Colors.white,
    ),

    child: Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Icon(
          icon,
          color: Colors.grey,
          size: 20,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,

                style: TextStyle(
                  color:
                      Colors.grey.shade600,

                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                value,

                style: const TextStyle(
                  fontWeight:
                      FontWeight.w500,

                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}