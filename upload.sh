#!/bin/bash

find $UPLOAD_FOLDER -type f -printf '%P\n' | xargs -I % -P 50 curl --request PUT --upload-file "$UPLOAD_FOLDER/%" "$S3_ENDPOINT/$S3_BUCKET_NAME/%"
