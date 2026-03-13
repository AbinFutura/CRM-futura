import 'package:flutter/material.dart';
import 'package:futura_crm_app/features/leads/view/widgets/lead_dropdown.dart';
import 'package:futura_crm_app/features/leads/view/widgets/lead_section_casrd.dart';
import 'package:futura_crm_app/features/leads/view/widgets/lead_textfield.dart';
import 'package:futura_crm_app/features/leads/view/widgets/view_more_toggle.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/validator/form_validator.dart';
import '../view_model/leads_viewmodel.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final altPhoneController = TextEditingController();
  final landlineController = TextEditingController();

  final companyController = TextEditingController();
  final industryController = TextEditingController();
  final websiteController = TextEditingController();
  final addressController = TextEditingController();

  bool showCustomerMore = false;
  bool showCompanyMore = false;
  bool showLeadMore = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    altPhoneController.dispose();
    landlineController.dispose();

    companyController.dispose();
    industryController.dispose();
    websiteController.dispose();
    addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LeadsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Lead")),

      body: SafeArea(
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                /// CUSTOMER INFORMATION
                LeadSectionCard(
                  title: "Customer Information",
                  children: [
                    LeadTextField(
                      controller: nameController,
                      hint: "Customer Name",
                      icon: Icons.person,
                      validator: (v) => FormValidators.required(v, "Name"),
                    ),

                    const SizedBox(height: 12),

                    LeadTextField(
                      controller: phoneController,
                      hint: "Phone Number",
                      icon: Icons.phone,
                      validator: FormValidators.phone,
                    ),

                    const SizedBox(height: 8),

                    ViewMoreToggle(
                      expanded: showCustomerMore,
                      onTap: () {
                        setState(() {
                          showCustomerMore = !showCustomerMore;
                        });
                      },
                    ),

                    if (showCustomerMore) ...[
                      const Divider(),
                      const SizedBox(height: 12),

                      LeadTextField(
                        controller: emailController,
                        hint: "Email",
                        icon: Icons.email,
                        validator: FormValidators.email,
                      ),

                      const SizedBox(height: 12),

                      LeadTextField(
                        controller: altPhoneController,
                        hint: "Alternate Phone",
                        icon: Icons.phone_android,
                      ),

                      const SizedBox(height: 12),

                      LeadTextField(
                        controller: landlineController,
                        hint: "Landline",
                        icon: Icons.phone_in_talk,
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 16),

                /// COMPANY INFORMATION
                LeadSectionCard(
                  title: "Company Information",
                  children: [
                    LeadTextField(
                      controller: companyController,
                      hint: "Company Name",
                      icon: Icons.business,
                    ),

                    const SizedBox(height: 12),

                    LeadTextField(
                      controller: industryController,
                      hint: "Industry",
                      icon: Icons.work,
                    ),

                    const SizedBox(height: 8),

                    ViewMoreToggle(
                      expanded: showCompanyMore,
                      onTap: () {
                        setState(() {
                          showCompanyMore = !showCompanyMore;
                        });
                      },
                    ),

                    if (showCompanyMore) ...[
                      const Divider(),
                      const SizedBox(height: 12),

                      LeadTextField(
                        controller: websiteController,
                        hint: "Website",
                        icon: Icons.language,
                      ),

                      const SizedBox(height: 12),

                      LeadTextField(
                        controller: addressController,
                        hint: "Address",
                        icon: Icons.location_on,
                        maxLines: 3,
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 16),

                /// PIPELINE
                LeadSectionCard(
                  title: "Pipeline",
                  children: [
                    LeadDropdown(
                      items: vm.pipelineStages,
                      value: vm.pipelineStage,
                      onChanged: vm.setPipeline,
                      hint: "Pipeline Stage",
                      icon: Icons.timeline,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// LEAD INFORMATION
                LeadSectionCard(
                  title: "Lead Information",
                  children: [
                    LeadDropdown(
                      items: vm.leadSources,
                      value: vm.leadSource,
                      onChanged: vm.setSource,
                      hint: "Lead Source",
                      icon: Icons.source,
                    ),

                    const SizedBox(height: 12),

                    LeadDropdown(
                      items: vm.statuses,
                      value: vm.status,
                      onChanged: vm.setStatus,
                      hint: "Status",
                      icon: Icons.flag,
                    ),

                    const SizedBox(height: 8),
                    ViewMoreToggle(
                      expanded: showLeadMore,
                      onTap: () {
                        setState(() {
                          showLeadMore = !showLeadMore;
                        });
                      },
                    ),

                    if (showLeadMore) ...[
                      const Divider(),
                      const SizedBox(height: 12),

                      LeadDropdown(
                        items: vm.purposes,
                        value: vm.purpose,
                        onChanged: vm.setPurpose,
                        hint: "Purpose",
                        icon: Icons.school,
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 16),

                /// ASSIGN AGENT
                LeadSectionCard(
                  title: "Assign Agent",
                  children: [
                    LeadDropdown(
                      items: vm.agents,
                      value: vm.agent,
                      onChanged: vm.setAgent,
                      hint: "Select Agent",
                      icon: Icons.person_outline,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// SOCIAL MEDIA
                LeadSectionCard(
                  title: "Social Media",
                  children: [
                    LeadDropdown(
                      items: vm.socialMediaItems,
                      value: vm.socialMediaValue,
                      onChanged: (value) {
                        setState(() {
                          vm.socialMediaValue = value;
                        });
                      },
                      hint: "Select Platform",
                      icon: Icons.public,
                    ),
                  ],
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      /// create lead
                    }
                  },
                  child: const Text("Create Lead"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
