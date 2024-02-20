// import 'package:flutter/material.dart';
// import 'package:oktoast/oktoast.dart';

// class PrimarySnackBar {
//   PrimarySnackBar(BuildContext context) {
//     fToast.init(context);
//     _context = context;
//   }

//   OKToast okToast = OKToast(child: Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 16,
//       ),
//       width: MediaQuery.of(_context).size.width,
//       alignment: Alignment.center,
//       decoration: const BoxDecoration(
//           //  color: backgroundColor ?? AppColors.colorPrimary,
//           ),
//       child: SizedBox(
//         width: MediaQuery.of(_context).size.width,
//         child: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     ););
//   late BuildContext _context;

//   displaySnackBar({required String message, Color? backgroundColor}) {
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 16,
//       ),
//       width: MediaQuery.of(_context).size.width,
//       alignment: Alignment.center,
//       decoration: const BoxDecoration(
//           //  color: backgroundColor ?? AppColors.colorPrimary,
//           ),
//       child: SizedBox(
//         width: MediaQuery.of(_context).size.width,
//         child: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );

//     okToast..showToast(
//         child: toast,
//         toastDuration: const Duration(seconds: 5),
//         positionedToastBuilder: (context, child) {
//           return Positioned(
//             child: child,
//             top: 100.0,
//             left: 0,
//           );
//         });
//   }
// }
