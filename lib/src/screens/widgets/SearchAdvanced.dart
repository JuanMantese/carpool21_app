import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdvancedFiltersModal extends StatefulWidget {
  final Function(String, String, TimeOfDay, TimeOfDay) onFilter;

  AdvancedFiltersModal({required this.onFilter});

  @override
  _AdvancedFiltersModalState createState() => _AdvancedFiltersModalState();
}

class _AdvancedFiltersModalState extends State<AdvancedFiltersModal> {
  String originDestination = 'Origen/Destino';
  String campus = 'Sedes';
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  List<String> originDestinationOptions = ['Origen/Destino', 'Origen', 'Destino'];
  List<String> campusOptions = ['Sedes', 'Campus', 'Nva Cordoba'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('¡Filtros para buscar tu viaje!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          DropdownButtonFormField(
            value: originDestination,
            items: originDestinationOptions.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                originDestination = value as String;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Origen/Destino',
            ),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField(
            value: campus,
            items: campusOptions.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                campus = value as String;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Sedes',
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'Horario mínimo',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        startTime = time;
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: startTime != null ? startTime!.format(context) : '',
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'Horario máximo',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        endTime = time;
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: endTime != null ? endTime!.format(context) : '',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.onFilter(originDestination, campus, startTime ?? TimeOfDay(hour: 0, minute: 0), endTime ?? TimeOfDay(hour: 23, minute: 59));
                  Navigator.pop(context);
                },
                child: Text('Filtrar'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}