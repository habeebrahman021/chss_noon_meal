import 'package:equatable/equatable.dart';

class Count extends Equatable {
  const Count({
    required this.boysCount,
    required this.girlsCount,
  });

  final int boysCount;
  final int girlsCount;

  @override
  List<Object?> get props => [
        boysCount,
        girlsCount,
      ];
}
