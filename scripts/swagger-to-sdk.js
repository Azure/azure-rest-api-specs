// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

'use strict'

const exec = require('child_process').exec

async function runScript() {
    const pull_request_num = parseInt(process.env['TRAVIS_PULL_REQUEST'])
    const target_slug = process.argv[2]
    const target_base = process.argv[3]
    const payload = {
        pull_request_num,
        repo_slug: "Azure/azure-rest-api-specs",
        target_slug
    }

    if (target_base && target_base !== "") {
        payload.target_base = target_base
    }
    
    const cmd = `curl -d '${JSON.stringify(payload)}' -H "Content-Type: application/json" -H "Accept: application/json" https://swaggertosdk.k8s.azure-devex-tools.com/travis`
    console.log(`Executing: ${cmd}`);
    const { err, stdout, stderr } = await new Promise(res => exec(cmd, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 },
        (err, stdout, stderr) => res({ err: err, stdout: stdout, stderr: stderr })))

    if (err) {
        console.log(err)
        console.log("---")
        console.log(stderr)
        console.log("---")
        console.log(stdout)
        process.exit(1)
    }

    console.log(stdout)

    let result
    try {
        result = JSON.parse(stdout)
    } catch (e) {
        process.exit(1)
    }
    const {
        success,
        text,
        output
    } = result

    console.log("---output")
    console.log(JSON.stringify(output, null, 2))
    console.log("---")

    console.log(text)

    process.exit(success ? 0 : 1)
}

runScript()