import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'meterreader_state.dart';

class MeterreaderCubit extends Cubit<MeterreaderState> {
  MeterreaderCubit() : super(MeterreaderInitial());
}
