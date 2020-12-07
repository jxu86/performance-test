--
--wrk api:
--function wrk.format(method, path, headers, body)
--

require("scripts/keys8k")
require("scripts/postdata")

KEYS = keys8k.KEYS

-- set header
wrk.headers["Content-Type"] = "application/json"

-- global variabl
writeapi = "/api/v1/cc/invoke"
counter = 1
queryapi = ""

function read()
  return wrk.format("GET", queryapi)
end

function write()
  local body = postdata.d8k1000101
  return wrk.format("POST", writeapi, nil, body)
end


-- wrk request interface
request = function()
  local key = KEYS[counter]
  queryapi = string.format("/api/v1/cc/query?arg=%s&ccid=landproperty", key)
  counter = counter + 1
  if(counter > #KEYS)
  then
    counter = 1
  end

  local r = {}
  r[1] = read()
  r[2] = write()
  req = table.concat(r)
  return req
end

