import ./binding

# Convertion of https://stackoverflow.com/questions/1093410/pulling-mx-record-from-dns-server
proc print_mx*(domain: string): bool =
  const nsbuf_cap = 4096
  var nsbuf = newString(nsbuf_cap)

  const dispbuf_cap = 4096
  var dispbuf = newString(dispbuf_cap)

  var l = res_query(domain, ns_c_any, ns_t_mx, nsbuf.cstring, nsbuf_cap);
  if l < 0:
    echo strerror(errno)
    return false
  else:
    nsbuf.set_len l

  var msg = new(ns_msg)

  # just grab the MX answer info
  discard ns_initparse(nsbuf.cstring, l, msg[])
  let count = ns_msg_count(msg[], ns_s_an)
  for j in 0..count:
    var rr = new(ns_rr)
    discard ns_parserr(msg[], ns_s_an, j, rr[])
    discard ns_sprintrr(msg[], rr[], nil, nil, dispbuf.cstring, dispbuf_cap)
    echo dispbuf.cstring
  return true
