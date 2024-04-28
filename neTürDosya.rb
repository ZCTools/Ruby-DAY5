# Bir WEB sitesinin URL'sini gir ve hangi türde dosya istediğiniz yaz...
require 'nokogiri'
require 'open-uri'

puts "Bir web sitesinin URL'sini girin:"
url = gets.chomp

puts "Hangi türde dosya aramak istersiniz? (Örneğin: javascript)"
dosya_turu = gets.chomp

def dosyalariBul(url, dosya_turu)
  sayfa = Nokogiri::HTML(URI.open(url))
  linkler = sayfa.css('a').map { |link| link['href'] }

  aranan_dosyalar = linkler.select { |link| link if link&.include?(".#{dosya_turu}") }

  if aranan_dosyalar.empty?
    puts "Belirtilen türde dosya bulamadım:("
  else
    puts "Bulunan dosyalar:"
    aranan_dosyalar.each { |dosya| puts dosya }
  end
end

dosyalariBul(url, dosya_turu)
