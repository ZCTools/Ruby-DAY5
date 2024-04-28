require 'net/http'
require 'uri'

def url_dogru_mu?(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  return response.is_a?(Net::HTTPSuccess)
end

def js_dosyalari_bul(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  sayfa_icerigi = response.body

  js_dosyalari = sayfa_icerigi.scan(/src="([^"]+\.js)"/).flatten.uniq

  if js_dosyalari.empty?
    puts "JavaScript dosyası bulunamadı."
  else
    puts "Bulunan JavaScript dosyaları:"
    js_dosyalari.each { |dosya| puts dosya }
  end
end

def js_kodlari_kopyala(url, dosya_adi)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  sayfa_icerigi = response.body

  js_dosyalari = sayfa_icerigi.scan(/src="([^"]+\.js)"/).flatten.uniq

  if js_dosyalari.include?(dosya_adi)
    js_icerik = Net::HTTP.get(URI.join(url, dosya_adi))
    File.open("file.txt", "w") { |dosya| dosya.write(js_icerik) }
    puts "#{dosya_adi} adlı JavaScript dosyasının içeriği 'file.txt' dosyasına kopyalandı."
  else
    puts "Hatalı dosya adı. Lütfen baştan başlayın."
  end
end

print "Lütfen bir URL girin: "
url = gets.chomp

if url_dogru_mu?(url)
  js_dosyalari_bul(url)
  print "Kopyalamak istediğiniz JavaScript dosyasının adını girin: "
  dosya_adi = gets.chomp
  js_kodlari_kopyala(url, dosya_adi)
else
  puts "URL yanlış. Lütfen tekrar bir URL girin."
end
