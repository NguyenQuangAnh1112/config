return {
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({
      filetype = {
        python = {
          "cd $dir &&", -- Thêm dòng này: Chuyển vào thư mục chứa file
          "python3 -u $fileName",
        },
        cpp = {
          "cd $dir &&",
          "g++ $fileName -o $fileNameWithoutExt -Wall -std=c++17 &&",
          "./$fileNameWithoutExt",
        },
      },
      mode = "term",
      focus = true,
      startinsert = false,
    })
    -- Keymap for running code
    vim.keymap.set("n", "<leader>r", ":w<CR>:RunCode<CR>", { noremap = true, silent = false })
  end,
}
