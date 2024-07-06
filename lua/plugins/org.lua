return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      local org = require 'orgmode'
      org.setup {
        org_agenda_files = '~/OneDrive/org/**/*.org',
        org_default_notes_file = '~/OneDrive/org/notes.org',
      }
    end,
  },
  {
    'akinsho/org-bullets.nvim',
    ft = { 'org' },
    opts = {},
  },
  {
    'chipsenkbeil/org-roam.nvim',
    dependencies = {
      'nvim-orgmode/orgmode',
    },
    opts = {
      directory = '~/OneDrive/OrgRoam',
    },
  },
}
