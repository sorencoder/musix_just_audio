// import 'package:flutter/material.dart';

// class BufferedSlider extends StatelessWidget {
//   final Duration duration;
//   final Duration position;
//   final Duration bufferedPosition;
//   final ValueChanged<double> onChangeEnd;
//   final ValueChanged<double> onChanged;

//   const BufferedSlider({
//     Key? key,
//     required this.duration,
//     required this.position,
//     required this.bufferedPosition,
//     required this.onChangeEnd,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final double durationInSeconds = duration.inSeconds.toDouble();
//     final double positionInSeconds = position.inSeconds.toDouble();
//     final double bufferedInSeconds = bufferedPosition.inSeconds.toDouble();

//     return Stack(
//       children: [
//         Slider(
//           min: 0,
//           max: durationInSeconds,
//           value: positionInSeconds,
//           onChangeEnd: onChangeEnd,
//           onChanged: onChanged,
//           activeColor: Colors.blue,
//           inactiveColor: Colors.grey,
//         ),
//         if (durationInSeconds > 0) // Ensure duration is positive
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 1,
//               color: Colors.blue.withOpacity(0.5),
//               width: bufferedInSeconds /
//                   durationInSeconds *
//                   MediaQuery.of(context).size.width,
//             ),
//           ),
//       ],
//     );
//   }
// }
