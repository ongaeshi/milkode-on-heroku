require 'milkode/cli'
require 'fileutils'

root_dir = File.expand_path(File.join(ENV['GROONGA_DATABASE_PATH'], '../..'))
ENV['MILKODE_DEFAULT_DIR'] = File.join(root_dir, '.milkode')

CLI.start("init".split)

milkode_yaml_str = <<EOF
---
version: '0.2'
contents:
EOF

open("./PACKAGES") do |f|
  dst_dir = File.join(ENV['MILKODE_DEFAULT_DIR'], "packages/git")
  FileUtils.mkdir_p dst_dir
  
  f.each do |path|
    path.chomp!
    url = "https://github.com/#{path}.git"
    name = File.basename(url).sub(/\.git\Z/, "")
    filename = File.join(dst_dir, name)

    system("git clone --depth 1 #{url} #{filename}")
    CLI.start("add #{filename}".split)

milkode_yaml_str += <<EOF
- directory: #{filename}
  options:
    :github: #{path}
EOF
  end
end

milkode_yaml = File.join(ENV['MILKODE_DEFAULT_DIR'], "milkode.yaml")

open(milkode_yaml, "w") do |f|
  f.write(milkode_yaml_str)
end
