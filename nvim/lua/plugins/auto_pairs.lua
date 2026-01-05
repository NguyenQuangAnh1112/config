return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true, -- dùng cây cú pháp (treesitter) để khôn hơn
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)

    -- tích hợp với nvim-cmp nếu bạn dùng auto-complete
    local cmp_ok, cmp = pcall(require, "cmp")
    if cmp_ok then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}

