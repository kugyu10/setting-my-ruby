# 引数に gif/png/jpg 画像ファイルを指定すると、同名のwebp画像に変換する
#p "towebp.rb start."
inFileName = ARGV[0]
#p 'inFileName: ' + inFileName


#p !inFileName
#p !File.exist?(inFileName)


if( !inFileName || !File.exist?(inFileName) ) then
  p '引数が不正です'
  return 1
end

inFileName = ARGV[0]
extention = File.extname(inFileName)
#p extention
basename = File.basename(inFileName, extention )

outFileName = basename + '.webp'
#同名回避
fileNum = 0
while( File.exist?(outFileName) ) do
  fileNum += 1
  outFileName = basename + '_' + fileNum.to_s + '.webp'
end

if ('.gif' == extention.downcase) then
  exec "gif2webp -q 100 -metadata icc -o " + outFileName + " " + inFileName
  p 'gif2webp'
elsif ( '.png' == extention.downcase || '.jpeg' == extention.downcase || '.jpg' == extention.downcase ) then
  exec "cwebp -q 80 -metadata icc -o " + outFileName + " " +inFileName
  p 'cwebp'
end

