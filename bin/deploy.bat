@echo off

::zip project
del ./bin/dist.zip
call "C:\Program Files\7-Zip\7z" a ./bin/dist.zip ./src/* ./node_modules

::upload to s3
call aws s3 cp ./bin/dist.zip s3://alexaprobasketballschedule/
echo [*] Zip uploaded to s3

::upload to lambda
call aws lambda update-function-code --function-name alexaHowToSkill --s3-bucket alexaprobasketballschedule --s3-key dist.zip
echo [*] Lambda function up to date
