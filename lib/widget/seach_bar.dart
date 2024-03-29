import 'dart:ffi';

import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

class SearchBar extends StatefulWidget {
  final bool enabled; //ban search not?
  final bool hideLeft;
  final SearchBarType
      searchBarType; //对searchBarType设置默认值因为searchBarType不可为空，null不是SearchBarType的子类型
  final String hint; //notice text
  final String defaultText;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;

  const SearchBar(
      {super.key,
      required this.enabled,
      required this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      required this.hint,
      required this.defaultText,
      required this.leftButtonClick,
      required this.rightButtonClick,
      required this.speakClick,
      required this.inputBoxClick,
      required this.onChanged});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    setState(() {
      _controller.text = widget.defaultText;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch()
        : _genHomeSearch();
  }

  _genHomeSearch() {
    return Container(
      child: Row(
        children: [
          _wrapTap(
              Container(
                  padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
                  child: Row(
                    children: [
                      Text(
                        '上海',
                        style: TextStyle(color: _homeFontColor(), fontSize: 14),
                      ),
                      Icon(
                        Icons.expand_more,
                        color: _homeFontColor(),
                        size: 22,
                      )
                    ],
                  )),
              widget.leftButtonClick),
          Expanded(
            child: _inputBox(),
            flex: 1,
          ),
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color: _homeFontColor(),
                  size: 26,
                ),
              ),
              widget.rightButtonClick)
        ],
      ),
    );
  }

  _genNormalSearch() {
    return Container(
      child: Row(
        children: [
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: widget.hideLeft
                    ? null
                    : const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 26,
                      ),
              ),
              widget.leftButtonClick),
          Expanded(
            child: _inputBox(),
            flex: 1,
          ),
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: const Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ),
              widget.rightButtonClick)
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        // if (callback != null) {
        //   callback();
        // }
        callback();
      },
      child: child,
    );
  }

  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5 : 15)),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal
                ? Color.fromRGBO(169, 169, 169, 1)
                : Colors.blue,
          ),
          Expanded(
              flex: 1,
              child: widget.searchBarType == SearchBarType.normal
                  ? TextField(
                      controller: _controller,
                      onChanged: _onChanged,
                      autofocus: true,
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      //输入文本样式
                      decoration: InputDecoration(
                          isDense: true, //编辑框对齐
                          contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          border: InputBorder.none,
                          hintText: widget.hint,
                          hintStyle: const TextStyle(fontSize: 15)),
                    )
                  : _wrapTap(
                      Container(
                        child: Text(
                          widget.defaultText,
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      widget.inputBoxClick)),
          !showClear
              ? _wrapTap(
                  Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.searchBarType == SearchBarType.normal
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  widget.speakClick)
              : _wrapTap(
                  const Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                })
        ],
      ),
    );
  }

  _onChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    widget.onChanged(text);
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
