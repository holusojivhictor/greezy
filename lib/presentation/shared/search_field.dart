import 'package:flutter/material.dart';
import 'package:greezy/theme.dart';

typedef SearchChanged = void Function(String val);

class SearchField extends StatefulWidget {
  final String? value;
  final bool showClearButton;
  final SearchChanged searchChanged;
  final EdgeInsets padding;

  const SearchField({
    Key? key,
    this.value,
    required this.searchChanged,
    this.showClearButton = true,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _searchFocusNode = FocusNode();
  late TextEditingController _searchBoxTextController;

  @override
  void initState() {
    super.initState();
    _searchBoxTextController = TextEditingController(text: widget.value);
    _searchBoxTextController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _searchBoxTextController.removeListener(_onSearchTextChanged);
    _searchBoxTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: widget.padding,
      constraints: BoxConstraints(maxWidth: screenWidth * 0.78),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: kWhite,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchBoxTextController,
                focusNode: _searchFocusNode,
                cursorColor: theme.primaryColor,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Search Product",
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                ),
              ),
            ),
            if (widget.value != null && widget.value!.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.close),
                splashRadius: 15,
                onPressed: _cleanSearchText,
              ),
          ],
        ),
      ),
    );
  }

  void _onSearchTextChanged() => widget.searchChanged(_searchBoxTextController.text);

  void _cleanSearchText() {
    _searchFocusNode.requestFocus();
    if (_searchBoxTextController.text.isEmpty) {
      return;
    }
    _searchBoxTextController.text = '';
  }
}