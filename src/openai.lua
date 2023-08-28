local json = require("json")
local http = require("socket.http")
local ltn12 = require("ltn12")

OpenAI = {}
OpenAI.__index = OpenAI

function OpenAI.new(apikey)
    local self = setmetatable({}, OpenAI)
    self.apiKey = apikey
    return self
end

function OpenAI:POST(url,data)
    local response_body = {}
    local _, response_code, _, _ = http.request {
        url = url,
        method = "POST",
        headers = {["Content-Type"] = "application/json",["Authorization"] = "Bearer " .. self.apikey},
        source = ltn12.source.string(data),
        sink = ltn12.sink.table(response_body)
    }
    return json.decode(table.concat(response_body)) , response_code
end

function OpenAI:GPT(prompt)
    local js , rc = self:POST("https://api.openai.com/v1/engines/davinci/completions",json.encode({
        prompt = prompt ,
        max_tokens = 50
    }))
    if rc == 200 then
        return true , js.choices[0].text
    else
        return false, ""
    end
end

function OpenAI:DALLE(prompt,size,count)
    local js , rc = self:POST("https://api.openai.com/v1/images/generations",json.encode({
            prompt=prompt,
            n=count or 1,
            size = size or "1024x1024"
    }))
    if rc == 200 then
        local urls = {}
        for _, entry in ipairs(js.data) do
            table.insert(urls, entry.url)
        end
        return true , urls
    else
        return false, ""
    end
end

function OpenAI:DALLE_EDIT(prompt,filenam,size,count)
    local files = {
        image = {
            filename = filenam,
            type = "image/png",
            data = assert(io.open(filenam, "rb")):read("*a")
        },
        prompt = {
            filename = nil,
            type = "text/plain",
            data = prompt
        },
        n = {
            filename = nil,
            type = "text/plain",
            data = count or "2"
        },
        size = {
            filename = nil,
            type = "text/plain",
            data = size or "1024x1024"
        }
    }
    local response_body = {}
    local res, status_code, response_headers = http.request{
        url = "https://api.openai.com/v1/images/edits",
        method = "POST",
        headers = {["Content-Type"] = "multipart/form-data",["Authorization"] = "Bearer " .. self.apikey},
        source = ltn12.source.multipart(files),
        sink = ltn12.sink.table(response_body)
    }
    local js = json.decode(table.concat(response_body))
    local urls = {}
    if status_code == 200 then
        for _, entry in ipairs(js.data) do
            table.insert(urls, entry.url)
        end
        return true , urls
    else
        return false, ""
    end
end

function OpenAI:Whisper(filenm)
    local file = io.open(filenm, "rb")
    local fileContent = file:read("*a")
    file:close()
    local requestBody = {
        file = fileContent,
        model = "whisper-1",
    }
    local response = {}
    local success, statusCode, headers, statusText = http.request {
        url = "https://api.openai.com/v1/audio/transcriptions",
        method = "POST",
        headers = {["Content-Type"] = "multipart/form-data",["Authorization"] = "Bearer " .. self.apikey},
        source = ltn12.source.string(requestBody),
        sink = ltn12.sink.table(response),
    }
    local js = json.decode(table.concat(response))
    if statusCode == 200 then
        return true , js.text
    else
        return false, ""
    end
end