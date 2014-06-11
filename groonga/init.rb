require 'milkode/cli'
require 'fileutils'

root_dir = File.expand_path(File.join(ENV['GROONGA_DATABASE_PATH'], '../..'))
ENV['MILKODE_DEFAULT_DIR'] = File.join(root_dir, '.milkode')

CLI.start("init".split)

open("./PACKAGES") do |f|
  dst_dir = File.join(ENV['MILKODE_DEFAULT_DIR'], "packages/git")
  FileUtils.mkdir_p dst_dir
  
  f.each do |url|
    url.chomp!
    name = File.basename(url).sub(/\.git\Z/, "")
    filename = File.join(dst_dir, name)
    system("git clone --depth 1 #{url} #{filename}")
    CLI.start("add #{filename}".split)
  end
end

milkode_yaml = File.join(ENV['MILKODE_DEFAULT_DIR'], "milkode.yaml")
str = ""

open(milkode_yaml) do |f|
  f.each do |line|
    str += line.sub(/#{root_dir}/, "/app")
  end
end

open(milkode_yaml, "w") do |f|
  f.write(str)
end
