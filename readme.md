
# OpenAI Lua

A simple and small library of OpenAI(GPT , DALLE , Whisper) Projects for Lua 

## Usage/Examples

```lua
local openai = require("openai")

-- Initialize the OpenAI instance with your API key
local apikey = "YOUR_OPENAI_API_KEY"
local ai = openai.new(apikey)

-- Generate text with GPT
local prompt = "Once upon a time"
local success, text = ai:GPT(prompt)
if success then
    print("Generated text:", text)
else
    print("Text generation failed.")
end

-- Generate image with DALLE
local prompt = "A cat"
local size = "1024x1024"
local count = 4
local success, urls = ai:DALLE(prompt,size,count) -- Size and count is optoinal
if success then
    for _, url in ipairs(urls) do
      print("URL:", url)
    end
else
    print("Image generation failed.")
end

-- Edit image with DALLE
local prompt = "A cat"
local file_name = "hi.png"
local size = "1024x1024"
local count = "4"
local success, urls = ai:DALLE_EDIT(prompt,file_name,size,count) -- Size and count optional
if success then
    for _, url in ipairs(urls) do
      print("URL:", url)
    end
else
    print("Edit image failed.")
end

-- Transcript voice with Whisper
local file_name = "hi.mp3"
local success, text = ai:Whisper(file_name)
if success then
    print("You said : " .. text)
else
    print("Voice transcriptions failed.")
end
```


## Author

- [@AmiRCandy](https://www.github.com/AmiRCandy)

