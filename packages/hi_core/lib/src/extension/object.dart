import 'package:hi_core/src/error.dart';

extension ObjectHiCoreEx on Object {
  HiError get hiError {
    // YJX_TODO CastError
    if (this is HiError) {
      return this as HiError;
    }
    return HiAppError(-1, this.toString());
  }
}
