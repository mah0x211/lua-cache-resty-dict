package = "cache-resty-dict"
version = "1.1.1-1"
source = {
    url = "git://github.com/mah0x211/lua-cache-resty-dict.git",
    tag = "v1.1.1"
}
description = {
    summary = "lua_shared_dict storage plugin for lua-cache module.",
    homepage = "https://github.com/mah0x211/lua-cache-resty-dict", 
    license = "MIT/X11",
    maintainer = "Masatoshi Teruya"
}
dependencies = {
    "lua >= 5.1",
    "cache >= 1.0.1",
    "halo >= 1.1.0",
    "lua-cjson >= 2.1.0"
}
build = {
    type = "builtin",
    modules = {
        ["cache.resty.dict"] = "dict.lua"
    }
}

