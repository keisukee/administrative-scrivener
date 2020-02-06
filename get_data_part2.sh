#!/bin/zsh

echo "愛媛県 is begin"
ruby scrape.rb 愛媛県 > output/愛媛県.txt
echo "高知県 is begin"
ruby scrape.rb 高知県 > output/高知県.txt
echo "福岡県 is begin"
ruby scrape.rb 福岡県 > output/福岡県.txt
echo "佐賀県 is begin"
ruby scrape.rb 佐賀県 > output/佐賀県.txt
echo "長崎県 is begin"
ruby scrape.rb 長崎県 > output/長崎県.txt
echo "熊本県 is begin"
ruby scrape.rb 熊本県 > output/熊本県.txt
echo "大分県 is begin"
ruby scrape.rb 大分県 > output/大分県.txt
echo "宮崎県 is begin"
ruby scrape.rb 宮崎県 > output/宮崎県.txt
echo "鹿児島県 is begin"
ruby scrape.rb 鹿児島県 > output/鹿児島県.txt
echo "沖縄県 is begin"
ruby scrape.rb 沖縄県 > output/沖縄県.txt