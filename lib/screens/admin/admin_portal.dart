import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_data_table/web_data_table.dart';
import 'package:ms_register/model/admin/admin_visitor_log_list.dart';
import 'package:ms_register/utils/api.dart';
import 'package:ms_register/utils/constants.dart';
import 'package:ms_register/utils/helper_methods.dart';
import 'package:provider/provider.dart';

import '../../service/api_provider.dart';

class AdminPortal extends StatefulWidget {
  const AdminPortal({super.key});
  static const String routePath = '/admin';

  @override
  State<AdminPortal> createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal> {
  final TextEditingController search = TextEditingController();
  late String _sortColumnName;
  late bool _sortAscending;
  List<String>? _filterTexts;
  bool _willSearch = true;
  Timer? _timer;
  int? _latestTick;
  final List<String> _selectedRowKeys = [];
  int _rowsPerPage = 10;

  late ApiProvider _api;
  List<Map<String, dynamic>> list = [];

  @override
  void initState() {
    super.initState();
    super.initState();
    _sortColumnName = 'name';
    _sortAscending = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_willSearch) {
        if (_latestTick != null && timer.tick > _latestTick!) {
          _willSearch = true;
        }
      }
      if (_willSearch) {
        _willSearch = false;
        _latestTick = null;
        setState(() {
          if (_filterTexts != null && _filterTexts!.isNotEmpty) {
            _filterTexts = _filterTexts;
          }
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }

  reloadScreen() async {
    list.clear();
    setState(() {});
    await _api.getRequest(Api.getVisitorLogs).then((response) {
      debugPrint(response.toString());
      AdminVisitorLogList visitorLogList =
          AdminVisitorLogList.fromMap(response);
      log('resp : ${visitorLogList.data?.length}');
      visitorLogList.data?.forEach((item) {
        Map<String, dynamic> map = {
          'id': item.id,
          'photo': item.visitor?.imagePath,
          'visitor': item.visitor?.visitorName,
          'mobile': item.visitor?.mobileNo,
          'block': item.block,
          'flat': item.flatNo,
          'resident': item.residentName,
          'time': item.createdOn,
          'purpose': item.visitPurpose,
          'delete': item.id
        };
        list.add(map);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _api = Provider.of<ApiProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      appBar: AppBar(
        title: const Text('MaxSociety'),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: _api.status == ApiStatus.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : body(context),
    );
  }

  body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.defaultPadding),
      child: Theme(
        data: ThemeData(
          cardColor: Colors.white,
          useMaterial3: false,
        ),
        child: WebDataTable(
          header: const Text('Visitors Log'),
          source: WebDataTableSource(
            sortColumnName: _sortColumnName,
            sortAscending: _sortAscending,
            filterTexts: _filterTexts,
            columns: [
              WebDataColumn(
                name: 'id',
                label: const Text('ID'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'photo',
                label: const Text('Photo'),
                sortable: false,
                dataCell: (value) => DataCell(
                  InkWell(
                    onTap: () {
                      showPopup(
                          CachedNetworkImage(
                            imageUrl: value,
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Text(
                              error.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          context);
                    },
                    child: CachedNetworkImage(
                      imageUrl: value,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              WebDataColumn(
                name: 'visitor',
                label: const Text('Visitor'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'mobile',
                label: const Text('Mobile'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'block',
                label: const Text('Block'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'flat',
                label: const Text('Flat'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'resident',
                label: const Text('Resident'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'time',
                label: const Text('Time'),
                dataCell: (value) => DataCell(Text('$value')),
              ),
              WebDataColumn(
                name: 'purpose',
                label: const Text('Purpose'),
                dataCell: (value) => DataCell(InkWell(
                  onTap: () {
                    showPopup(
                        Text(
                          value,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        context);
                  },
                  child: Text(
                    '$value',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
              ),
              WebDataColumn(
                name: 'delete',
                sortable: false,
                label: const Text('Delete'),
                dataCell: (value) => DataCell(
                  IconButton(
                      onPressed: () {
                        _api.deleteRequest(Api.deleteVisitorLog + value).then(
                              (value) => reloadScreen(),
                            );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ),
              ),
            ],
            rows: list,
            selectedRowKeys: _selectedRowKeys,
            onTapRow: (rows, index) {},
            primaryKeyName: 'id',
          ),
          onSort: (columnName, ascending) {
            setState(() {
              _sortColumnName = columnName;
              _sortAscending = ascending;
            });
          },
          onRowsPerPageChanged: (rowsPerPage) {
            setState(() {
              if (rowsPerPage != null) {
                _rowsPerPage = rowsPerPage;
              }
            });
          },
          rowsPerPage: _rowsPerPage,
          onPageChanged: (value) {},
          actions: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: search,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  _filterTexts = text.trim().split(' ');
                  _willSearch = false;
                  _latestTick = _timer?.tick;
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
