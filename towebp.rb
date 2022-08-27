# encoding: utf-8
# 引数に gif/png/jpg 画像ファイルを指定すると、同名のwebp画像に変換する
# cwebp コマンドを事前にインストールしておいてください

ARGV.each do |f|

  inFileName = f
  
  if( !inFileName || !File.exist?(inFileName) ) then
    p '引数が不正です'
    return 1
  end
  
  extention = File.extname(inFileName)
  basename = File.basename(inFileName, extention )
  outFileName = File.dirname(f) +"/"+ basename + '.webp'

  #同名回避
  fileNum = 0
  while( File.exist?(outFileName) ) do
    fileNum += 1
    outFileName = basename + '_' + fileNum.to_s + '.webp'
  end

  p 'outFileName: ' + outFileName
  
  if ('.gif' == extention.downcase) then
    p 'gif2webp:'
    `/usr/local/bin/gif2webp -q 100 -metadata icc -o #{outFileName} #{inFileName}`
  elsif ( '.png' == extention.downcase || '.jpeg' == extention.downcase || '.jpg' == extention.downcase ) then
    p 'cwebp:'
    p `/usr/local/bin/cwebp -q 80 -metadata icc -o #{outFileName} #{inFileName}`
  end
  
  p "toweb.rb end."
end
  