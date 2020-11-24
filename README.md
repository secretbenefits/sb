# Sb

## `hamming_filter(binstr, filter, distance, limit)`

Filter `binstr` returning array of at most `limit` values within hamming `distance` from provided `filter` value.
Provided `binstr` must be an array of numbers packed using `Q` modifier, eg `[1, 2, 3].pack('Q*')`.
