require 'milkode/cli'
require 'fileutils'

ENV['MILKODE_DEFAULT_DIR'] = File.join(ENV['GROONGA_DATABASE_PATH'], '../../.milkode')

CLI.start("init".split)
CLI.start("add --from-file ./PACKAGES".split)

p File.join(ENV['MILKODE_DEFAULT_DIR'], 'packages')
system("rm -rf #{File.join(ENV['MILKODE_DEFAULT_DIR'], 'packages')}")

# FileUtils.rm_rf(File.join(ENV['MILKODE_DEFAULT_DIR'], 'packages'))
