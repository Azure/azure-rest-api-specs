* Create a new branch in your fork local git repo
```
git checkout -b release-cognitiveservices-Language-2022-10-01
```

* Copy feature branch /dev folder to /specification folder
```
cp -r <path_to_you_feature_branch>/dev/cognitiveservices/data-plane/Language/ specification/cognitiveservices/data-plane/Language/preview/2022-10-01-preview/
```

* bump up version
```
cd specification/cognitiveservices/data-plane/Language/preview/2022-10-01-preview/

rm *.md

find ./ -type f -name *.json -exec sed -i 's/2022-07-01-preview/2022-10-01-preview/g' {} \;


```

* manually edit readme.md
Example commit: https://github.com/Azure/azure-rest-api-specs/pull/20206/commits/8b423ae6d5bd227926d9dcb340aa0857a10520d4

* publish
```
git add
git commit -m "test"
```
* push and create draft PR