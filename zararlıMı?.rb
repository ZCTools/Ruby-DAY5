# Şüpheli Linkleri Kontrol Etme Uygulaması:

require 'net/http' # Net::HTTP modülünün kütüphanesi
require 'uri' # URL Ayrıştırmak için kullanılan kütüphane

def isItHarmfull(url)
  response = Net::HTTP.get_response(URI.parse(url))# Bir HTTPS isteği ve
  # Response dönüşü yapılır.
  if response.code == "200"
    puts "#{url} Güvenli bir link:)" # URL 200'e eşit ise link güvenlidir
  else
    puts "#{url} Oltalama (zararlı) linki!:(" # URL 200'e eşit değilse link güvenli değildir
  end
end

print "Lütfen kontrol etmek istediğiniz URL'yi girin: "
url = gets.chomp # Kullanıcı Girişi

isItHarmfull(url) # Fonksiyonu çağırma
