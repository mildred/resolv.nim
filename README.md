resolv.nim
==========

Nim bindings for the glibc resolution library `-lresolv`. it allows to resolve
DNS queries using the system resolver. You don't have to use well-known DNS
resolvers hardcoded or parse configuration files yourself.

**Warning:** this library is probably not thread safe dur to the fact that the
glibc library itself is not thread safe. Use it only in your main thread.

Example
-------

```nim
let rmsg = query("gmail.com", QType.MX)
if rmsg.header.flags.rcode == RCode.NoError:
  for ans in rmsg.answers:
    if ans.type != Type.MX: continue
    echo RDataMX(ans.rdata).preference
    echo RDataMX(ans.rdata).exchange
```
