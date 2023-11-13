# docker ROS humble

`Ubuntu22`がインストールされていないPC（`Ubuntu`の他のバージョンや`Raspbian`等）で`ros2 Humble`を動作させる`docker-compose`の設定ファイル群。

## 基本的な使い方

`PC`のホームディレクトリにクローンする。クローンは一度だけで良い。

```shell
git clone https://github.com/KMiyawaki/docker_ros_humble
```

クローンしたら次のコマンドで実行する。

```shell
~/docker_ros_humble/attach.sh
```

このコマンドを実行したターミナル内は`Docker`により`Ubuntu22+ros2 humble`が利用可能となっている。
初回起動時のみ**コンテナ内で**以下のコマンドを実行する。

```shell
cd ~/setup_robot_programming/ros2
./init_workspace.sh -1
exit # 一旦コンテナから抜ける。
~/docker_ros_humble/attach.sh # 再度コンテナに入る。
```

**コンテナ内で**以下のコマンドを実行し、ROS2のテストをする。

```shell
ros2 run py_pubsub talker
[INFO] [1698446948.334827906] [minimal_publisher]: Publishing: "Hello World: 0"
[INFO] [1698446948.770740085] [minimal_publisher]: Publishing: "Hello World: 1"
・・・
# Ctrl+C で終了させる。
```

## ショートカットを置いて簡単に使う方法

以下は`Ubuntu22`での説明となる。

`gnome-terminal`（通常使うターミナル）で新しいプロファイルを追加する。
ターミナルを開くときにカスタムコマンドを指定する。

```shell
bash -c $HOME/docker_ros_humble/attach.sh
```

このプロファイル名を`docker_ros_humble`にする。

次のようなファイルを作成し、`$HOME/デスクトップ/open_ros_humble.desktop`として配置し実行権限をつける。

```text
[Desktop Entry]
Type=Application
Version=1.0
Name=ros2 humble
Comment=open ros2 humble
Exec=gnome-terminal --profile=docker_ros_humble
Terminal=true
```

デスクトップ上に`open_ros_humble.desktop`が出現するので、右クリックして「実行を許可する」をクリックする。
以降はこれをダブルクリックすれば`Ubuntu22+ros2 humble`環境が起動する。

## 現状の問題点

`Docker`内からユーザのグループを追加することができない（`useradd`ができない）。この場合はホスト側からグループを追加すればよい。

```shell
adduser: `/sbin/useradd -d /nonexistent -g audio -s /usr/sbin/nologin -u 130 festival' returned error code 1. Exiting.
dpkg: error processing package festival (--configure):
 installed festival package post-installation script subprocess returned error exit status 1

sudo /sbin/useradd -d /nonexistent -g audio -s /usr/sbin/nologin -u 130 festival
```
