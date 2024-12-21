// lib/features/child/presentation/pages/child_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/child_bloc.dart';
import '../blocs/child_event.dart';
import '../blocs/child_state.dart';
import 'add_child_page.dart';
import 'edit_child_page.dart';
import '../../../../core/theme/app_colors.dart';

class ChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: Text('Anak-anak'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<ChildBloc>(context).add(LoadChildrenEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<ChildBloc, ChildState>(
        builder: (context, state) {
          if (state is ChildLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChildLoaded) {
            if (state.children.isEmpty) {
              return Center(child: Text('Belum ada data anak.'));
            }
            return ListView.builder(
              itemCount: state.children.length,
              itemBuilder: (context, index) {
                final child = state.children[index];
                return ListTile(
                  title: Text(child.name),
                  subtitle: Text('Usia: ${child.age} tahun'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: AppColors.primary),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditChildPage(child: child),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteDialog(context, child.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ChildOperationFailure) {
            return Center(child: Text(state.message));
          }
          return Center(
              child: Text('Klik tombol tambah untuk menambahkan anak.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddChildPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Hapus Anak'),
        content: Text('Apakah Anda yakin ingin menghapus data anak ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<ChildBloc>(context).add(DeleteChildEvent(id));
              Navigator.of(context).pop();
            },
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
