// lib/features/child/presentation/pages/edit_child_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/child.dart';
import '../blocs/child_bloc.dart';
import '../blocs/child_event.dart';
import '../../../../core/theme/app_colors.dart';

class EditChildPage extends StatefulWidget {
  final Child child;

  const EditChildPage({Key? key, required this.child}) : super(key: key);

  @override
  _EditChildPageState createState() => _EditChildPageState();
}

class _EditChildPageState extends State<EditChildPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late int age;
  late double weight;
  late double height;

  @override
  void initState() {
    super.initState();
    name = widget.child.name;
    age = widget.child.age;
    weight = widget.child.weight;
    height = widget.child.height;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final updatedChild = Child(
      id: widget.child.id,
      name: name,
      age: age,
      weight: weight,
      height: height,
    );

    BlocProvider.of<ChildBloc>(context).add(UpdateChildEvent(updatedChild));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: Text('Edit Anak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nama
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  hintText: 'Masukkan nama anak',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Nama tidak boleh kosong'
                    : null,
                onSaved: (value) => name = value!,
              ),
              SizedBox(height: 16),
              // Usia
              TextFormField(
                initialValue: age.toString(),
                decoration: InputDecoration(
                  labelText: 'Usia',
                  hintText: 'Masukkan usia anak (tahun)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Usia tidak boleh kosong';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0) {
                    return 'Masukkan usia yang valid';
                  }
                  return null;
                },
                onSaved: (value) => age = int.parse(value!),
              ),
              SizedBox(height: 16),
              // Berat Badan
              TextFormField(
                initialValue: weight.toString(),
                decoration: InputDecoration(
                  labelText: 'Berat Badan (kg)',
                  hintText: 'Masukkan berat badan anak',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Berat badan tidak boleh kosong';
                  }
                  final weight = double.tryParse(value);
                  if (weight == null || weight <= 0) {
                    return 'Masukkan berat badan yang valid';
                  }
                  return null;
                },
                onSaved: (value) => weight = double.parse(value!),
              ),
              SizedBox(height: 16),
              // Tinggi Badan
              TextFormField(
                initialValue: height.toString(),
                decoration: InputDecoration(
                  labelText: 'Tinggi Badan (cm)',
                  hintText: 'Masukkan tinggi badan anak',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tinggi badan tidak boleh kosong';
                  }
                  final height = double.tryParse(value);
                  if (height == null || height <= 0) {
                    return 'Masukkan tinggi badan yang valid';
                  }
                  return null;
                },
                onSaved: (value) => height = double.parse(value!),
              ),
              SizedBox(height: 32),
              // Submit Button
              ElevatedButton(
                onPressed: _submit,
                child: Text('Update'),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
