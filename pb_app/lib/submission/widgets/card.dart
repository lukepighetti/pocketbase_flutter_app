import 'package:flutter/material.dart';
import 'package:pb_app/submission/theme/theme.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SubmissionCard extends StatelessWidget {
  const SubmissionCard({
    Key? key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final String subtitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: WaveWidget(
                  config: CustomConfig(
                    colors: [
                      SubmissionTheme.waveBig,
                      SubmissionTheme.waveSmall,
                    ],
                    durations: SubmissionTheme.waveDurations,
                    heightPercentages: SubmissionTheme.waveHeights,
                  ),
                  backgroundColor: SubmissionTheme.secondaryColor,
                  size: const Size(double.infinity, double.infinity),
                  waveAmplitude: 0,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        iconData,
                        color: Colors.white,
                        size: 64,
                      ),
                      const SizedBox(
                        height: SubmissionTheme.gap,
                      ),
                      Text(
                        title,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: SubmissionTheme.gap,
                      ),
                      Text(
                        subtitle,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
