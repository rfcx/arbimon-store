# Arbimon Store

For apps that access Arbimon's storage directly -- typically to mock S3.

See [Arbimon Soundscapes](https://github.com/rfcx/arbimon-soundscapes) for usage as a git submodule.

Typical usage:

1. Download the mock data for core or legacy or both

   Core (300MB) - the `rfcx-streams-production` bucket, including 1 project with 4 sites
   ```
   aws s3 cp s3://rfcx-dev/mock-data/core-bucket.zip mock-data/core-bucket.zip
   unzip mock-data/core-bucket.zip -d mock-data/
   rm -rf mock-data/core-bucket.zip mock-data/__MACOSX
   ```

   Legacy (13GB) - the `project_123` style `arbimon2` bucket, including 2 projects with 3-5 sites each
   ```
   aws s3 cp s3://rfcx-dev/mock-data/arbimon-legacy-bucket.zip mock-data/legacy-bucket.zip
   unzip mock-data/legacy-bucket.zip -d mock-data/
   rm -rf mock-data/legacy-bucket.zip mock-data/__MACOSX
   ```

2. Reference this repo's docker-compose in your app's docker-compose and add `depends_on: s3mock`

3. Start your app and upload your mock data

    ```
    docker compose up -d --wait
    ... wait a few secs ...
    docker compose run --rm -v ${PWD}/mock-data/core-bucket:/up -v ${PWD}/upload.sh:/upload.sh -e UPLOAD_FOLDER=/up -e S3_BUCKET_NAME=core-bucket -e S3_ENDPOINT=http://s3mock:9090 app bash /upload.sh
    docker compose run --rm -v ${PWD}/mock-data/legacy-bucket:/up -v ${PWD}/upload.sh:/upload.sh -e UPLOAD_FOLDER=/up -e S3_BUCKET_NAME=legacy-bucket -e S3_ENDPOINT=http://s3mock:9090 app bash /upload.sh
    ```

4. Enjoy testing your app



## Use the AWS CLI

_Requires AWS CLI to be installed._

### Examples

To download an object to your local machine:

```
aws s3api get-object --bucket legacy-bucket --key project_1907/soundscapes/5852/image.png --endpoint-url=http://localhost:9090 5852-image.png
```
