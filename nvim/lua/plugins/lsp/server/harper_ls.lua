vim.lsp.config("harper_ls", {
  settings = {
    ["harper-ls"] = {
      userDictPath = vim.fn.expand("~/.config/nvim/spell/techjargon.utf-8.add"),
      linters = {
        LongSentences = false,
        ExpandArgument = false,
        OrthographicConsistency = false,
        SentenceCapitalization = false,
        PhrasalVerbAsCompoundNoun = false,
        ExpandMinimum = false,
        MissingTo = false,
        UseEllipsisCharacter = false,
      },
    },
  },
})
