return {
  "camspiers/snap",
  config = function()
    -- Basic example config
    local snap = require "snap"
    local vimgrep = snap.config.vimgrep:with { reverse = true, suffix = ">>", limit = 50000 }
    snap.maps {
      { "<Leader>vg", vimgrep {} },
    }
  end
}
