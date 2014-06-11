require 'milkode/cli'

ENV['MILKODE_DEFAULT_DIR'] = File.join(ENV['GROONGA_DATABASE_PATH'], '../../.milkode')

CLI.start("init".split)
CLI.start("add --from-file ./PACKAGES".split)
