import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/jobs/cubit/job_cubit.dart';
import 'package:opsento_ats/features/jobs/state/job_state.dart';

class CreateJobPage
    extends StatefulWidget {

  final JobData? job;

  const CreateJobPage({
    super.key,
    this.job,
  });

  @override
  State<CreateJobPage> createState() =>
      _CreateJobPageState();
}
class _CreateJobPageState
    extends State<CreateJobPage> {

  final title = TextEditingController();
  final dept = TextEditingController();
  final exp = TextEditingController();
  final loc = TextEditingController();
  final sal = TextEditingController();
final stat = TextEditingController();
final count = TextEditingController();
<<<<<<< HEAD
final primarySkills =
    TextEditingController();

final secondarySkills =
    TextEditingController();
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
  // NEW CONTROLLERS
  final description =
      TextEditingController();

  final responsibilities =
      TextEditingController();

  final requirements =
      TextEditingController();

  String type = "Full-time";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Job"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Builder(
          builder: (context) {

            final cubit =
                context.read<JobCubit>();

            return SingleChildScrollView(
              child: Column(
                children: [

                  // TITLE
                  TextField(
                    controller: title,

                    decoration:
                        const InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // DEPARTMENT
                  TextField(
                    controller: dept,

                    decoration:
                        const InputDecoration(
                      labelText: "Department",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // EXPERIENCE
                  TextField(
                    controller: exp,

                    decoration:
                        const InputDecoration(
                      labelText: "Experience",
                      border: OutlineInputBorder(),
                    ),
                  ),
<<<<<<< HEAD
                  const SizedBox(height: 16),

/// PRIMARY SKILLS
TextField(
  controller: primarySkills,
  maxLines: 3,

  decoration:
      const InputDecoration(

    labelText:
        "Primary Skills",

    // hintText:
    //     "Flutter, Dart, Firebase",

    border:
        OutlineInputBorder(),
  ),
),

const SizedBox(height: 16),

/// SECONDARY SKILLS
TextField(
  controller: secondarySkills,
  maxLines: 3,

  decoration:
      const InputDecoration(

    labelText:
        "Secondary Skills",

    // hintText:
    //     "Git, REST API, Figma",

    border:
        OutlineInputBorder(),
  ),
),
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

                  const SizedBox(height: 12),

                  // LOCATION
                  TextField(
                    controller: loc,

                    decoration:
                        const InputDecoration(
                      labelText: "Location",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),
                   TextField(
                    controller: count,

                    decoration:
                        const InputDecoration(
                      labelText: "Openings",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),
                   TextField(
                    controller: stat,

                    decoration:
                        const InputDecoration(
                      labelText: "Status",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // SALARY
                  TextField(
                    controller: sal,

                    decoration:
                        const InputDecoration(
                      labelText: "Salary",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // JOB TYPE
                  DropdownButtonFormField<String>(
                    value: type,

                    decoration:
                        const InputDecoration(
                      labelText: "Job Type",
                      border: OutlineInputBorder(),
                    ),

                    items: const [

                      DropdownMenuItem(
                        value: "Full-time",
                        child: Text("Full-time"),
                      ),

                      DropdownMenuItem(
                        value: "Part-time",
                        child: Text("Part-time"),
                      ),

                      DropdownMenuItem(
                        value: "Contract",
                        child: Text("Contract"),
                      ),
                    ],

                    onChanged: (v) {
                      setState(() {
                        type = v!;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // DESCRIPTION
                  TextField(
                    controller: description,
                    maxLines: 4,

                    decoration:
                        const InputDecoration(
                      labelText:
                          "Job Description",

                      border:
                          OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // RESPONSIBILITIES
                  TextField(
                    controller: responsibilities,
                    maxLines: 4,

                    decoration:
                        const InputDecoration(
                      labelText:
                          "Responsibilities",

                      hintText:
                          "Separate with comma",

                      border:
                          OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // REQUIREMENTS
                  TextField(
                    controller: requirements,
                    maxLines: 4,

                    decoration:
                        const InputDecoration(
                      labelText:
                          "Requirements",

                      hintText:
                          "Separate with comma",

                      border:
                          OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      onPressed: () {

                        cubit.addJob(
                          JobData(
                            title: title.text,
                            department:
                                dept.text,
                            experience:
                                exp.text,
                            location:
                                loc.text,
                            salary: sal.text,
                            type: type,
<<<<<<< HEAD
                            primarySkills:
    primarySkills.text
        .split(","),

secondarySkills:
    secondarySkills.text
        .split(","),
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

                       status: stat.text,
newCount: int.parse(count.text),

 
                            // NEW DATA
                            description:
                                description.text,

                            responsibilities:
                                responsibilities
                                    .text
                                    .split(","),

                            requirements:
                                requirements
                                    .text
                                    .split(","),
                          ),
                        );

                        Navigator.pop(context);
                      },

                      child: const Text(
                        "Create Job",
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
}