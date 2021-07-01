# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import resolv/mixed

test "print mx":
  let msg = query("mildred.fr", QType.MX)
  check msg.answers.len == 1
  let ans = msg.answers[0]
  check ans.name == "mildred.fr."
  check $ans.`type` == "MX"
  check $ans.class == "IN"
  let mx = RDataMX(ans.rdata)
  check $mx.exchange == "mailu.mildred.fr."
