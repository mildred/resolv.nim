import strformat

import ./binding
import ./types
export types

type ResolvError* = object of OSError

proc get_error(errno: cint): ref ResolvError =
  result = newException(ResolvError, $strerror(errno))
  result.errorCode = int32(errno)

proc query*(domain: string, class: ns_class, `type`: ns_type, cap: int = 4096): string =
  result = newString(cap)
  var l = res_query(domain, cint(class), cint(`type`), result.cstring, cint(cap));
  if l < 0:
    raise get_error(errno)
  result.set_len l

type RespMsg = ref object
  msg: ns_msg

proc ns_parse*(response: string): RespMsg =
  new(result)
  if ns_initparse(response.cstring, cint(response.len), result.msg) != 0:
    raise get_error(errno)

proc len*(resp: RespMsg, section: ns_sect): int =
  return ns_msg_count(resp.msg, section)

type RespRecord = ref object
  parent*:  RespMsg
  section*: ns_sect
  num*:     int
  rr*:      ns_rr

type RRType  = tuple[`type`: uint16]
type RRClass = tuple[class: uint16]
type RRTtl   = tuple[ttl: uint32]

proc parse*(resp: RespMsg, section: ns_sect, num: int): RespRecord =
  new(result)
  result.parent = resp
  result.section = section
  result.num = num
  discard ns_parserr(resp.msg, section, cint(num), result.rr)

func name*(r: RespRecord): string = $r.rr.name.addr.cstring
func type*(r: RespRecord): RRType = (`type`: uint16(r.rr.type))
func class*(r: RespRecord): RRClass = (class: uint16(r.rr.rr_class))
func ttl*(r: RespRecord): RRTtl = (ttl: r.rr.ttl)
func raw_data*(r: RespRecord): string =
  result = newString(r.rr.rdlength)
  copyMem(result.cstring, r.rr.rdata, r.rr.rdlength)

func `$`*(t: RRType):  string = $p_type(cint(t.type))
func `$`*(t: RRTtl):   string = $p_time(t.ttl)
func `$`*(t: RRClass): string = $p_class(cint(t.class))

proc shift(p: var cstring, distance: int): cstring =
  cast[cstring](cast[int](p.addr) + distance)

proc prio*(r: RespRecord): uint16 =
  case ns_type(r.rr.type)
  of ns_t_mx, ns_t_afsdb, ns_t_rt:
    return uint16(ns_get16(r.rr.rdata))
  of ns_t_srv:
    return uint16(ns_get16(r.rr.rdata))
  else: raise newException(AccessViolationDefect, &"Cannot get priority for {$r.type} record")

proc weight*(r: RespRecord): uint16 =
  case ns_type(r.rr.type)
  of ns_t_srv:
    return uint16(ns_get16(shift(r.rr.rdata, NS_INT16SZ)))
  else: raise newException(AccessViolationDefect, &"Cannot get weight for {$r.type} record")

proc port*(r: RespRecord): uint16 =
  case ns_type(r.rr.type)
  of ns_t_srv:
    return uint16(ns_get16(shift(r.rr.rdata, 2 * NS_INT16SZ)))
  else: raise newException(AccessViolationDefect, &"Cannot get port for {$r.type} record")

proc target*(r: RespRecord): string =
  case ns_type(r.rr.type)
  of ns_t_mx, ns_t_afsdb, ns_t_rt:
    return $shift(r.rr.rdata, NS_INT16SZ)
  of ns_t_srv:
    return $shift(r.rr.rdata, 3 * NS_INT16SZ)
  else: raise newException(AccessViolationDefect, &"Cannot get target for {$r.type} record")

proc `$`*(r: RespRecord): string =
  let cap = NS_MAXDNAME + r.rr.rdlength + 1024
  result = newString(cap)
  let l = ns_sprintrr(r.parent.msg, r.rr, nil, nil, result.cstring, cint(cap))
  if l < 0:
    raise get_error(errno)
  result.set_len l

