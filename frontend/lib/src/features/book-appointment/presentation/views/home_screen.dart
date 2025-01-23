import 'package:dialink/src/config/router/route_names.dart';
import 'package:dialink/src/core/core.dart';
import 'package:dialink/src/core/utils/extensions.dart';
import 'package:dialink/src/features/book-appointment/presentation/controller/appointment_controller.dart';
import 'package:dialink/src/features/book-appointment/presentation/views/appointment_modal.dart';
import 'package:dialink/src/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.firstname});

  final String? firstname;

  @override
  Widget build(BuildContext context) {
    final AppointmentNotifier appointmentController = AppointmentNotifier();
    return ChangeNotifierProvider.value(
      value: appointmentController,
      builder: (context, child) => child!,
      child: AppScaffold(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                //TODO: Add icon to indicate gender
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Welcome,\t\t",
                      style: context.textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: "name",
                          style: context.textTheme.titleLarge!.copyWith(
                            color: AppColors.primary,
                            fontFamily: AppConstants.instance.cooperBtFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  customBorder: CircleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Iconsax.logout_14),
                  ),
                  onTap: () {
                    context.router.pushReplacementNamed(RouteName.login);
                  },
                ),
              ],
            ),
            24.0.verticalSpacing,
            Expanded(
              child: Consumer<AppointmentNotifier>(
                builder: (context, controller, _) => ListView.separated(
                  itemBuilder: (context, index) => _AppointmentTile(
                    id: index + 1,
                  ),
                  separatorBuilder: (context, index) => 14.0.verticalSpacing,
                  itemCount: controller.data.length,
                ),
              ),
            ),
            24.0.verticalSpacing,
            Center(
              child: TextButton(
                onPressed: () => showAdaptiveDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: AppColors.secondary.withAlpha(250),
                  builder: (context) => ChangeNotifierProvider.value(
                    value: appointmentController,
                    child: BookAppointmentDate(),
                  ),
                ),
                child: Text("Book an Appointment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppointmentTile extends StatelessWidget {
  _AppointmentTile({required this.id});

  final int id;

  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isExpanded,
      builder: (context, isExpanded, _) {
        return AnimatedSize(
          curve: Curves.ease,
          duration: Durations.medium4,
          child: GestureDetector(
            onTap: () => _isExpanded.value = !_isExpanded.value,
            child: Container(
              padding: EdgeInsets.all(12),
              constraints: BoxConstraints(
                minWidth: context.deviceSize.width,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withAlpha(125)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    offset: Offset(2, 2),
                    color: AppColors.textColor.withValues(alpha: .3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Appointment #$id",
                        style: context.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Icon(switch (isExpanded) {
                        true => Iconsax.arrow_up_2,
                        _ => Iconsax.arrow_down_1,
                      })
                    ],
                  ),
                  if (isExpanded) ...[
                    Divider(color: AppColors.secondary),
                    _buildSubFields(
                      context,
                      fieldName: "Name",
                      value: "Fredward Bernard",
                    ),
                    _buildSubFields(
                      context,
                      fieldName: "Age",
                      value: "10 years old",
                    ),
                    _buildSubFields(
                      context,
                      fieldName: "Gender",
                      value: "CT Scan",
                    ),
                    Divider(color: AppColors.secondary),
                    _buildSubFields(
                      context,
                      fieldName: "Date of birth",
                      value: "CT Scan",
                    ),
                    _buildSubFields(
                      context,
                      fieldName: "Allergies",
                      value: "CT Scan",
                    ),
                    _buildSubFields(
                      context,
                      fieldName: "Next of Kin",
                      value: "See a doctor at Luth",
                    ),
                    Divider(color: AppColors.secondary),
                    _buildSubFields(
                      context,
                      fieldName: "Hospital",
                      value: "Fredward Bernard",
                    ),
                    _buildSubFields(
                      context,
                      fieldName: "Test",
                      value: "Fredward Bernard",
                    ),
                    _buildSubFields(
                      context,
                      fieldName: "Medical History",
                      value:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
                    ),
                    Divider(color: AppColors.secondary),
                    _buildSubFields(
                      context,
                      fieldName: "Available date",
                      value: "CT Scan",
                    ),
                    12.0.verticalSpacing,
                    Row(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: Text("Reject"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Accept"),
                        ),
                      ],
                    )
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubFields(
    BuildContext context, {
    required String fieldName,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        spacing: 8,
        children: [
          Text(
            fieldName,
            style: context.textTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
