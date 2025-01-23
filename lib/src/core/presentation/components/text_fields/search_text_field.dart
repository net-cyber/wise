// import 'package:flutter/material.dart';
// import 'package:flutter_remix/flutter_remix.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../../core/constants/constants.dart';
// import '../../../core/utils/utils.dart';
// import '../../../riverpod/provider/app_provider.dart';
// import '../../theme/theme.dart';

// class SearchTextField extends ConsumerWidget {
//   final String? hintText;
//   final Widget? suffixIcon;
//   final TextEditingController? textEditingController;
//   final Function(String)? onChanged;

//   const SearchTextField({
//     Key? key,
//     this.hintText,
//     this.suffixIcon,
//     this.textEditingController,
//     this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(appProvider);
//     return TextFormField(
//       autofocus: false,
//       style: GoogleFonts.k2d(
//         fontWeight: FontWeight.w500,
//         fontSize: 13.sp,
//         color: state.isDarkMode ? AppColors.white : AppColors.black,
//       ),
//       onChanged: onChanged,
//       controller: textEditingController,
//       cursorColor: state.isDarkMode ? AppColors.white : AppColors.black,
//       cursorWidth: 1,
//       decoration: InputDecoration(
//         hintStyle: GoogleFonts.k2d(
//           fontWeight: FontWeight.w500,
//           fontSize: 13.sp,
//           color: state.isDarkMode
//               ? AppColors.white.withOpacity(0.5)
//               : AppColors.hintColor,
//         ),
//         hintText: hintText ?? AppHelpers.getTranslation(TrKeys.searchProducts),
//         contentPadding: REdgeInsets.symmetric(horizontal: 15, vertical: 17),
//         prefixIcon: Icon(
//           FlutterRemix.search_2_line,
//           size: 20.r,
//           color: state.isDarkMode ? AppColors.white : AppColors.black,
//         ),
//         suffixIcon: suffixIcon,
//         fillColor: state.isDarkMode ? AppColors.mainBackDark : AppColors.white,
//         filled: true,
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: state.isDarkMode ? AppColors.mainBackDark : AppColors.white,
//           ),
//         ),
//         border: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: state.isDarkMode ? AppColors.mainBackDark : AppColors.white,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: state.isDarkMode ? AppColors.mainBackDark : AppColors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
