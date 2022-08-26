# encoding: utf-8
# 画像をS3にアップする
# AWS CLIを事前にインストールし、`aws configure set`コマンドなどで設定しておいてください
require "date"

# AWS S3のbucket名
bucketName='s3://kugyu10-post/'

# AWS S3のURL
bucketURL='https://kugyu10-post.s3.ap-northeast-1.amazonaws.com/'

ARGV.each do |f|
  next if f.nil?
  p f
  
  if(!File.exist?(f)) then
    p '引数が不正です'
    next
  end

  extention = File.extname(f)
  ext = extention.downcase

  if( ext != '.webp' &&  ext != '.png' && ext != '.jpg' && ext != '.jpeg') then
    p '引数が不正です'
    next
  end

  dirname = Date.today.strftime("%Y/%m/")

  p `/usr/local/bin/aws s3 cp --acl public-read #{f} #{bucketName}#{dirname}`
  #TODO 上書き回避
  #TODO エラー処理

  #アップロード成功時のパス
  uploadedFileURL = bucketURL + dirname + File.basename(f)
  `open #{uploadedFileURL}`

end
