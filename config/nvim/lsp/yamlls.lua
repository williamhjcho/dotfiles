return {
  before_init = function(_, new_config)
    new_config.settings = new_config.settings or {}
    new_config.settings.yaml = new_config.settings.yaml or {}
    new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
    vim.list_extend(new_config.settings.yaml.schemas, require('schemastore').yaml.schemas())
  end,
}
