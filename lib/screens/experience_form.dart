import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

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

  String? _validateRequired(String? value, String label, {int? maxLength}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return '$label tidak boleh kosong!';
    }
    if (maxLength != null && text.length > maxLength) {
      return '$label maksimal $maxLength karakter.';
    }
    return null;
  }

  String? _validateOptionalText(String? value, String label, int maxLength) {
    final text = value?.trim() ?? '';
    if (text.length > maxLength) {
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
    if (text.length > 255) {
      return 'URL logo maksimal 255 karakter.';
    }
    return null;
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _title = '';
      _description = '';
      _organization = '';
      _period = '';
      _location = '';
      _logo = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Experience Form'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLength: 255,
                  decoration: const InputDecoration(
                    labelText: 'Judul Pengalaman *',
                    hintText: 'Contoh: Software Engineer',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _title = value,
                  validator: (value) => _validateRequired(
                    value,
                    'Judul pengalaman',
                    maxLength: 255,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi *',
                    hintText: 'Jelaskan tanggung jawab atau pekerjaanmu',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  onChanged: (value) => _description = value,
                  validator: (value) => _validateRequired(value, 'Deskripsi'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLength: 255,
                  decoration: const InputDecoration(
                    labelText: 'Organisasi',
                    hintText: 'Nama organisasi atau perusahaan',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _organization = value,
                  validator: (value) =>
                      _validateOptionalText(value, 'Organisasi', 255),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLength: 255,
                  decoration: const InputDecoration(
                    labelText: 'Periode',
                    hintText: 'Contoh: Januari 2024 - Sekarang',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _period = value,
                  validator: (value) =>
                      _validateOptionalText(value, 'Periode', 255),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLength: 255,
                  decoration: const InputDecoration(
                    labelText: 'Lokasi',
                    hintText: 'Contoh: Jakarta, Indonesia',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _location = value,
                  validator: (value) =>
                      _validateOptionalText(value, 'Lokasi', 255),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'URL Logo',
                    hintText: 'https://contoh.com/logo.png',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _logo = value,
                  validator: _validateLogoUrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      showDialog<void>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Pengalaman berhasil ditambahkan!'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Judul: ${_title.trim()}'),
                                Text('Deskripsi: ${_description.trim()}'),
                                Text(
                                  'Organisasi: ${_organization.trim().isEmpty ? '-' : _organization.trim()}',
                                ),
                                Text(
                                  'Periode: ${_period.trim().isEmpty ? '-' : _period.trim()}',
                                ),
                                Text(
                                  'Lokasi: ${_location.trim().isEmpty ? '-' : _location.trim()}',
                                ),
                                Text(
                                  'URL Logo: ${_logo.trim().isEmpty ? '-' : _logo.trim()}',
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                                _resetForm();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Save'),
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
