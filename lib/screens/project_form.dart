import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  String? _validateRequired(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label tidak boleh kosong.';
    }
    return null;
  }

  String? _validateProjectUrl(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Project URL tidak boleh kosong.';
    return _validateUrl(text, 'Project URL');
  }

  String? _validateOptionalImageUrl(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    return _validateUrl(text, 'Project Image URL');
  }

  String? _validateUrl(String text, String label) {
    final uri = Uri.tryParse(text);
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty) {
      return '$label harus berupa URL http atau https yang valid.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      final loggedIn = await ensureLoggedIn(context);
      if (!mounted || !loggedIn) return;

      final token = context.read<AuthState>().token;
      if (token == null) return;

      final project = Project(
        title: _title.trim(),
        description: _description.trim(),
        techStack: _techStack.trim(),
        projectUrl: _projectUrl.trim(),
        projectImageUrl: _projectImageUrl.trim(),
      );
      final createdProject = await context.read<ApiClient>().createProject(
        project,
        token: token,
      );
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Project created'),
          content: Text('"${createdProject.title}" was added successfully.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on ApiException catch (error) {
      if (!mounted) return;

      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Session expired. Please log in again.'),
            ),
          );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Could not save project (${error.statusCode}).'),
            ),
          );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _title = value,
              validator: (value) => _validateRequired(value, 'Title'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              onChanged: (value) => _description = value,
              validator: (value) => _validateRequired(value, 'Description'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tech Stack',
                hintText: 'Flutter, Django, Figma',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _techStack = value,
              validator: (value) => _validateRequired(value, 'Tech Stack'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'Project URL',
                hintText: 'https://example.com',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _projectUrl = value,
              validator: _validateProjectUrl,
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'Project Image URL (optional)',
                hintText: 'https://example.com/image.png',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _projectImageUrl = value,
              validator: _validateOptionalImageUrl,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save project'),
            ),
          ],
        ),
      ),
    );
  }
}
