local spell_tech = vim.fn.stdpath("config") .. "/spell/techjargon.utf-8.add"

vim.opt.spellfile = spell_tech

local words = {}
for word in io.open(spell_tech, "r"):lines() do
  table.insert(words, word)
end

vim.lsp.config("ltex", {
  filetypes = { "bib", "gitcommit", "markdown", "org", "rst", "rnoweb", "tex" },
  settings = {
    ltex = {
      dictionary = {
        -- doesn't work for some reason
        --["en"] = words,
        --["sk"] = words,
        ["en-US"] = words,
      },
    },
  },
})
