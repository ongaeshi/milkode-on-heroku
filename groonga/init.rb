require 'milkode/cli'

p ENV['GROONGA_DATABASE']
p ENV['GROONGA_DATABASE_PATH']

CLI.start("init".split)
CLI.start("add --from-file ./PACKAGES".split)
