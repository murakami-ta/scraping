require 'open-uri'
require 'nokogiri'
require "pry"
require 'csv'

File.open('fax_stores.csv', 'w', encoding: "SJIS") do |f|
  csv_string = CSV.generate do |csv|
    csv << ['掲載名', 'FAX番号', '住所']

    domain = "http://nttbj.itp.ne.jp/"

    charset = nil

    (1..20).each do |i|
      url = "https://itp.ne.jp/saitama/genre_dir/house/pg/#{i}/?num=50"
      doc = Nokogiri::HTML(open(url))
      store_list = doc.css(".blueText")


      store_list.each do |s|
        s.attributes["href"].value.match(/%2F(.+)%2F/)
        s_doc = Nokogiri::HTML(open(domain + $1))
        target = s_doc.css("table.basicFirst")
        tmp_hash = {}

        target.search("tr").each do |tr|
          case tr.children.css("th").text
          when '掲載名'
            tmp_hash['掲載名'] = tr.children.css("td").text
          when '電話番号FAX番号'
            tmp_hash['FAX番号'] = tr.children.css("td").last.text
          when '住所'
            tmp_hash['住所'] = tr.children.css("td").text.gsub(/(\r\n|\r|\n)/, "").gsub(/if.+/, "")
          end
        end
        puts "#{i}ページ目 #{[tmp_hash['掲載名'], tmp_hash['FAX番号'], tmp_hash['住所']]}"
        csv << [tmp_hash['掲載名'], tmp_hash['FAX番号'], tmp_hash['住所']] unless tmp_hash.empty?
      end
    end
  end.encode(Encoding::SJIS, invalid: :replace, undef: :replace)
  f.puts csv_string
end


