require 'milkode/cli'
require 'fileutils'

ENV['MILKODE_DEFAULT_DIR'] = File.join(ENV['GROONGA_DATABASE_PATH'], '../../.milkode')

CLI.start("init".split)

open("./PACKAGES") do |f|
  dst_dir = File.join(ENV['MILKODE_DEFAULT_DIR'], "packages/git")
  p dst_dir
  FileUtils.mkdir_p dst_dir
  
  f.each do |url|
    url.chomp!
    name = File.basename(url).sub(/\.git\Z/, "")
    filename = File.join(dst_dir, name)
    system("git clone --depth 1 #{url} #{filename}")
    CLI.start("add #{filename}".split)
  end
end
