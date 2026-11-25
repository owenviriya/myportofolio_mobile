import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _organization = '';
  String _period = '';
  String _location = '';
  String _logo = '';
  String _highlights = '';
  String _tags = '';
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAccess());
  }

  Future<void> _checkAccess() async {
    final loggedIn = await ensureLoggedIn(context);
    if (!mounted) return;
    if (!loggedIn) Navigator.pop(context);
  }

  String? _validateRequired(String? value, String label, {int? maxLength}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '$label tidak boleh kosong.';
    if (maxLength != null && text.length > maxLength) {
      return '$label maksimal $maxLength karakter.';
    }
    return null;
  }

  String? _validateOptionalText(String? value, String label, int maxLength) {
    if ((value?.trim().length ?? 0) > maxLength) {
      return '$label maksimal $maxLength karakter.';
    }
    return null;
  }

  String? _validateLogoUrl(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;

    final uri = Uri.tryParse(text);
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty) {
      return 'Masukkan URL logo yang valid (http atau https).';
    }
    return _validateOptionalText(text, 'URL logo', 255);
  }

  List<String> _splitValues(String value) => value
      .split(',')
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toList();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      final loggedIn = await ensureLoggedIn(context);
      if (!mounted || !loggedIn) return;

      final token = context.read<AuthState>().token;
      if (token == null) return;

      final experience = Experience(
        title: _title.trim(),
        description: _description.trim(),
        organization: _organization.trim(),
        period: _period.trim(),
        location: _location.trim(),
        logo: _logo.trim(),
        highlights: _splitValues(_highlights),
        tags: _splitValues(_tags),
      );
      final created = await context.read<ApiClient>().createExperience(
        experience,
        token: token,
      );
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Experience created'),
          content: Text('"${created.title}" was added successfully.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Back to list'),
            ),
          ],
        ),
      );
      if (mounted) Navigator.pop(context, true);
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
              content: Text('Could not save experience (${error.statusCode}).'),
            ),
          );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Could not save experience: $error')),
        );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Experience')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              maxLength: 255,
              decoration: const InputDecoration(
                labelText: 'Title *',
                hintText: 'Software Engineer',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _title = value,
              validator: (value) =>
                  _validateRequired(value, 'Title', maxLength: 255),
            ),
            const SizedBox(height: 12),
            TextFormField(
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description *',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              onChanged: (value) => _description = value,
              validator: (value) => _validateRequired(value, 'Description'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              maxLength: 255,
              decoration: const InputDecoration(
                labelText: 'Organization',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _organization = value,
              validator: (value) =>
                  _validateOptionalText(value, 'Organization', 255),
            ),
            const SizedBox(height: 12),
            TextFormField(
              maxLength: 255,
              decoration: const InputDecoration(
                labelText: 'Period',
                hintText: 'January 2024 - Present',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _period = value,
              validator: (value) => _validateOptionalText(value, 'Period', 255),
            ),
            const SizedBox(height: 12),
            TextFormField(
              maxLength: 255,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _location = value,
              validator: (value) =>
                  _validateOptionalText(value, 'Location', 255),
            ),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.url,
              maxLength: 255,
              decoration: const InputDecoration(
                labelText: 'Logo URL',
                hintText: 'https://example.com/logo.png',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _logo = value,
              validator: _validateLogoUrl,
            ),
            const SizedBox(height: 12),
            TextFormField(
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Highlights',
                hintText: 'Comma-separated highlights',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _highlights = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tags',
                hintText: 'Comma-separated tags',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _tags = value,
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
                  : const Text('Save experience'),
            ),
          ],
        ),
      ),
    );
  }
}
