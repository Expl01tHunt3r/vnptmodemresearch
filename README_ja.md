<!-- hy-mt2-i18n:start -->
[Español](./README.md) | [中文](./README_zh-CN.md) | [English](./README_en.md) | **日本語**
<!-- hy-mt2-i18n:end -->

<h1 align="center">VNPTリバースエンジニアリング＆ルーティングプロジェクト</h1>

<h4 align="center">不可能なことはない :)</h4>

## 1: <ins>目標</ins>
* 4桁の通信事業者モデム（VNPT）に関する研究（現在は-H、-NS、-XSシリーズを対象としている）
* ファームウェアの逆コンパイル、ファームウェア内の暗号化仕組みの解析（時間があればOpenWRTへの改造も試みる）
* モデムが壊れた場合にデブリック用のファイルを用意する（現在は-H、-NSシリーズのみデブリック可能）
  
> [!CAUTION]
> **⚠️ 免責事項 ⚠️**<br>
> ここに記載されている内容はすべて研究や学習を目的としたものです。<br>
> 法律に違反する活動やネットワークシステムへの不正アクセスに利用することは推奨しません。<br>
> 利用者は自己責任で行ってください。<br>
> ここに記載された操作（アプリのインストールを含む）を行うことで、インターネット接続が途絶えたりルーターが損傷したりする可能性があります。


#### VNPTの開発者の皆様にご配慮いただけますと幸いです。
---
## 2: <ins>コンテンツ</ins>
* [`flashdump/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/flashdump) GW-020HモデルのファームウェアのNANDダンプ（今後-XS、-NSも追加予定）
* [`openwrt-initramfs-en751221/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/openwrt-initramfs-en751221) ファームウェアが破損した際のデブリック作業用
* [`openwrt-xsw-050ns/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/openwrt-xsw-050ns) XSW050-NS向けのOpenWRT（貢献してくださった[@longnt2007](https://github.com/longnt2007)さんに感謝します :3）
* [`tools/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/tools) romfile.cfgの復号・暗号化用ツール
* 近日、-XS（050）シリーズ用の暗号化・復号ツールも追加予定
* [`decrypted-cfgfile-xs/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/decrypted-cfgfile-xs) 复号済みのモデルのromfile.cfgサンプルファイル
*  [`private-romfile-key/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/private-romfile-key) -XSモデルの.cfgファイルを復号・暗号化するための証明書と秘密鍵
* ストリップ処理済みのファームウェアダンプは[`squashfs-modified`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/squashfs-modified)にあります：
	* `boa-dump.bin`：Web UIを通じてアップグレード時の元のファームウェア（GW020-H）
	* `squashfs.image`：抽出されたsquashfs部分（GW020-H）、`unsquashfs`で展開可能
	* GW040-Hのboaからダンプされたファームウェア
	* 解読済みのsquashfs-rootは[こちら](https://github.com/ResearcherPT/vnptmodemresearch/releases)にあります
 *  [`Integrations/*`](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations) 補足ソフトウェアやパッチなどのインストール手順やリソース、コマンドなど
---
## 3: <ins>シェルとその仲間たち（TTY、SSH、...）</ins>
* このセクションではルーターのシェル（コンソール）の開き方を説明します。既に開けている場合はスキップしてください。まだ開けていない場合は続けてください~~
> [!WARNING]  
> **⚠️ 警告 ⚠️**  
> シェルを開くと、うっかりして自分のネットワークシステムに脆弱性が生じる可能性があります！  
> アクセスできるのは**あなただけ**であることを確実にしてください。  
> WiFiのログインパスワードを推測しにくいものに設定しましょう！  
> シェルに入ったらすぐにpasswdコマンドを使ってパスワードを変更してください（すべてのアカウントで変更するのを忘れずに）。そうしないとアクセス権限のホワイトリスト設定ができなくなる可能性があります。

### 3.1: UART
*UART経由での接続ができなくても心配しないでください。ハードウェアのプラグを使わずとも、-H、-NS、-XSシリーズはすべてシェルにアクセスできる方法があります。*
*USB-UARTコネクタ（経済的な環境向けにはCH340またはFT232BLチップを推奨）とジャンパーワイヤーを準備してください。*
*ラウターのケースを開けて（[開封方法はこちら](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/doc/disassemble)）、基板を確認してください。*
*基板のLEDの近くには`RX`、`TX`、`GND`の3つのピンがあります。*
*ハードウェアを壊さないよう正しく接続してください（詳細はGoogleで検索してください）。*
*ワイヤーの接続がしっかりしていることを確認し、必要であればはんだ付けして固定してください。*
### 3.2: ログインアカウント
*起動後、UART経由でアクセスすると次のように表示されます：*
  ```txt
  Please press Enter to activate this console.
  ```
*接続すると`tc login:`と表示されます。*
*-H、-NS用の認証情報：*
  * admin / VnT3ch@dm1n（完全な権限を持つroot同等、telnet、SSH、FTP利用可能）*
  * operator / VnT3ch0per@tor（UARTのみ利用可能）*
  * customer / customer（権限が低く、telnet、SSHのみ利用可能）*
  * user3 / star（Web利用可能、デフォルトでは無効、権限が低く、-NSモデル専用）*
*-XSシリーズ専用の認証情報：*
  * customer / customer（権限が低く、telnetのみ利用可能）*
  * admin / $2$7c1ae60c120167530ca98a32c5323d9b89cff5bb（ハッシュ値、正確なパスワードは未解明、telnet、コンソール、FTP利用可能）（`1234`、`s2@We3%Dc#`、`admin4444`も試せます）*
  * operator / $1$y....DM.$7eLwNxxQmjB1WmfB.ancV/（ハッシュ値、正確なパスワードは未解明、Web利用可能）（`oper@tor`も試せます）*
  * user3 / star（Web利用可能、デフォルトでは無効、権限が低い）*

* 正常にログインすると、デフォルトのシェル（BusyBox Shell）に直接入ります。
### 3.3: Telnet/SSH 
> [!TIP]
> IPが[192.168.1.1](https://192.168.1.1/)や[192.168.0.1](https://192.168.0.1/)のルーター管理用ページを私はWeb-UIと呼んでいます。  
> GatewayとはルーターのIPのことで、例えば192.168.1.1や192.168.0.1などです。  
> 説明は英語のインターフェースに沿って行います。
* Web-UIにアクセスできる場合：Web-UIに入り、ログインしてからAccessタブに移動し、ACL Filterの項目を開き、Deactivatedを選択してSetを押します。
* ACLを無効にした後は、以下の通りです：
  - -Hモデルの場合：上記の操作を行うとすぐにアクセスできます :D（AppleSangの確認によると、無効にするだけですぐにシェルに入れます）。
  
  - Dòng -NS: Web-UIのページ内にあるウェブアクセス用のパスから```content.asp```という文字を削除し、その代わりに```getGateWay.cgi```と入力すると、下の画像のような結果が得られます。
    <img width="542" height="135" alt="image" src="https://github.com/user-attachments/assets/5574f71b-d030-4c07-813a-8035c7554c8a" />
    
  - Dòng -HS: **情報なし**
    
  - Dòng -XS: Web-UIのページ内にあるウェブアクセス用のURLから```content.asp```という文字を削除し、代わりに```telnet.asp```と入力します。アクセスした後は```TelnetSet: Enable```にチェックを入れ、```Save```をクリックしてください。
    <img width="1190" height="317" alt="image" src="https://github.com/user-attachments/assets/bceea390-af4c-4881-ac7a-ab641a913eca" />
    
* 操作が完了したらCommand Promptを開き、次のコマンドを入力してください：
```
telnet ip.gateway.của.bạn
```
例は以下の通りです：
```bash
telnet 192.168.1.1
```
また、-Hや-NSの場合はSSHを使用でき、例えば次のようになります：
```bash
ssh admin@192.168.1.1
```

> [!WARNING]
> もし端末にTelnetがインストールされていない場合は、**管理者権限で**CMDを起動し、以下のコマンドを実行してください
> ```bash
> dism /online /Enable-Feature /FeatureName:TelnetClient

そして、[こちら](https://github.com/ResearcherPT/vnptmodemresearch/edit/master/README.md#32-t%C3%A0i-kho%E1%BA%A3n-login)に戻ってシェルにログインしてください。

* もしWeb-UIを通じてTelnetを有効化できない場合、-NSや-XSモデルでは別の方法があります（他のモデルでも試してみることができます）：
  - ルーターのResetボタンに差し込めるくらいの細い棒、例えば箸などを用意します。
  - 心構えを整えたら、WPSボタンを**強く押し続け**、そのままの状態でその箸をResetボタンに突き刺し、しっかりと押し込んでResetボタンも同時に押されるようにします。2つのボタンが同時に押されている間にルーターのランプを確認すると、以下の2つの状況があります：
    - LOSランプが点滅している場合：**すぐに**手を離し、ルーターが再起動するのを待ってから再度試してください。**もし無理やり長時間押し続けると、ルーターの設定がすべて消去され、最初からやり直さなければならなくなります**。
    - PONランプが点滅している場合：2つのボタンを6～7秒間押し続けます。PONランプが点滅したらTelnetが有効になったので、これで接続できます！
    - それでもダメな場合は、すべてのモデルで共通して、管理用ウェブページ（192.168.1.1）にログインしてACLをオフにすれば、Telnet/SSHにアクセスできます。
    - 補足として、XGSモデルはSSHはなく、Telnetのみ利用可能です。




# 厳格な制約事項
1. **構造の維持**：元のMarkdownデータ構造、インデント、見出し階層、表、リンク、URL、バッジ、コードブロック、インラインコードを一切変更しないこと。
2. **選択的翻訳**：ユーザーに表示される可視的な自然言語内容のみを翻訳すること。
3. **変更禁止**：コードタグ、キー名、変数プレースホルダー（{{var}}、${var}、%s、%dなど）、コマンド例、ファイルパス、プロジェクト名、API名、パッケージ名、モデル名、識別子、コード記号の翻訳や変更は**厳禁**である。背景情報に対応する訳名が既に示されている場合を除く。
4. 用語、スタイル、固有名詞の翻訳は、与えられた背景情報と一致させること。

## 4: <ins>romfile.cfgのパッチ適用</ins>
* `romfile.cfg`は以下から取得される設定ファイルです：
```
(Gateway IP) → Maintenance → Backup/Restore
```
* このファイルには以下の情報が保存されています：
  + LOID、LOIDのパスワード
  + SSID、Wi-Fiのパスワード
  + ネットワーク設定、ファイアウォール、cron設定など
* **注意点：** このファイルにはISPのユーザー名やルーターの設定情報など、多くの機密情報が含まれているため、許可されていない限りこのプロジェクト以外の誰とも共有しないでください。*彼らがあなたのPPPoEアカウントを何に使うか分かりませんよ...*
* XSモデル用の復号済み.cfgファイルは、このリポジトリのdataフォルダ内で確認できます。
### 4.1: 復号と編集
* `romfile.cfg`はbinary `cfg_manager`（-Hモデル）および `/userfs/bin/cfg`（-NS、-XSモデル）によってEVP_aes_256_cbc暗号化が施されています。
* -Hモデルと-NSモデルのKey/IVは逆解析されています。これら2つのモデルは異なるKey/IVを使用していますが、-XSモデルはデプップされたプライベートキーを用いたPKCS7形式を採用しています（詳細はromfileの復号/暗号化に使用されるコードを参照）。
* リポジトリ内のツールを使って復号可能です（**注意：正しいファイルを復号するためには適切なモデルを選択してください。間違えると読み込めません。XSモデル用のモデルは現在コーディング中なので、仮のコマンドを自分のマシンで試してみてください！**）
* この方法ではパッチを適用せずに自動起動スクリプトを追加することも可能です（ただし、-NSモデルはバックアップファイルのチェックが非常に厳格なため編集後のバックアップファイルは受け付けられず、効果は-Hモデルのみです。-XSモデルでも編集後に再パッケージングする方法があります）。
	+ 具体的には、-XSモデルの場合、webuiからromfile.cfgをダウンロードした後、opensslをインストールしてコマンドを使用するか、mtdから設定情報を取得する場合に使用するPythonツールを使って復号できます。
```bash
openssl smime -decrypt -inform DER -in path/to/romfile.cfg -out /whatever/romfile.cfd.dec -inkey path/to/romfile_encrypt_privatekey.pem
```

   + 上記のprivatekey.pemファイルはリポジトリにアップロード済みですので、正しいファイルを指定するように注意してください。
   + 変更が完了したら（各アカウントのハッシュを変更して任意のパスワードに設定することも可能で、これが現在の-XSモデルでadmin shellを取得する方法です）、ハッシュを生成するツールはこのリポジトリのtoolsに含まれています。その後、次のコマンドを使って.cfgファイルを再びパック（暗号化）する必要があります。
```bash
openssl smime -encrypt -inform DER -outform DER \
  -in /path/to/modified/romfile.cfg \
  -out /whatever/path/tp/outfile/romfile.cfg \
  /path/to/romfile_encrypt_cert.pem
```
   + 上記のcert.pemファイルはprivate keyに対応する公開鍵で、モデム内に既に存在し、現在このリポジトリにもアップロードされています。private keyと同じディレクトリで見つけることができます。
   + これで完了！バックアップファイルをアップロードしてご利用ください。
   + 小さな注意点として、web password内のハッシュ（$1$で始まるもの）を変更する場合は少し手順が異なります。例えば、adminユーザーのwebパスワードを123456に設定したい場合は、以下のコマンドを実行してハッシュを取得します：
```bash
openssl passwd -1 "uid = admin;psw = 123456"
```
その後、この新しいハッシュを元のハッシュに置き換えます。他のユーザーでも同様です。オペレーターのパスワードを変更する場合はuidはoperatorになり、パスワードが1234の場合はpswに1234が入ります。

* ツール内に使用説明が記載されており、引数なしでツールを実行するとその説明が表示されます  
### 4.2: ツールを使用するための要件  
* Python（バージョン3.11.6以降でテスト済み、実際にはほとんどの最新バージョンで動作します）およびpycryptodomeパッケージのインストール `pip install pycryptodome`  
* *以上です*  
### 4.3: romfile.cfgを編集してTelnet/SSHを有効化する（*リブート後は消えませんが、ファクトリーリセット後は消失します。-H、-XSモデル向け*）  
* 1: ``romfile.cfg``を復号する  
* *注: 復号済みファイルを読んだ際に?マーク（<img width="216" height="18" alt="image" src="https://github.com/user-attachments/assets/a164bc82-070f-4669-985d-dc05b7dc02a2" />）が表示される場合は、手順を確認してください。優先的にローカルでPythonコードを使用してください（ウェブ上のツールはエラーが発生しやすい）。復号ファイルにエラーがあるとバックアップには使用できず、情報の閲覧のみ可能です。完全でエラーのないファイルでなければモデムに再バックアップすることはできません（内容の二重チェックが行われ、有効性が確認されるため）*  
* 2 (-H): Cronの管理場所（ファイル内では\<Crond\>）を探し、次の内容を追加する  
```bash
iptables -F INPUT; iptables -F FORWARD; iptables -F OUTPUT
```  
または（セミコロン;“が無効と判断された場合）  
```bash
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
```  
このコマンド以外にも、必要に応じて他のコマンドを追加できます。

* *Note1: -XSの場合は、各アカウントのActive値を「Yes」に変更することでtelnetを起動できます。通常は既に有効になっているため、ACLを無効にするか、説明通りのボタンを押すだけで済みます。それでもダメな場合は、管理ウェブページにログインし、url `telnet.cgi`または`telnet.asp`にアクセスして有効に切り替えてください。*

*続いて...もし -H モデルで作業している場合は

* 見た目はこんな感じです（ここで `/1 * * * *` とは、コマンドが毎分実行されることを意味します）
```xml
<Crond>
<CommandList Command_0="reboot" Command_1="" Command_2="" Command_3="" Command_4="" Command_5="" Command_6="" Command_7="" Command_8="" /> 
<Entry0 Active="1" NAME="rb" COMMAND="*/1 * * * * iptables -I INPUT -p tcp --dport 22 -j ACCEPT" />
<Entry1 Active="0" NAME="None" COMMAND="" />
<Entry2 Active="0" NAME="None" COMMAND="" />
<Entry3 Active="0" NAME="None" COMMAND="" />
<Entry4 Active="0" NAME="None" COMMAND="" />
<Entry5 Active="0" NAME="None" COMMAND="" />
<Entry6 Active="0" NAME="None" COMMAND="" />
<Entry7 Active="0" NAME="None" COMMAND="" />
<Entry8 Active="0" NAME="None" COMMAND="" />
</Crond>
```
* その後、再び暗号化して gateway の webUI にアップロードすれば完了です
---
## 5: <ins>OpenWRT initramfs を使った Debrick</ins>
* （-H モデルの場合）モデムがブリック状態になった時：
	* reboot（busybox reboot）を試し、シェルが残っていればボードを再起動します。
 	* ルーターの電源ボタンで電源を切り、再度電源を入れてみます。
	* それでもシェルにアクセスできない場合：
 		* モデムの電源を入れます。
    	* UART 経由で OpenWrt initramfs を使って一時的に起動します。
    	* バックアップから mtdX.bin ファイルを再フラッシュします。
    	* 再起動して設定（`romfile.cfg`）を復元するか、より確実にするにはファームウェアを再度ダウンロードし、webUI からもう一度アップデートします。


* (-NSシリーズの場合) 以下のルーターのうち1台について[OpenWRT](https://openwrt.org/)で検索してください：
    *  [Netis NX31](https://openwrt.org/toh/netis/nx31)
    *  [Xiaomi AX3000T](https://openwrt.org/inbox/toh/xiaomi/ax3000t)
    *  [JCG Q30 PRO](https://openwrt.org/toh/jcg/q30_pro)
* 指示に従えばOpenWRTをフラッシュでき、その後元のファームウェアに戻すかそのまま使用し続けるかはご自身の判断次第です。
* 使用可能なROMにはOpenWRT、ImmortalWRT、Keenetic、Gecoos、Netisなどがあります。（一般的にViettelのmodel aAP 32x6v1で動作するROMであればこちらでも動作し、すべての手順は上記モデルを基準に行えます。）

* 参考：

  * 以下は、VR1200vモデム向けに開発中のOpenWRTファームウェアのリンクです。-Hシリーズと同じSoCを搭載しているため使用可能ですが、WiFiやLANのドライバーは含まれていません。
  * 将来的には互換性のあるOpenWRT版が修正される予定ですが、現時点ではデブリッキング用としてのみ提供されています。
  * OpenWRTが公開しているTP-Link Archer VR1200vの[Debricking](https://openwrt.org/inbox/toh/tp-link/archer_vr1200v#debricking)セクションにある手順を必ずご確認の上、従ってください。

 * [@cjdelisle](https://github.com/cjdelisle)さんが提供してくださった[initramfs](https://github.com/ResearcherPT/vnptmodemresearch/blob/master/openwrt-initramfs-en751221/openwrt-econet-en751221-en751221_generic-initramfs-kernel.bin)に感謝します！
 * 現時点ではまだ正確には分かっていませんが、XSモデルは中国のメーカーであるBaiduのファームウェアをベースにしている可能性があります(?)
---
## 6: <ins>/tmp/boa-tempからファームウェアをデコードする</ins>
<details>
<summary>モデムのシェル内でコマンドを実行する（展開するにはクリック）</summary>
	
<details>
<summary>モデムのシェルでコマンドを実行する（展開するにはクリック）</summary>

```shell
sed -i '1,$d' /tmp/auto_dump_boatemp.sh
cat >> /tmp/auto_dump_boatemp.sh <<'EOF'
#!/bin/sh
out="/tmp/yaffs/boa-dump.bin"
mkdir -p /tmp/yaffs

echo "[*] /tmp/boa-temp のアップロードが完了するのを待機中..."
last_size=0
stable_count=0

while true; do
    if [ -f /tmp/boa-temp ]; then
        set -- $(ls -l /tmp/boa-temp 2>/dev/null)
        size=$5

        if [ "$size" -gt 100000 ]; then
            if [ "$size" -eq "$last_size" ]; then
                stable_count=`expr $stable_count + 1`
            else
                stable_count=0
            fi
            last_size=$size

            # 連続して2回変化しなければ（2秒間）→ アップロード完了
            if [ "$stable_count" -ge 2 ]; then
                cp /tmp/boa-temp "$out"
                echo "[+] boa-temp（$sizeバイト）を $out にダンプしました"
                break
            fi
        fi
    fi
    sleep 1
done
EOF

chmod +x /tmp/auto_dump_boatemp.sh
```

> [!NOTE]  
> -NSモードではyaffsという名前のパーティションがマウントされないため、そのモードでスクリプトを実行した場合、アップグレード後にダンプされたファイルは失われてしまいます。  
> -NSや-XSモードで実行する場合は、出力先パスを `/tmp/yaffs/*` から `/tmp/userdata/*` に変更することを推奨します。

# 厳格な制約事項
1. **構造の維持**：元の Markdown のデータ構造、インデント、見出しの階層、表、リンク、URL、バッジ、コードブロック、インラインコードを一切変更しないこと。
2. **選択的翻訳**：ユーザーに表示される可視的な自然言語の内容のみを翻訳すること。
3. **変更禁止**：コードタグ、キー名、変数プレースホルダー（{{var}}、${var}、%s、%d など）、コマンド例、ファイルパス、プロジェクト名、API 名、パッケージ名、モデル名、識別子、コード記号を翻訳または変更することは**厳禁**である。背景情報に対応する翻訳名が既に記載されている場合を除く。
4. 用語、スタイル、固有名詞の翻訳は、与えられた背景情報と一致させること。

【待翻訳片段】
* スクリプト `/tmp/auto_dump_boatemp.sh` を実行する
* 通常通りファームウェアをアップグレードする
* 再起動が終わったらシェルに戻り、ファイル `/tmp/userdata/boa-dump.bin` （-H ラインの場合は `/tmp/yaffs/boa-dump.bin`）を取得し、`binwalk` または `unsquashfs` を使って分析する
* **注意点**
	* アップグレード中に `boa-temp` ファイルを修正してカスタムフラッシュファームウェアを強制することも可能だが、タイミングが合わない、正確なオフセットが分からない、重要なファイルを上書きしてしまうなどの理由でブリックになるリスクが非常に高い。
	* tcapi を使って fw_upgrade という名前の nvram を修正することで手動でアップグレードを有効化することも可能だが、まずファームウェアが有効かどうかのチェック段階を突破しなければならず（現時点では不可能）、難易度が高い。
---
## 7: <ins>.asp</ins>
* VNPT の機種では（どのバージョンのファームウェアからかは不明）、cgi-bin 内の.asp ファイルが暗号化されている。ファームウェアを改造したり、ロジックフローを読み取りたい場合にはファイルを復号する必要がある。研究の結果、このファイルはビット反転という単純な方法でしか暗号化されておらず、同じ方法で復号できることが分かった。
* ASP を復号するための Python コードは `tools/asp-decoder.py` にあり、そのコードを実行すると手順が示される。
* ASP ファイルを改造する際には、動作仕様に合わせて再度エンコードし、古いファイルの代わりにフラッシュする必要がある。
---
## 8: <ins>アプリケーション</ins>
* [AdGuardHome](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/AdGuard)
* [ddns-updater](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/ddns_updater)
* Caddy（開発中）
* [Btop](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/btop)
* [nano](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/nano)
> 各アプリケーションの README にインストール手順が記載されている
---
## 9: Patch（NS 系機種向け）
* [autorun](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/autorun)
* [myshell](https://github.com/ResearcherPT/vnptmodemresearch/tree/master/Integrations/myshell) 
---
## 10: <ins>議論</ins>
* [VOZ](http://voz.vn/t/vnptmodemresearch-%E2%80%94-nghien-cuu-firmware-root-modem-vnpt-can-anh-em-chung-tay.1159218)
* [Github](https://github.com/ResearcherPT/vnptmodemresearch/discussions/10)
* ~~Discord~~
---
## 11: <ins>今後の目標（040-NS 向け）</ins>
* OpenWRT のインストール（-NS で既に動作している → PON ドライバの追加テスト中 → ~~来年リリース予定~~）
  * 何らかの VPN のインストール
* WPS/WLAN ボタンの機能をカスタマイズし、新しい IP を 5 秒以内に取得できるなどの機能を追加する
* CPU 使用率や RAM がほぼ空になる際の警告など、他の情報を示すために LED を簡単に制御できるようにする
* より開発しやすくなるようにファームウェアをカスタマイズする（カスタム Web-UI の実装、機能の追加・削除、性能最適化など）
  * すでに [こちら](https://github.com/ResearcherPT/gw040ns-firmware) でリリース済み
## 更新情報
* [こちら](https://huggingface.co/spaces/Expl01tHunt3r/file-decoder)に、皆さんが何かをインストールする必要なく、ファイルを自分で復号・暗号化できるオンラインウェブツールを作成しました  
	* （またはping値がわずか15msのベトナム国内のホスティングを利用可能！！→ https://cfgdecoder.fkrystal.qzz.io）  
    > AppleSangさん、信じてください。このツールをダウンロードして自分で暗号化できるようになると気に入るはずです  
* 無料ツールのため時々不安定になることがありますが、どうぞ辛抱強くお待ちください。状況は[こちら](https://stats.uptimerobot.com/U65yw18Rtl)で確認できます  
* 現在、NSシリーズ用のキー/IVが用意されており、NSシリーズ向けの追加オプションが実装された改良版コードもあります  
* romfileを編集するツールが[GW020-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw020-h)、[GW240-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw240-h)、[GW040-H](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-h)、[GW040-NS](https://www.vnpt-technology.vn/vi/product_detail/gpon-ont-igate-gw040-ns)の各モデルで動作することが確認され、[GW050-XGS](https://www.vnpt-technology.vn/vi/product_detail/xgs-pon-ont-igate-xsw050-ns)のモデルでもコマンドが使用可能です  
* cgi-bin内の.aspファイルを復号する方法も見つかりました  
* 各モデルにあるcfgファイルの構造は、gzipで圧縮された後にHD3Rヘッダ、バージョン、長さなど（256バイト）が続き、その後PKCS7構造で暗号化されたデータとなっています

## 寄付：
- NS型モデムのromfile.cfgにおけるキーの調査やアプリケーションのインストールを手伝ってくれた[@BussyBakks](https://github.com/BussyBakks)さんと[@AppleSang](https://github.com/AppleSang)さんに感謝します。
- OpenWRTをXSW050-NSにポートしてくれた[@longnt2007](https://github.com/longnt2007)さんに感謝します。


<p align="center">Expl01tHunt3rによって❤️を込めて制作</p>
