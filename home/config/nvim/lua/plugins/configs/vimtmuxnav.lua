return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		enabled = function() -- Load if using tmux
			return os.getenv("TMUX") ~= nil
		end,
	},
}
