import 'package:hi_core/src/model/model.dart';

typedef HiDynamicCallback = dynamic Function(dynamic value);
typedef HiCellPressed<M extends HiModel> = void Function(M model,
    {dynamic extra});