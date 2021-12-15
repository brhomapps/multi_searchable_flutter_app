import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'search_able.dart';
import 'search_indicator.dart';

class SearchWidget extends StatefulWidget {
  /// the constructor  ///

  const SearchWidget(
      {Key? key,
      required this.data,
      this.searchIndicatorShape,
      this.indicatorColor,
      this.removeItemIconColor,
      this.searchableItemTextStyle,
      required this.onDelete,
      required this.onSelect})
      : super(key: key);
  final Searchable data;
  final SearchIndicatorShape? searchIndicatorShape;
  final Color? indicatorColor;
  final Color? removeItemIconColor;
  final TextStyle? searchableItemTextStyle;
  final Function onDelete;
  final Function onSelect;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    /// UI of selected items ///
    return Container(
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),

          /// to get selected items of list ///
          GestureDetector(
            onTap: () {
              widget.data.isSelected?.value =
                  !(widget.data.isSelected?.value ?? false);
              widget.onSelect(widget.data);
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),

                /// to control with selected text,Its value is empty until the user input it ///
                Text(
                  widget.data.label ?? '',
                  style:
                      widget.searchableItemTextStyle ?? TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                    onTap: () {
                      /// to remove selected item ///
                      widget.onDelete();
                    },
                    child: Icon(
                      Icons.close,
                      size: 15,
                      color: widget.removeItemIconColor,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ValueListenableBuilder<bool>(
              valueListenable:
                  widget.data.isSelected ?? ValueNotifier<bool>(false),
              builder: (BuildContext context, bool value, Widget? child) {
                return Visibility(
                  visible: value,

                  /// to control with  position of indicator ///

                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),

                      /// to control with shape and color of indicator ///
                      child: Container(
                        height: 7,
                        width: widget.searchIndicatorShape != null
                            ? (widget.searchIndicatorShape?.index ==
                                    SearchIndicatorShape.dot.index
                                ? 7
                                : 20)
                            : 20,
                        decoration: BoxDecoration(
                            color: widget.indicatorColor ?? Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
