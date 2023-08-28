local openai = require("openai")

-- Initialize the OpenAI instance with your API key
local apikey = "YOUR_OPENAI_API_KEY"
local ai = openai.new(apikey)

-- Transcript voice with Whisper
local file_name = "hi.mp3"
local success, text = ai:Whisper(file_name)
if success then
    print("You said : " .. text)
else
    print("Voice transcriptions failed.")
end