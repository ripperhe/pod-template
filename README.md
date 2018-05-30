# pod-template

[**博客介绍**](http://ripperhe.com/2017/03/30/fastlane-pod/)

快速创建发布 Pod 需要的文件的脚本

## Features

* 运行脚本会创建的文件：

| 文件 | 说明 |
| :--: | :--: |
| README.md |写一个模板，以后填空就好 |
| LICENSE | 一般都是 MIT 证书 |
| fastlane/Fastfile | 一行命令发布 pod，详情看 [fastlane-files](https://github.com/ripperhe/fastlane-files) |
| xxx.podspec | spec 文件必填的就那么几项，写个模板可以把大部分都填好，不用改了 |

* 如果某个文件已经存在，会在自动生成的文件名上加 `template.` 前缀，不会影响到已有文件

## Usage

1. 将仓库 fork 到你的账户下
2. 修改 `template-files` 文件夹下所有文件为你的信息，需要写框架名字的地方用 `%ZYTemplateName%` 代替
3. 注意 **不要删除或重命名** `template-files` 文件夹下的文件。
4. 把终端工作目录切换到要发布的文件夹下，并执行 `prepare_release.rb`，根据提示输入框架名字（直接敲回车默认为当前文件夹名字），便会自动创建相应文件

```ruby
$ ruby 本仓库路径/prepare_release.rb
```

可以将本地仓库固定在某个路径，然后设置一个命令别名，例如用 [Oh My Zsh](http://ohmyz.sh/)的朋友，可以直接在 `~/.zshrc` 文件末尾加上别名设置

```ruby
alias pre='ruby 本仓库路径/prepare_release.rb'
```

以后就可以直接到工程根目录下，直接执行 `pre` 即可。

```ruby
$ pre
```

## Author

ripperhe, ripperhe@qq.com

## License

Fastlane-files is available under the MIT license. See the LICENSE file for more info.
