require 'spreadsheet'

def read_file(file_name)
  original_data = []
  count = 0
  File.open(file_name, "r") do |f|
    f.each_line do |line|
      if count % 11 == 0 && line
        original_data << []
      end
      if line.include?("スクレイピングできません")
        original_data[original_data.length - 1] << line.gsub(/\n/, "")
        count = 0
        next
      else
        original_data[original_data.length - 1] << line.gsub(/\n/, "")
        count += 1
      end
    end
  end
  original_data
end

def create_sheet(sheet_name, original_data)
  # 新規作成
  book = Spreadsheet::Workbook.new
  sheet = book.create_worksheet(name: "1")
  sheet.row(0).concat %w{地域 名前 登録番号 所属行政書士会 属性 登録年月日 事務所の名称 事務所所在地 事務所電話番号 特定行政書士 主な取り扱い業}
  
  # 事務所の重複を省く
  # 税理士の名前（上の名前or下の名前）が税理士事務所に含まれる
  # 同じ事務所内で出てくる人は一人（代表）
  # 判定漏れで省かれてしまう事務所は仕方ない
  
  l = original_data.length
  
  index_to_show = []
  
  l.times do |i|
    index_to_show << i
  end
  index_to_show.each_with_index do |value, index|
    original_data[value].each_with_index do |single_data, j|
      if single_data == 'xxx'
        sheet[index + 1, j] = ''
      else
        sheet[index + 1, j] = single_data
      end
    end
  end
  book.write(sheet_name)
end

input_file_name = ARGV[0]
output_sheet_name = ARGV[1]

original_data = read_file(input_file_name)
create_sheet(output_sheet_name, original_data)

# カラム x = 11個
# 地域
# 名前
# 登録番号
# 所属行政書士会
# 属性
# 登録年月日
# 事務所の名称
# 事務所所在地
# 事務所電話番号
# 特定行政書士
# 主な取り扱い業務