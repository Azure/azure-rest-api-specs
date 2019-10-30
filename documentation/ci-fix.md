# CI Fix Guide

Here are guides to fix some of the CI failure.

## Spell check

Please add your words to `./custom-words.txt` if you think you have the correct spell

## Prettier check

Please run the following command:

`sh
npm install; npm run prettier-fix
`

Or if you want to fix specified service:

`sh
npm install; npm run prettier -- --write "specification/<service>/**/*.json"
`
