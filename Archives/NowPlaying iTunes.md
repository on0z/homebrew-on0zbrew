# NowPlaying iTunes
iTunes(現ミュージック)で再生中の曲について，自動でナウプレツイートをする超簡易軽量アプリです．

# 機能
 - 即時ツイート(アプリを立ち上げてから再生が開始されないといけません)
 - 曲が再生されるタイミングで通知
 - 曲が再生されると同時に自動でツイート
 
![Function](NowPlaying%20iTunes/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202021-02-01%2013.27.32.png)
 

# 設定
アプリを起動し，  
右上の「#♪」>Preferences > Account  
にてSign inしてください．
![Sign in](NowPlaying%20iTunes/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202021-02-01%2013.25.06.png)

# カスタム
カスタムCKCSに対応しています．
callbackURLは`NowPlaying-iTunes://`としてください．
ご自身のCKCSを右上の「#♪」>Preferences > Account で入力してください．
![CKCSCustomize](NowPlaying%20iTunes/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202021-02-01%2013.25.06.png)

ナウプレの文字列を変更できます．
タイトル，アーティスト名，アルバム名に対応しています．
![TweetCustomize](NowPlaying%20iTunes/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202021-02-01%2013.22.27.png)