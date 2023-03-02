if not pcall(require, 'luasnip') then
    return
end

local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep


-- Configure LuaSnip
ls.config.set_config({

	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = true,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	update_events = 'TextChanged,TextChangedI',

	-- Autosnippets:
	enable_autosnippets = true,

	delete_check_events = 'TextChanged',

	-- Use <Tab> (or some other key if you prefer) to trigger visual selection
	store_selection_keys = "<Tab>",
})

-- Expand and set my keybindings to jump to next or previous item if available.
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = false })

vim.keymap.set({ 'i', 's' }, '<C-j>', function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

--[[ *** Anatomy of a snippet
	require('luasnip').snippet(
		snip_params:table,  -- table of snippet parameters
		nodes:table,        -- table of snippet nodes
		opts:table|nil      -- *optional* table of additional snippet options
	)
]]
-- })

-- *** Modules ***
-- This is the `get_visual` function I've been talking about.
-- ----------------------------------------------------------------------------

-- *** Snippets ***
-- ls.add_snippets('all', {
-- 	s(
-- 		{ -- Table 1: snippet parameters
-- 			trig = 'nsfw-tag',
-- 			dscr = 'Please put NSFW tag on this.',
-- 			regTrig = false,
-- 			priority = 100,
-- 			snippetType = 'snippet'
-- 		},
-- 		{ -- Table 2: snippet nodes (don't worry about this for now---we'll cover nodes shortly)
-- 			t(
-- 				{ "Please put an NSFW tag on this. I was on the train and when I saw this I had to",
-- 					"start furiously masturbating. Everyone else gave me strange looks and were",
-- 					"saying things like “what the fuck” and “call the police”. I dropped my phone",
-- 					"and everyone around me saw this image. Now there is a whole train of men",
-- 					"masturbating together at this one image. This is all your fault, you could have",
-- 					"prevented this if you had just tagged this post NSFW.", }
-- 			), -- A single text node
-- 		}
-- 	-- Table 3, the advanced snippet options, is left blank.
-- 	),
--
-- 	s("example4", fmt([[
--   repeat {a} with the same key {a}
--             ]], {
-- 		a = i(1, "this will be repeat")
-- 	}, {
-- 		repeat_duplicates = true
-- 	}))
--
-- })

-- LaTeX
ls.add_snippets({ 'plaintex', 'tex' }, {
	-- Template
	s('template', fmt(
		[[
            \documentclass{<>}

            \usepackage{<>}

            \title{<>}
            \author{<>}

            \begin{document}

            \maketitle

            <>

            \end{document}
            ]],
		{
			i(1, 'article'),
			i(4, 'hyperref'),
			i(2, 'Awesome Title'),
			i(3, 'Author'),
			i(0, ''),
		},
		{ delimiters = "<>" }
	)),

})

-- PHP Blade
-- ls.add_snippets('php', {
-- 	-- foreach
-- 	s('@foreach', fmt(
-- 		[[
-- 		@foreach (${} as ${})
-- 		{}
-- 		@endforeach
-- 		]],
-- 		{
-- 			i(1, 'array'),
-- 			i(2, 'item'),
-- 			i(0, '{{-- code... --}}'),
-- 		}
-- 	)),
--
-- 	-- if
-- 	s('@if', fmt(
-- 		[[
-- 		@if ({})
-- 		{}
-- 		@endif
-- 		]],
-- 		{
-- 			i(1, ''),
-- 			i(0, '{{-- code... --}}'),
-- 		}
-- 	)),
--
-- 	-- else if
-- 	s('@elif', fmt(
-- 		[[
-- 		@if ({})
-- 		{}
-- 		@elseif ({})
-- 		{}
-- 		@else ({})
-- 		{}
-- 		@endif
-- 		]],
-- 		{
-- 			i(1, ''),
-- 			i(2, '{{-- code... --}}'),
-- 			i(3, ''),
-- 			i(4, '{{-- code... --}}'),
-- 			i(5, ''),
-- 			i(0, '{{-- code... --}}'),
-- 		}
-- 	)),
--
-- 	-- if else
-- 	s('@ifelse', fmt(
-- 		[[
-- 		@if ({})
-- 		{}
-- 		@else
-- 		{}
-- 		@endif
-- 		]],
-- 		{
-- 			i(1, ''),
-- 			i(2, '{{-- code... --}}'),
-- 			i(0, '{{-- code... --}}'),
-- 		}
-- 	)),
--
-- 	-- extends
-- 	s('@extends', fmt('@extends(\'{}\')\n{}', {
-- 		i(1, 'layouts.blade.php'),
-- 		i(0, ''),
-- 	})),
--
-- 	-- yield
-- 	s('@yield', fmt('@yield(\'{}\')\n{}', {
-- 		i(1, 'content'),
-- 		i(0, ''),
-- 	})),
--
-- 	-- props
-- 	s('@props', fmt('@props([\'{}\'{}])\n{}', {
-- 		i(1, 'props'),
-- 		i(2, ''),
-- 		i(0, ''),
-- 	})),
--
-- 	-- sections
-- 	s('@sections', fmt(
-- 		[[
-- 		@section('{}')
-- 		{}
-- 		@endsection
-- 		]], {
-- 		i(1, 'content'),
-- 		i(0, '{{-- code... --}}'),
-- 	})),
--
-- 	-- include
-- 	s('@include', fmt('@include(\'{}\')\n{}', {
-- 		i(1, 'partials.something'),
-- 		i(0, ''),
-- 	})),
--
-- 	-- component
-- 	s('@component', fmt(
-- 		[[
-- 		@component('{}'{})
-- 		{}
-- 		@endcomponent
-- 		]], {
-- 		i(1, 'component.panel'),
-- 		i(2, ''),
-- 		i(0, ''),
-- 	})),
--
-- 	-- slot
-- 	s('@slot', fmt(
-- 		[[
-- 		@slot('{}')
-- 		{}
-- 		@endslot
-- 		]], {
-- 		i(1, 'footer'),
-- 		i(0, ''),
-- 	})),
--
-- 	-- error
-- 	s('@error', fmt(
-- 		[[
-- 		@error('{}')
-- 		{}
-- 		@enderror
-- 		]], {
-- 		i(1, '{{-- name of the field --}}'),
-- 		i(0, ''),
-- 	})),
--
-- 	-- unless
-- 	s('@unless', fmt(
-- 		[[
-- 		@unless('{}')
-- 		{}
-- 		@endunless
-- 		]], {
-- 		i(1, ''),
-- 		i(0, '{{-- code... --}}'),
-- 	})),
--
-- 	-- php
-- 	s('@php', fmt(
-- 		[[
-- 		@php
-- 		{}
-- 		@endphp
-- 		]], {
-- 		i(1, ''),
-- 	})),
--
-- 	-- cross sites scripting xss
-- 	s('@csrf', t('@csrf')),
--
-- 	-- method directive
-- 	s('@method', fmt([[@method('{}')]], i(1, 'PUT'))),
--
-- 	-- echo
-- 	s({ trig = '{{', snippetType = 'autosnippet' }, fmt('{{ <> }}', { i(1, '') }, { delimiters = "<>" })),
--
-- 	--route
-- 	s('route', fmt('{{ route(\'<>\') }}', { i(1, 'name') }, { delimiters = '<>' })),
--
-- 	-- asset
-- 	s('asset', fmt('{{ asset(\'<>\') }}', { i(1, 'path') }, { delimiters = '<>' })),
--
-- 	-- url
-- 	s('url', fmt('{{ url(\'<>\') }}', { i(1, 'url') }, { delimiters = '<>' })),
--
-- 	-- config
-- 	s('config', fmt('{{ config(\'<>\') }}', { i(1, 'app.name') }, { delimiters = '<>' })),
--
-- 	-- comment {{-- --}}
-- 	s('--', fmt('{{-- <> --}}', { i(1, '') }, { delimiters = '<>' })),

})

