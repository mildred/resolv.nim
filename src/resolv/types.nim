type
  ns_sect*  = cint
  ns_class* = cint
  ns_type*  = cint

const
  NS_PACKETSZ*    = 512    #/*%< default UDP packet size */
  NS_MAXDNAME*    = 1025   #/*%< maximum domain name */
  NS_MAXMSG*      = 65535  #/*%< maximum message size */
  NS_MAXCDNAME*   = 255    #/*%< maximum compressed domain name */
  NS_MAXLABEL*    = 63     #/*%< maximum length of domain label */
  NS_HFIXEDSZ*    = 12     #/*%< #/bytes of fixed data in header */
  NS_QFIXEDSZ*    = 4      #/*%< #/bytes of fixed data in query */
  NS_RRFIXEDSZ*   = 10     #/*%< #/bytes of fixed data in r record */
  NS_INT32SZ*     = 4      #/*%< #/bytes of data in a uint32_t */
  NS_INT16SZ*     = 2      #/*%< #/bytes of data in a uint16_t */
  NS_INT8SZ*      = 1      #/*%< #/bytes of data in a uint8_t */
  NS_INADDRSZ*    = 4      #/*%< IPv4 T_A */
  NS_IN6ADDRSZ*   = 16     #/*%< IPv6 T_AAAA */
  NS_CMPRSFLGS*   = 0xc0   #/*%< Flag bits indicating name compression. */
  NS_DEFAULTPORT* = 53     #/*%< For both TCP and UDP. */

  # ns_sect
  ns_s_qd*:  ns_sect = 0 #/*%< Query: Question. */
  ns_s_zn*:  ns_sect = 0 #/*%< Update: Zone. */
  ns_s_an*:  ns_sect = 1 #/*%< Query: Answer. */
  ns_s_pr*:  ns_sect = 1 #/*%< Update: Prerequisites. */
  ns_s_ns*:  ns_sect = 2 #/*%< Query: Name servers. */
  ns_s_ud*:  ns_sect = 2 #/*%< Update: Update. */
  ns_s_ar*:  ns_sect = 3 #/*%< Query|Update: Additional records. */
  ns_s_max*: ns_sect = 4

  # ns_class
  ns_c_invalid*: ns_class = 0   #/*%< Cookie. */
  ns_c_in*:      ns_class = 1   #/*%< Internet. */
  ns_c_2*:       ns_class = 2   #/*%< unallocated/unsupported. */
  ns_c_chaos*:   ns_class = 3   #/*%< MIT Chaos-net. */
  ns_c_hs*:      ns_class = 4   #/*%< MIT Hesiod. */
  #/* Query class values which do not appear in resource records */
  ns_c_none*: ns_class = 254    #/*%< for prereq. sections in update requests */
  ns_c_any*:  ns_class = 255    #/*%< Wildcard match. */
  ns_c_max*:  ns_class = 65536

  # ns_type
  ns_t_invalid*: ns_type = 0
  ns_t_a*: ns_type = 1
  ns_t_ns*: ns_type = 2
  ns_t_md*: ns_type = 3
  ns_t_mf*: ns_type = 4
  ns_t_cname*: ns_type = 5
  ns_t_soa*: ns_type = 6
  ns_t_mb*: ns_type = 7
  ns_t_mg*: ns_type = 8
  ns_t_mr*: ns_type = 9
  ns_t_null*: ns_type = 10
  ns_t_wks*: ns_type = 11
  ns_t_ptr*: ns_type = 12
  ns_t_hinfo*: ns_type = 13
  ns_t_minfo*: ns_type = 14
  ns_t_mx*: ns_type = 15
  ns_t_txt*: ns_type = 16
  ns_t_rp*: ns_type = 17
  ns_t_afsdb*: ns_type = 18
  ns_t_x25*: ns_type = 19
  ns_t_isdn*: ns_type = 20
  ns_t_rt*: ns_type = 21
  ns_t_nsap*: ns_type = 22
  ns_t_nsap_ptr*: ns_type = 23
  ns_t_sig*: ns_type = 24
  ns_t_key*: ns_type = 25
  ns_t_px*: ns_type = 26
  ns_t_gpos*: ns_type = 27
  ns_t_aaaa*: ns_type = 28
  ns_t_loc*: ns_type = 29
  ns_t_nxt*: ns_type = 30
  ns_t_eid*: ns_type = 31
  ns_t_nimloc*: ns_type = 32
  ns_t_srv*: ns_type = 33
  ns_t_atma*: ns_type = 34
  ns_t_naptr*: ns_type = 35
  ns_t_kx*: ns_type = 36
  ns_t_cert*: ns_type = 37
  ns_t_a6*: ns_type = 38
  ns_t_dname*: ns_type = 39
  ns_t_sink*: ns_type = 40
  ns_t_opt*: ns_type = 41
  ns_t_apl*: ns_type = 42
  ns_t_ds*: ns_type = 43
  ns_t_sshfp*: ns_type = 44
  ns_t_ipseckey*: ns_type = 45
  ns_t_rrsig*: ns_type = 46
  ns_t_nsec*: ns_type = 47
  ns_t_dnskey*: ns_type = 48
  ns_t_dhcid*: ns_type = 49
  ns_t_nsec3*: ns_type = 50
  ns_t_nsec3param*: ns_type = 51
  ns_t_tlsa*: ns_type = 52
  ns_t_smimea*: ns_type = 53
  ns_t_hip*: ns_type = 55
  ns_t_ninfo*: ns_type = 56
  ns_t_rkey*: ns_type = 57
  ns_t_talink*: ns_type = 58
  ns_t_cds*: ns_type = 59
  ns_t_cdnskey*: ns_type = 60
  ns_t_openpgpkey*: ns_type = 61
  ns_t_csync*: ns_type = 62
  ns_t_spf*: ns_type = 99
  ns_t_uinfo*: ns_type = 100
  ns_t_uid*: ns_type = 101
  ns_t_gid*: ns_type = 102
  ns_t_unspec*: ns_type = 103
  ns_t_nid*: ns_type = 104
  ns_t_l32*: ns_type = 105
  ns_t_l64*: ns_type = 106
  ns_t_lp*: ns_type = 107
  ns_t_eui48*: ns_type = 108
  ns_t_eui64*: ns_type = 109
  ns_t_tkey*: ns_type = 249
  ns_t_tsig*: ns_type = 250
  ns_t_ixfr*: ns_type = 251
  ns_t_axfr*: ns_type = 252
  ns_t_mailb*: ns_type = 253
  ns_t_maila*: ns_type = 254
  ns_t_any*: ns_type = 255
  ns_t_uri*: ns_type = 256
  ns_t_caa*: ns_type = 257
  ns_t_avc*: ns_type = 258
  ns_t_ta*: ns_type = 32768
  ns_t_dlv*: ns_type = 32769
  ns_t_max*: ns_type = 65536

type
  ns_msg* {.importc: "ns_msg", header: "<arpa/nameser.h>"} = object
    msg:      cstring
    eom:      cstring
    id:       uint16
    flags:    uint16
    counts:   array[ns_s_max, uint16]
    sections: array[ns_s_max, cstring]
    sect:     ns_sect
    rrnum:    cint
    msg_ptr:  cstring

  ns_rr* {.importc: "ns_rr", header: "<arpa/nameser.h>".} = object
    name*:     array[NS_MAXDNAME, char]
    `type`*:   uint16
    rr_class*: uint16
    ttl*:      uint32
    rdlength*: uint16
    rdata*:    cstring

