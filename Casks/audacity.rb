# fork source: https://gist.githubusercontent.com/varenc/f7f0afc32af0f8062ae727e4415326c6/raw/aec6e3d4bc9a53de440411acfb932b792783a9e8/audacity.rb
# Thanks!

# Audacityがアップデートされると，releaseIdとversion, sha256の更新が必要になります．
# projectページ(https://www.fosshub.com/Audacity.html)でjavascript直打ちで情報取得
# 
# sha256:    settings.pool.f の配列の該当のhash/sha256
# projectId: settings.pool.p ("p"rojectId?)
# releaseId: settings.pool.f の配列の該当のr ("r"eleaseId?)
# filename:  settings.pool.f の該当のn ("n"ame?)
# source:    settings.pool.c

## ---
# Unofficial Hombrew Cask for Audacity 2.4.1 (recent 64-bit version) 
# Made entirely for fun and to demonstrate how to get around fosshub's limitations.

# Problem: Audacity's binary is hosted on fosshub and they don't provide a fixed url! The seems to intentionally try to prevent "hot-linking".
# Solution: Make a request to fosshub's special XHR endpoint to get the signed download url.  Then just pass that URL to Homebrew

require 'net/http'
require 'json'
require 'uri'

cask 'audacity' do
  version '2.4.2'
  sha256 '4730abe5b59d9c3dd000fde22d7037af6e6019a4305195a3e4e714f6c9f6380a'

  # Current official URL as proposed on http://www.audacityteam.org/download/mac/
  # must be parsed to extract temporary url embedded in iframe

  def get_audacity_url
    fosshub_response = nil
    uri = URI("https://api.fosshub.com/download/")
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1.1 Safari/605.1.15')
      request.body = {
        "projectId" => "5b7eee97e8058c20a7bbfcf4",
        "releaseId" => "5ef5ead9c63e265869c6d064",
        "projectUri" => "Audacity.html",
        "fileName" => "audacity-macos-2.4.2.dmg",
        "source" => "CF"
      }.to_json

      response = http.request request # Net::HTTPResponse object
      fosshub_response = JSON.parse(response.body)
      end
    return fosshub_response['data']['url']
  end
  url get_audacity_url
  name 'Audacity'
  homepage 'http://audacityteam.org'
  
  app 'Audacity.app'
  
  zap delete: '~/Library/Application Support/audacity'
end
## ---
