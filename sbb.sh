{
    "log": {
        "level": "error,
        "timestamp": true
    },
    "dns": {
        "servers": [
            {
                "tag": "dns_proxy",
                "address": "https://8.8.8.8/dns-query",
                "address_resolver": "dns_resolver",
                "strategy": "prefer_ipv4",
                "detour": "proxy"
            },
            {
                "tag": "dns_direct",
                "address": "https://223.5.5.5/dns-query",
                "address_resolver": "dns_resolver",
                "strategy": "prefer_ipv4",
                "detour": "direct"
            },
            {
                "tag": "dns_resolver",
                "address": "114.114.114.114",
                "detour": "direct"
            }
        ],
        "rules": [
            {
                "outbound": "any",
                "server": "dns_resolver"
            },
            {
                "rule_set": "geosite-geolocation-!cn",
                "query_type": [
                    "A",
                    "AAAA"
                ],
                "server": "dns_fakeip"
            },
            {
                "rule_set": "geosite-geolocation-!cn",
                "query_type": [
                    "CNAME"
                ],
                "server": "dns_proxy"
            },
            {
                "query_type": [
                    "A",
                    "AAAA",
                    "CNAME"
                ],
                "invert": true,
                "server": "dns_refused",
                "disable_cache": true
            }
        ],
        "final": "dns_direct",
        "independent_cache": true,
        "fakeip": {
            "enabled": true,
            "inet4_range": "198.18.0.0/15",
            "inet6_range": "fc00::/18"
        }
    },
    "route": {
        "rule_set": [
            {
                "tag": "geosite-geolocation-!cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-geolocation-!cn.srs",
                "download_detour": "proxy"
            },
            {
                "tag": "geoip-cn",
                "type": "remote",
                "format": "binary",
                "url": "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs",
                "download_detour": "proxy"
            }
        ],
        "rules": [
            {
                "protocol": "dns",
                "outbound": "dns-out"
            },
            {
                "process_name": [
                    "xray.exe",
                    "hysteria.exe",
                    "IDMan.exe"
                ],
                "outbound": "direct"
            },
            {
                "port": 853,
                "network": "tcp",
                "outbound": "block"
            },
            {
                "port": 443,
                "network": "udp",
                "outbound": "block"
            },
            {
                "rule_set": "geosite-geolocation-!cn",
                "outbound": "proxy"
            },
            {
                "rule_set": "geoip-cn",
                "outbound": "direct"
            },
            {
                "ip_is_private": true,
                "outbound": "direct"
            }
        ],
        "final": "proxy",
        "auto_detect_interface": true
    },
    "inbounds": [
        {
            "type": "tun",
            "tag": "tun-in",
            "inet4_address": "172.16.0.1/30",
            "inet6_address": "fd00::1/126",
            "mtu": 1492,
            "auto_route": true,
            "strict_route": true,
            "stack": "system",
            "sniff": true,
            "sniff_override_destination": false
        }
    ],
    "outbounds": [
        {
            "type": "shadowsocks",
            "tag": "proxy",
            "server": "82ebf39a-b624-463d-a4da-3d644a4749a9.piaopiaocf.pp.ua",
            "server_port": 25229,
            "method": "chacha20-ietf-poly1305",
            "password": "hkhk",
            "multiplex": {
                "enabled": false
            }
        },
        {
            "type": "direct",
            "tag": "direct"
        },
        {
            "type": "block",
            "tag": "block"
        },
        {
            "type": "dns",
            "tag": "dns-out"
        }
    ],
    "experimental": {
        "cache_file": {
            "enabled": true,
            "path": "cache.db",
            "store_fakeip": true,
            "store_rdrc": true
        }
    }
}
