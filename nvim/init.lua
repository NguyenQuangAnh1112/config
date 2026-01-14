-- Khởi tạo cấu hình
require("core.options")
require("core.keymaps")

-- Cài plugin qua lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end

vim.o.autoread = true
vim.opt.rtp:prepend(lazypath)

-- Cho phép gf tìm file trong thư mục con
vim.opt.path:append("**")

-- Cho phép tìm file không có phần mở rộng rõ ràng
vim.opt.suffixesadd:append(".norg")

-- Thiết lập Lazy.nvim, yêu cầu nó quản lý luarocks bằng hererocks
require("lazy").setup("plugins", {
  rocks = {
    enabled = true,
    hererocks = true,
  },
})
