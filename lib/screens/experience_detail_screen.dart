import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/widgets/remote_image.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({required this.experience, super.key});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(experience.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _DetailField(label: 'ID', value: experience.id ?? '-'),
          if (experience.logo.isNotEmpty) ...[
            RemoteImage(
              url: experience.logo,
              height: 200,
              fit: BoxFit.contain,
              borderRadius: 12,
              fallbackIcon: Icons.business_outlined,
            ),
            const SizedBox(height: 16),
          ],
          _DetailField(label: 'Title', value: experience.title),
          _DetailField(label: 'Description', value: experience.description),
          _DetailField(label: 'Organization', value: experience.organization),
          _DetailField(label: 'Period', value: experience.period),
          _DetailField(label: 'Location', value: experience.location),
          _DetailField(label: 'Logo URL', value: experience.logo),
          _DetailField(
            label: 'Highlights',
            value: experience.highlights.isEmpty
                ? '-'
                : experience.highlights.map((item) => '• $item').join('\n'),
          ),
          _DetailField(
            label: 'Tags',
            value: experience.tags.isEmpty ? '-' : experience.tags.join(', '),
          ),
          _DetailField(label: 'Star count', value: '${experience.starCount}'),
          _DetailField(
            label: 'Is starred by current user',
            value: experience.isStarred ? 'Yes' : 'No',
          ),
          _DetailField(
            label: 'Starred by',
            value: experience.starredByNames.isEmpty
                ? '-'
                : experience.starredByNames,
          ),
        ],
      ),
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          SelectableText(value),
        ],
      ),
    );
  }
}
