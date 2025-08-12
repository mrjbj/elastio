-- :CheckCtrl to see which control keys are unmapped in nvim.
vim.api.nvim_create_user_command("CheckCtrl", function()
  local keys = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
  }
  for _, mode in ipairs({ "n", "i", "v" }) do
    print("Unbound in " .. mode .. " mode:")
    for _, key in ipairs(keys) do
      if vim.fn.mapcheck("<C-" .. key .. ">", mode) == "" then
        print("<C-" .. key .. ">")
      end
    end
  end
end, {})
-- :CheckMeta to see which meta keys are unmapped in nvim.
vim.api.nvim_create_user_command("CheckMeta", function()
  local keys = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
  }
  for _, mode in ipairs({ "n", "i", "v" }) do
    print("Unbound in " .. mode .. " mode:")
    for _, key in ipairs(keys) do
      if vim.fn.mapcheck("<M-" .. key .. ">", mode) == "" then
        print("<M-" .. key .. ">")
      end
    end
  end
end, {})
