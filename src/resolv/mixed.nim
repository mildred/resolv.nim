import dnsprotocol

import ./binding
import ./types
import ./native

export ResolvError
export dnsprotocol

proc query*(q: Question, cap: int = 4096): Message =
  let res = native.query(q.qname, ns_class(q.qclass), ns_type(q.qtype), cap)
  result = parseMessage(res)

proc query*(qname: string, qtype: QType, qclass: QClass = QClass.IN): Message =
  query(initQuestion(qname, qtype, qclass))
