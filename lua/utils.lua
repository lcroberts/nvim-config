local M = {}
local merge_tb = vim.tbl_deep_extend

-- From nvchad github, commented by me
-- Section is name of section. Can be used to determine set and load plugin specific mappings.
-- mapping_opt can be used to load a set of mappings with a specific option such as `buffer = buffnr` for lsp keybinds
M.load_mappings = function(section, mapping_opt)
  vim.schedule(function()
    local function set_section_map(section_values)
      -- Don't load plugin specific keybinds by default
      if section_values.plugin then
        return
      end

      -- Get rid of section_values.plugin
      section_values.plugin = nil

      -- Iterate through mappings defined in section and create the mappings
      for mode, mode_values in pairs(section_values) do
        local default_opts = merge_tb('force', { mode = mode }, mapping_opt or {})
        for keybind, mapping_info in pairs(mode_values) do
          -- merge default + user opts
          local opts = merge_tb('force', default_opts, mapping_info.opts or {})

          mapping_info.opts, opts.mode = nil, nil
          opts.desc = mapping_info[2]

          vim.keymap.set(mode, keybind, mapping_info[1], opts)
        end
      end
    end

    -- Get mappings file
    local mappings = require 'mappings'

    -- If section is defined on call, set mappings to be only that section and unset plugin
    -- so that set_section_map will set mappings for it.
    if type(section) == 'string' then
      mappings[section]['plugin'] = nil
      mappings = { mappings[section] }
    end

    -- Set mappings
    for _, sect in pairs(mappings) do
      set_section_map(sect)
    end
  end)
end

return M
