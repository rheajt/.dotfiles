---@class snacks.image.Config
---@field enabled? boolean enable image viewer
---@field wo? vim.wo|{} options for windows showing the image
---@field bo? vim.bo|{} options for the image buffer
---@field formats? string[]
--- Resolves a reference to an image with src in a file (currently markdown only).
--- Return the absolute path or url to the image.
--- When `nil`, the path is resolved relative to the file.
---@field resolve? fun(file: string, src: string): string?
---@field convert? snacks.image.convert.Config
return {
	formats = {
		"png",
		"jpg",
		"jpeg",
		"gif",
		"bmp",
		"webp",
		"tiff",
		"heic",
		"avif",
		"mp4",
		"mov",
		"avi",
		"mkv",
		"webm",
		"pdf",
	},
	force = false, -- try displaying the image, even if the terminal does not support it
	doc = {
		-- enable image viewer for documents
		-- a treesitter parser must be available for the enabled languages.
		enabled = true,
		-- render the image inline in the buffer
		-- if your env doesn't support unicode placeholders, this will be disabled
		-- takes precedence over `opts.float` on supported terminals
		inline = false,
		-- render the image in a floating window
		-- only used if `opts.inline` is disabled
		float = true,
		max_width = 80,
		max_height = 40,
		-- Set to `true`, to conceal the image text when rendering inline.
		conceal = false, -- (experimental)
	},
	img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
	-- window options applied to windows displaying image buffers
	-- an image buffer is a buffer with `filetype=image`
	wo = {
		wrap = false,
		number = false,
		relativenumber = false,
		cursorcolumn = false,
		signcolumn = "no",
		foldcolumn = "0",
		list = false,
		spell = false,
		statuscolumn = "",
	},
	cache = vim.fn.stdpath("cache") .. "/snacks/image",
	debug = {
		request = false,
		convert = false,
		placement = false,
	},
	env = {},
	---@class snacks.image.convert.Config
	convert = {
		notify = true, -- show a notification on error
		---@type snacks.image.args
		mermaid = function()
			local theme = vim.o.background == "light" and "neutral" or "dark"
			return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
		end,
		---@type table<string,snacks.image.args>
		magick = {
			default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
			vector = { "-density", 192, "{src}[0]" }, -- used by vector images like svg
			math = { "-density", 192, "{src}[0]", "-trim" },
			pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
		},
	},
	math = {
		enabled = true, -- enable math expression rendering
		-- in the templates below, `${header}` comes from any section in your document,
		-- between a start/end header comment. Comment syntax is language-specific.
		-- * start comment: `// snacks: header start`
		-- * end comment:   `// snacks: header end`
		typst = {
			tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
		},
		latex = {
			font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
			-- for latex documents, the doc packages are included automatically,
			-- but you can add more packages here. Useful for markdown documents.
			packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
			tpl = [[
        \documentclass[preview,border=2pt,varwidth,12pt]{standalone}
        \usepackage{${packages}}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
		},
	},
}
