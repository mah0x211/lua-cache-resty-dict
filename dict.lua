--[[
  
  Copyright (C) 2014 Masatoshi Teruya

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
 
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
 
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  
  dict.lua
  lua-cache-resty-dict
  
  Created by Masatoshi Teruya on 14/11/17.
  
--]]

-- module
local Cache = require('cache');
local encode = require('cjson.safe').encode;
local decode = require('cjson.safe').decode;

-- class
local CacheDict = require('halo').class.CacheDict;

function CacheDict:init( ttl, name )
    local dict = ngx.shared[name];
    
    if not dict then
        return nil, ('dict %q not found'):format( name );
    end
    protected(self).dict = dict;
    
    return Cache.new( self, ttl );
end


function CacheDict:get( key )
    local res, err = protected(self).dict:get( key );
    
    if res == nil then
        return nil, err;
    end
    
    return decode( res );
end


function CacheDict:set( key, val, ttl )
    local ok, err;
    
    val, err = encode( val );
    -- got error
    if err then
        return false, EENCODE:format( err );
    end
    
    return protected(self).dict:set( key, val, ttl > 0 and ttl or 0 );
end


function CacheDict:delete( key )
    return protected(self).dict:delete( key );
end


return CacheDict.exports;
