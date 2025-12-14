return {
  "chrisgrieser/nvim-spider", -- advanced wordmotion
  event = "UIEnter",
  -- lazy = false,
  opts = {
    skipInsignificantPunctuation = true,
    consistentOperatorPending = true,
    subwordMovement = true,
    customPatterns = {}, -- check "Custom Movement Patterns" in the README for details
  },
}
