// import 'package:flutter_tagging/flutter_tagging.dart';

// class AddItemsDoctorService {
//   static Future<List<AddItemsDoctor>> getAddItemsDoctors(String query) async {
//     // await Future.delayed(Duration(milliseconds: 400), null);
//     return <AddItemsDoctor>[
//       AddItemsDoctor(name: 'Asthama'),
//       AddItemsDoctor(name: 'Heart Attack'),
//       AddItemsDoctor(name: 'Cancer'),
//       AddItemsDoctor(name: 'Liver Failure'),
//       AddItemsDoctor(name: 'Durm Tore'),
//       AddItemsDoctor(name: 'Head Ache'),
//     ]
//         .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// }

// /// AddItemsDoctor Class
// class AddItemsDoctor extends Taggable {
//   ///
//    String name;

//   /// Creates AddItemsDoctor
//   AddItemsDoctor({
//     this.name,
//   });

//   @override
//   List<Object> get props => [name];

//   /// Converts the class to json string.
//   String toJson() => 
//     "$name\n";

// }