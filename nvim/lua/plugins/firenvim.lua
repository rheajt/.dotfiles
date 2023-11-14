return {
	"glacambre/firenvim",
	enabled = false,
	build = function()
		vim.fn["firenvim#install"](0)
	end,
}
