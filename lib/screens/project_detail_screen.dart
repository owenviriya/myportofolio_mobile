import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/widgets/remote_image.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (project.projectImageUrl.isNotEmpty) ...[
            RemoteImage(
              url: project.projectImageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              borderRadius: 12,
            ),
            const SizedBox(height: 20),
          ],
          Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text('Tech stack', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(project.techStack),
          const SizedBox(height: 16),
          Text('Description', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(project.description),
          const SizedBox(height: 16),
          Text('Project URL', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          SelectableText(project.projectUrl),
        ],
      ),
    );
  }
}
