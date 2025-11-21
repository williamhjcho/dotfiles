require('mason').setup()

-- stylua: ignore
local packages = vim
  .iter(require('whjc.languages'))
  :map(function(i) return i.mason end)
  :filter(function(i) return i end)
  :flatten()
  :totable()
local registry = require('mason-registry')

local function install_packages()
  for _, name in ipairs(packages) do
    if registry.has_package(name) then
      local p = registry.get_package(name)
      if not p:is_installed() then
        p:install()
      end
    end
  end
end

local function uninstall_unwanted()
  for _, name in ipairs(registry.get_installed_package_names()) do
    if not vim.tbl_contains(packages, name) then
      local p = registry.get_package(name)
      p:uninstall()
    end
  end
end

registry.refresh(function()
  install_packages()
end)
