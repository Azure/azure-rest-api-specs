# CI Fix Guide

Here are guides to fix some of the CI failure.

## Spell check

Please add your words to `./custom-words.txt` if you think you have the correct spell

## Prettier check

Please run the following command (from an administrator Node.js command prompt if running on Windows):

```
npm install; npm run prettier-fix
```

Or if you want to fix specified service:

```
npm install; npm run prettier -- --write "specification/<service>/**/*.json"
```

Then please commit and push changes made by prettier.

## How to run model validation locally

Model validation is provided by OAV tool and the command to run model validation locally is `oav validate-example <spec-path>`. 
Please see [readme](https://github.com/Azure/oav/blob/master/README.md) in OAV reposiotry for installation and command usuage details.

## How to run semantic validation locally

Semantic validation is provided by OAV tool and the command to run model validation locally is `oav validate-spec <spec-path>`. 
Please see [readme](https://github.com/Azure/oav/blob/master/README.md) in OAV reposiotry for installation and command usuage details.

## How to fix model validation and semantic checks

Here is the [guideline](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/Semantic-and-Model-Violations-Reference.md) to understand the check failures and how to fix them.
