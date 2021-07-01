{.passL: "-lresolv".}

import types
export types

from posix import strerror, errno
export strerror, errno

proc res_init*(): cint {.importc, header: "<resolv.h>".}

proc res_query*(dname: cstring, class: ns_class, `type`: ns_type, answer: cstring, anslen: cint): cint {.importc, header: "<resolv.h>".}

proc ns_initparse*(answer: cstring, anslen: cint, msg: var ns_msg): cint {.importc, header: "<arpa/nameser.h>".}

proc ns_msg_count*(msg: ns_msg, section: cint): cint {.importc, header: "<arpa/nameser.h>".}

proc ns_parserr*(msg: var ns_msg, sect: ns_sect, num: cint, rr: var ns_rr): cint {.importc, header: "<arpa/nameser.h>".}

proc ns_sprintrr*(msg: var ns_msg, rr: var ns_rr, s1: cstring, s2: cstring, buf: cstring, buflen: cint): cint {.importc, header: "<arpa/nameser.h>".}

proc ns_get16*(data: cstring): cuint {.importc, header: "<arpa/nameser.h>".}

proc ns_get32*(data: cstring): culong {.importc, header: "<arpa/nameser.h>".}

func p_class*(c: cint): cstring {.importc, header: "<resolv.h>".}

func p_time*(c: uint32): cstring {.importc, header: "<resolv.h>".}

func p_type*(c: cint): cstring {.importc, header: "<resolv.h>".}

func p_rcode*(c: cint): cstring {.importc, header: "<resolv.h>".}
