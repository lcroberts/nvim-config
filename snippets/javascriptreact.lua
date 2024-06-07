local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require 'luasnip.extras.expand_conditions'
local postfix = require('luasnip.extras.postfix').postfix
local types = require 'luasnip.util.types'
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet
local k = require('luasnip.nodes.key_indexer').new_key

local function get_filename()
  local file = vim.fn.expand '%'
  return string.sub(file, 1, string.len(file) - 4)
end

return {
  s(
    {
      trig = 'rfc',
      name = 'react functional component',
      priority = 2000,
    },
    fmt(
      [[
	import React from 'react'

	export default function {1}({2}) {{
	  return (
	    <div>
	      {}
	    </div>
	  )
	}}
	  ]],
      {
        i(1, get_filename()),
        i(2),
        i(0),
      }
    )
  ),
  s(
    {
      trig = 'rfce',
      name = 'react functional component export',
      priority = 2000,
    },
    fmt(
      [[
	import React from 'react'

	function {1}({2}) {{
	  return (
	    <div>
	      {4}
	    </div>
	  )
	}}

	export default {3}
  	  ]],
      {

        i(1, get_filename()),
        i(2),
        rep(1),
        i(0),
      }
    )
  ),
}
