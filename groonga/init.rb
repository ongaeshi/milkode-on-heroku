# -*- coding: utf-8 -*-
require 'milkode/cli'
require 'fileutils'
require 'optparse'

class AddPackage
  attr_reader :dst_dir
  attr_reader :path
  attr_reader :branch_name

  def initialize(dst_dir, str)
    opt = OptionParser.new
    opt.on('-n NAME', '--name')   { |name| @name = name }
    opt.on('-b BRANCH_NAME', '--branch-name') { |branch_name| @branch_name = branch_name }
    args = str.split
    opt.parse!(args)
    
    @dst_dir = dst_dir
    @path = args[0]
  end

  def url
    "https://github.com/#{path}.git"
  end

  def name
    @name || File.basename(url).sub(/\.git\Z/, "")
  end

  def filename
    File.join(dst_dir, name)
  end

  def git_clone
    if branch_name
      "git clone --depth 1 #{url} #{filename} -b #{branch_name}"
    else
      "git clone --depth 1 #{url} #{filename}"
    end
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

# Initialize database
CLI.start("init".split)

# Add pacakges
open("./PACKAGES") do |f|
  # dst_dir = File.join(ENV['MILKODE_DEFAULT_DIR'], "packages/git")
  dst_dir = File.join('/app', "packages/git")
  FileUtils.mkdir_p dst_dir
  
  f.each do |path|
    path.chomp!
    next if /\A\s*\z/ =~ path
    package = AddPackage.new(dst_dir, path)
    system(package.git_clone)
    CLI.start("add #{package.filename}".split)
    milkode_yaml_str += package.yaml
  end
end

# Rewrite milkode.yaml
open(File.join(ENV['MILKODE_DEFAULT_DIR'], "milkode.yaml"), "w") do |f|
  f.write(milkode_yaml_str)
end

# Copy milkweb.yaml
FileUtils.cp('./milkweb.yaml', ENV['MILKODE_DEFAULT_DIR'])
