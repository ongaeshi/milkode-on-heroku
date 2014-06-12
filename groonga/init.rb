require 'milkode/cli'
require 'fileutils'

class AddPackage
  attr_reader :dst_dir
  attr_reader :path

  def initialize(dst_dir, str)
    @dst_dir = dst_dir
    @path = str
  end

  def url
    "https://github.com/#{path}.git"
  end

  def name
    File.basename(url).sub(/\.git\Z/, "")
  end

  def filename
    File.join(dst_dir, name)
  end

  def git_clone
    "git clone --depth 1 #{url} #{filename}"
  end

  def yaml
    <<EOF
- directory: #{filename}
  options:
    :github: #{path}
EOF
  end
end

# ---
root_dir = File.expand_path(File.join(ENV['GROONGA_DATABASE_PATH'], '../..'))
ENV['MILKODE_DEFAULT_DIR'] = File.join(root_dir, '.milkode')
milkode_yaml_str = <<EOF
---
version: '0.2'
contents:
EOF

CLI.start("init".split)

open("./PACKAGES") do |f|
  dst_dir = File.join(ENV['MILKODE_DEFAULT_DIR'], "packages/git")
  FileUtils.mkdir_p dst_dir
  
  f.each do |path|
    package = AddPackage.new(dst_dir, path.chomp)
    system(package.git_clone)
    CLI.start("add #{package.filename}".split)
    milkode_yaml_str += package.yaml
  end
end

open(File.join(ENV['MILKODE_DEFAULT_DIR'], "milkode.yaml"), "w") do |f|
  f.write(milkode_yaml_str)
end
