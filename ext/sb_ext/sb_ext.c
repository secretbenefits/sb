#include "ruby.h"

VALUE Sb = Qnil;

VALUE hamming_filter(VALUE _self, VALUE _array, VALUE _filter, VALUE _distance, VALUE _limit) {
  long row;
  long rows = RARRAY_LEN(_array);
  unsigned long long filter = NUM2ULL(_filter);
  long distance = NUM2ULONG(_distance);
  long limit = NUM2ULONG(_limit);
  long result_num = 0;
  VALUE result = rb_ary_new_capa(limit);

  Check_Type(_array, T_ARRAY);
  Check_Type(_distance, T_FIXNUM);
  Check_Type(_limit, T_FIXNUM);

  if (limit < 1)
    return result;

  for (row = 0; row < rows; row++) {
    VALUE value = rb_ary_entry(_array, row);
    if (__builtin_popcountll(filter ^ NUM2ULL(value)) <= distance) {
      rb_ary_store(result, result_num, value);
      if (++result_num >= limit)
        break;
    }
  }

  return result;
}

void Init_sb_ext() {
  Sb = rb_const_get(rb_cObject, rb_intern("Sb"));
  rb_define_module_function(Sb, "hamming_filter", hamming_filter, 4);
}
