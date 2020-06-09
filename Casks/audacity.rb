# fork source: https://gist.githubusercontent.com/varenc/f7f0afc32af0f8062ae727e4415326c6/raw/aec6e3d4bc9a53de440411acfb932b792783a9e8/audacity.rb
# Thanks!

# Audacityがアップデートされると，releaseIdとversion, sha256の更新が必要になります．
# sha256は，実際にファイルを落としてきてshasum -a 256 ~.dmgで確認しましょう．或いはaudacityのページにも書いてあります．(https://www.audacityteam.org/download/mac/)
# releaseIdは，fosshubのページに書いてあります．Webインスペクタから探します．macOS DMGの行の，Antivirusの項です．data-file-idに指定されています．

## ---
# Unofficial Hombrew Cask for Audacity 2.4.1 (recent 64-bit version) 
# Made entirely for fun and to demonstrate how to get around fosshub's limitations.

# Problem: Audacity's binary is hosted on fosshub and they don't provide a fixed url! The seems to intentionally try to prevent "hot-linking".
# Solution: Make a request to fosshub's special XHR endpoint to get the signed download url.  Then just pass that URL to Homebrew

require 'net/http'
require 'json'
require 'uri'

cask 'audacity' do
  version '2.4.1'
  sha256 '5d340b025b80eb0c3ea41ae2487a77b86527bc8fb0e058d32e37762ac3d85575'

  # Current official URL as proposed on http://www.audacityteam.org/download/mac/
  # must be parsed to extract temporary url embedded in iframe

  def get_audacity_url
    fosshub_response = nil
    uri = URI("https://api.fosshub.com/download/")
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36')
      request.body = {
        "fileName" => "audacity-macos-2.4.1.dmg",
        "projectId" => "5b7eee97e8058c20a7bbfcf4",
        "projectUri" => "Audacity.html",
        "releaseId" => "5ec64795191c681deac91d5f",
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