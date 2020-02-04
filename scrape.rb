require "selenium-webdriver"

def url
  "https://www.gyosei.or.jp/members-search/"
end

options = Selenium::WebDriver::Firefox::Options.new
# options.add_argument('-headless')
driver = Selenium::WebDriver.for :firefox, options: options
driver.get url

# 「同意して検索する」のボタンを押す処理
alert_dialog = driver.find_element(class: "form-search-alert__button")
alert_dialog.click

sleep 2
# select boxから都道府県を選択
select_box = driver.find_element(name: "m_office_pref")
select_box.find_element(css: "option[value='北海道']").click

# 検索ボタンを押す
search_form = driver.find_element(class: "form-search-buttons")
search_buttons = search_form.find_elements(tag_name: "input") # 「リセット」と「検索」ボタンがヒットする
search_buttons[1].click
sleep 3

# テーブル全体を取得 偶数・奇数・「詳細」の3つがあり、各々にtable-search-even, table-search-odd, table-search-userdetailというクラス名がついている
table_search_usersinfo = driver.find_element(class: "table-search-usersinfo")
table_search_usersinfo_trs = table_search_usersinfo.find_elements(tag_name: "tr")
table_search_usersinfo_trs.each do |usersinfo_tr|
  if usersinfo_tr.attribute('class') == "table-search-odd" || usersinfo_tr.attribute('class') == "table-search-even"
    # 「詳細」をクリックして要素を表示させる
    table_search_trigger = usersinfo_tr.find_element(class: "table-search-trigger")
    table_search_trigger.click
    sleep 2
  elsif usersinfo_tr.attribute('class') == "table-search-userdetail"

    userdetail_inner = usersinfo_tr.find_element(class: "table-search-userdetail__inner")
    h2 = userdetail_inner.find_element(tag_name: "h2")
    puts h2.text # 行政書士の名前

    trs = userdetail_inner.find_elements(tag_name: "tr")
    trs.each do |tr|
      td = tr.find_element(tag_name: "td")
      if td.text == "" || td.text == "-"
        puts "xxx"
      else
        puts td.text
      end
    end
    sleep 1
  end
end

driver.quit