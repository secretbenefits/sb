#include "ruby.h"

VALUE hamming_filter(VALUE _self, VALUE _bin_str, VALUE _filter, VALUE _distance, VALUE _limit) {
  const uint64_t filter = NUM2ULL(_filter);
  const long distance = NUM2ULONG(_distance);
  const long limit = NUM2ULONG(_limit);
  long result_num = 0;
  uint64_t *value = (uint64_t *)RSTRING_PTR(_bin_str);
  const long value_num = RSTRING_LEN(_bin_str) / sizeof(uint64_t);
  const uint64_t *last = value + value_num;
  VALUE result = rb_ary_new_capa(limit);

  Check_Type(_bin_str, T_STRING);
  Check_Type(_distance, T_FIXNUM);
  Check_Type(_limit, T_FIXNUM);

  if (limit < 1)
    return result;

  for (; value < last; value++) {
    if (__builtin_popcountll(filter ^ *value) <= distance) {
      rb_ary_store(result, result_num, ULL2NUM(*value));
      if (++result_num >= limit)
        break;
    }
  }

  return result;
}

void Init_sb_ext() {
  VALUE Sb = rb_const_get(rb_cObject, rb_intern("Sb"));
  rb_define_module_function(Sb, "hamming_filter", hamming_filter, 4);
}
