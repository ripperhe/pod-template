#!/usr/bin/ruby
# -*- coding: UTF-8 -*-

# ************************方法************************

# 打印
def time_puts(str)
  current_time = Time.new
  puts current_time.strftime("[%H:%M:%S]: ") + str
end

# 获取文件内容
# @param [文件名] file_name
def get_file_content(file_name)
  content = ''
  if file_name.to_s.empty?
    time_puts 'file_name is wrong!'
  else
    target_file = File.new(file_name, 'r')
    if target_file
      content = target_file.read
      target_file.close
      time_puts "Read source file #{file_name} successfully！"
    else
      time_puts "Read source file #{file_name} failed! "
    end
  end
  content
end

# 根据文件名和内容创建对应文件
# @param [文件名] file_name
# @param [文件内容] content
def create_file(file_name, content)
  if file_name.to_s.empty?
    time_puts 'file_name is wrong!'
  else
    new_file = File.new(file_name, 'w')
    if new_file
      new_file.syswrite(content)
      new_file.close
      time_puts "Create #{file_name} successfully！"
    else
      time_puts "Create #{file_name} failed! 💥"
    end
  end
end

# ************************操作************************

=begin
如果有原来有该文件，则保留，并将新的文件命名为 timplate.+原文件名
1. README.md
2. LICENSE (默认 MIT)
3. %ZYTemplateName%.podspec
4. fastlane/Fastfle
=end

# 获取仓库名字
time_puts 'Please input the lib name:👇'
new_lib_name = gets
new_lib_name.gsub!(' ', '')
new_lib_name = new_lib_name.to_s.chomp
# 如果名字为空，获取当前文件夹名字
if new_lib_name.empty?
  dir_name = Dir.pwd.to_s.split('/').last
  dir_name.gsub!(' ', '')
  new_lib_name = dir_name
end

time_puts '------------------------- 华丽的分割线 -------------------------'
time_puts "Create some files at current directory to release lib #{new_lib_name} ! Please waiting..."

=begin
puts Dir.pwd # 当前工作目录
puts __FILE__ # 脚本文件名（会带上路径）
puts File.dirname(__FILE__) # 脚本所在文件夹名（带上路径）
require 'pathname'
puts Pathname.new(__FILE__).realpath # 脚本文件完成路径 （打印出来和 __FILE__相同）
puts Pathname.new(File.dirname(__FILE__)).realpath # 脚本文件所在文件夹完成路径 （打印出来和 File.dirname(__FILE__) 相同）
=end

tmp_name = '%ZYTemplateName%'

readme_name = 'README.md'
license_name = 'LICENSE'
spec_name = "#{tmp_name}.podspec"
fast_dir_name = 'fastlane'
fast_file_name = 'Fastfile'

new_spec_name = "#{new_lib_name}.podspec"
tmp_prefix = 'template.'
work_path = Dir.pwd
# 如果放在根目录这样可能会出问题，这里忽略
source_path = File.dirname(__FILE__) + '/template-files/'


# 1. README.md
time_puts '--------------------'
time_puts '----Step: README ---'
time_puts '--------------------'
readme_content = get_file_content(source_path + readme_name)
readme_content.gsub!(tmp_name, new_lib_name)
if File.exist?(readme_name)
  create_file(tmp_prefix + readme_name, readme_content)
else
  create_file(readme_name, readme_content)
end

# 2. LICENSE (默认 MIT)
time_puts '---------------------'
time_puts '----Step: LICENSE ---'
time_puts '---------------------'
license_content = get_file_content(source_path + license_name)
if File.exist?(license_name)
  create_file(tmp_prefix + license_name, license_content)
else
  create_file(license_name, license_content)
end

# 3. %ZYTemplateName%.podspec
time_puts '---------------------'
time_puts '----Step: podspec ---'
time_puts '---------------------'
spec_content = get_file_content(source_path + spec_name)
spec_content.gsub!(tmp_name, new_lib_name)
if File.exist?(new_spec_name)
  create_file(tmp_prefix + new_spec_name, spec_content)
else
  create_file(new_spec_name, spec_content)
end

# 4. fastlane/Fastfle
time_puts '----------------------'
time_puts '----Step: fastlane ---'
time_puts '----------------------'
fastlane_content = get_file_content(source_path + fast_file_name)
unless File.directory?(fast_dir_name)
  Dir.mkdir(fast_dir_name)
end
if File.exist?(fast_dir_name + '/' + fast_file_name)
  create_file(fast_dir_name + '/' + tmp_prefix + fast_file_name, fastlane_content)
else
  create_file(fast_dir_name + '/' + fast_file_name, fastlane_content)
end

time_puts '------------------------- 华丽的分割线 -------------------------'
time_puts "Create files to release lib #{new_lib_name} Successfully! 🎉"
