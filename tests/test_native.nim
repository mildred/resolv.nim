# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import resolv/native

test "print mx":
  let resp = query("mildred.fr", ns_c_any, ns_t_mx)
  let msg = ns_parse(resp)
  check msg.len(ns_s_an) == 1
  check msg.parse(ns_s_an, 0).name == "mildred.fr"
  echo $msg.parse(ns_s_an, 0)
  check $msg.parse(ns_s_an, 0).`type` == "MX"
  check $msg.parse(ns_s_an, 0).class == "IN"
  #check $msg.parse(ns_s_an, 0).text == "mailu.mildred.fr."
