return {
	"chrisgrieser/nvim-origami",
	event = "VeryLazy",
	opts = {
	foldtextWithLineCount = {
		enabled = package.loaded["ufo"] == nil,
		template = "  󰁂  %s", -- `%s` gets the number of folded lines
		hlgroupForCount = "Comment",
	},
    }, -- needed even when using default config
}
