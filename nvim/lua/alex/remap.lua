vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>rn", function()
  local old = vim.fn.expand("<cword>")
  vim.ui.input({ prompt = "Rename '" .. old .. "' to: " }, function(new)
    if not new or new == "" then return end

    local raw = vim.fn.system({ "grep", "-rn", "--include=*.h", "--include=*.hpp",
      "--include=*.cpp", "--include=*.cc", "--include=*.c", "--include=*.lua",
      "-w", old, "." })

    if vim.v.shell_error ~= 0 and raw == "" then
      vim.notify("No occurrences of: " .. old)
      return
    end

    local qflist = {}
    for line in raw:gmatch("[^\n]+") do
      local fname, lnum, text = line:match("^(.+):(%d+):(.*)$")
      if fname then
        table.insert(qflist, { filename = fname, lnum = tonumber(lnum), text = text })
      end
    end

    if #qflist == 0 then
      vim.notify("No occurrences of: " .. old)
      return
    end

    vim.fn.setqflist(qflist)
    local esc_old = vim.fn.escape(old, "/\\")
    local esc_new = vim.fn.escape(new, "/\\")
    vim.cmd("cfdo %s/\\<" .. esc_old .. "\\>/" .. esc_new .. "/g | update")
    vim.cmd("cclose")
    vim.notify("Renamed " .. old .. " → " .. new .. " (" .. #qflist .. " hits)")
  end)
end)
