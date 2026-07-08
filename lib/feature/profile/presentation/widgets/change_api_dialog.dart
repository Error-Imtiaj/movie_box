import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_box/feature/profile/bloc/profile_bloc.dart';

class ChangeApiKeyDialog extends StatefulWidget {
  final String currentApiKey;

  const ChangeApiKeyDialog({
    super.key,
    required this.currentApiKey,
  });

  @override
  State<ChangeApiKeyDialog> createState() => _ChangeApiKeyDialogState();
}

class _ChangeApiKeyDialogState extends State<ChangeApiKeyDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentApiKey);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.success) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("API Key updated successfully."),
            ),
          );
        }

        if (state.error != null && state.error!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title:  Text("Change TMDB API Key", style: Theme.of(context).textTheme.titleMedium,),
          content: SizedBox(
            width: 400,
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _controller,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "TMDB API Key",
                  hintText: "Enter your API Key",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "API Key is required";
                  }

                  return null;
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: state.saving
                  ? null
                  : () {
                      Navigator.pop(context);
                    },
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: state.saving
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ProfileBloc>().add(
                              SaveApiKey(
                                _controller.text.trim(),
                              ),
                            );
                      }
                    },
              child: state.saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}