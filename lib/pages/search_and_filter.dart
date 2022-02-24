import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/blocs.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor(BuildContext context, Filter filter) {
      final currentFilter = context.watch<TodoFilterBloc>().state.filter;
      return filter == currentFilter ? Colors.blue : Colors.grey;
    }

    TextButton filterButton(BuildContext context, Filter filter) {
      return TextButton(
        onPressed: () {
          context.read<TodoFilterBloc>().add(ChangeFilterEvent(filter: filter));
        },
        child: Text(
          filter == Filter.active
              ? 'Active'
              : filter == Filter.complete
                  ? 'Complete'
                  : 'All',
          style: TextStyle(
            color: textColor(context, filter),
          ),
        ),
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
      );
    }

    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            filled: true,
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.all(16),
            border: InputBorder.none,
          ),
          onChanged: (String? search) {
            if (search != null) {
              context
                  .read<TodoSearchBloc>()
                  .add(SearchTodoEvent(search: search));
            }
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<ActiveTodoBloc, ActiveTodoState>(
                builder: (context, state) {
                  return Text(
                    ' ${state.activeCount} Task left',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                    ),
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                filterButton(context, Filter.all),
                const SizedBox(width: 4),
                filterButton(context, Filter.active),
                const SizedBox(width: 4),
                filterButton(context, Filter.complete),
              ],
            )
          ],
        ),
      ],
    );
  }
}
