local openai = require("openai")

-- Initialize the OpenAI instance with your API key
local apikey = "YOUR_OPENAI_API_KEY"
local ai = openai.new(apikey)

-- Generate text with GPT
local prompt = "Hello gpt"
local success, text = ai:GPT(prompt)
if success then
    print("Generated text:", text)
else
    print("Text generation failed.")
end