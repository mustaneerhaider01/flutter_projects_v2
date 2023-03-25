import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      EditProductScreen.routeName,
                      arguments: id,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () async {
                    try {
                      await Provider.of<Products>(context, listen: false)
                          .deleteProduct(id);
                    } catch (error) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            'Deleting failed!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: theme.primaryTextTheme.titleMedium!.color,
                            ),
                          ),
                          backgroundColor: theme.colorScheme.error,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
