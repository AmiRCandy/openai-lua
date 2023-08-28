package = "openai"
version = "0.1-1"
source = {
  url = "https://github.com/AmiRCandy/openai-lua.git",
  tag = "v0.1-1"
}
description = {
  summary = "A Lua library for OpenAI API interactions.",
  detailed = [[
    This library provides a convenient way to interact with the OpenAI API using Lua.
    It includes functions for GPT-3 completions, image generations, and more.
  ]],
  homepage = "https://github.com/AmiRCandy/openai-lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.1",
  "luasocket >= 3.0",
  "lua-cjson >= 2.1.0"
}
build = {
  type = "builtin",
  modules = {
    ["openai"] = "src/openai.lua"
  }
}
