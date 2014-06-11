require 'milkode/cli'

p ENV['GROONGA_DATABASE']
p ENV['GROONGA_DATABASE_PATH']
p ENV['HOME']

ENV['MILKODE_DEFAULT_DIR'] = File.join(ENV['GROONGA_DATABASE_PATH'], '..')
p ENV['MILKODE_DEFAULT_DIR']

CLI.start("init".split)
CLI.start("add --from-file ./PACKAGES".split)
