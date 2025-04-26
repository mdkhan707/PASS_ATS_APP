// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:pass_ats/Models/resume_template_model.dart';

// class ResumeTemplateController extends GetxController {
//   var templates = <ResumeTemplate>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     fetchTemplates();
//     super.onInit();
//   }

//   Future<void> fetchTemplates() async {
//     try {
//       isLoading(true);
//       errorMessage(''); // clear any old errors

//       var response =
//           await http.get(Uri.parse('http://10.0.2.2:5000/api/templates'));

//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         print("=== Response === $jsonResponse");

//         if (jsonResponse is Map && jsonResponse.containsKey('templates')) {
//           var templateList = jsonResponse['templates'];

//           if (templateList is List) {
//             templates.value = templateList
//                 .whereType<Map<String, dynamic>>()
//                 .map((item) => ResumeTemplate.fromJson(item))
//                 .toList();
//           } else {
//             errorMessage.value = 'Invalid data format: templates is not a list';
//           }
//         } else {
//           errorMessage.value =
//               'Invalid data format: expected map with templates key';
//         }
//       } else {
//         errorMessage.value = 'Failed to load templates';
//       }
//     } catch (e) {
//       errorMessage.value = 'An error occurred: $e';
//       print("=== Exception === $e");
//     } finally {
//       isLoading(false);
//     }
//   }
// }
