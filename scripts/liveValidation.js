// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';

const utils = require('../test/util/utils'),
    request = require('request-promise-native'),
    zlib = require('zlib');

const repoUrl = utils.getSourceRepoUrl(),
    validationService = "https://app.azure-devex-tools.com/api/validations",
    branch = utils.getSourceBranch(),
    processingDelay = 20,
    isRunningInTravisCI = process.env.MODE === 'liveValidation' && process.env.PR_ONLY === 'true',
    specsPaths = utils.getFilesChangedInPR(),
    regex = /resource-manager[\\|\/](.*?)[\\|\/].*?[\\|\/](.*?)[\\|\/]/,
    successThreshold = 90,
    validationModels = new Map();

let durationInSeconds = parseInt(process.env.LIVE_VALIDATION_DURATION_IN_MINUTES) * 60;
if (isNaN(durationInSeconds)) {
    durationInSeconds = 180;
}

async function runScript() {
    // See whether script is in Travis CI context
    console.log(`isRunningInTraviSCI: ${isRunningInTravisCI}`);
    for (const specPath of specsPaths) {
        let matchResult = specPath.match(regex);

        if (matchResult === null) {
            continue;
        }

        let resourceProvider = matchResult[1];
        let apiVersion = matchResult[2];

        if (!validationModels.has(resourceProvider)) {
            validationModels.set(resourceProvider, new Set());
        }

        validationModels.get(resourceProvider).add(apiVersion);
    }

    if (validationModels.size === 0) {
        console.log("Change didn't affect any swagger specs. No validation to be done.");
        return;
    } else if (validationModels.size > 1) {
        console.log("WARNING: Multiple resource provider have changes, only the first one will be validated.");
    }

    let resourceProvider = validationModels.keys().next().value;

    if (validationModels.get(resourceProvider).size > 1) {
        console.log("WARNING: Multiple api versions have changes, only the first one will be validated.");
    }

    let apiVersion = validationModels.get(resourceProvider).values().next().value;

    console.log(`Changes detected in a swagger spec.`);
    console.log(`RP is: ${resourceProvider}`);
    console.log(`ApiVersion is: ${apiVersion}`);
    console.log(`Source repo is: ${repoUrl}`);
    console.log(`Branch is: ${branch}`);

    console.log(`Making the request to the validation service...`);

    let response = await request.post(validationService).form({
        repoUrl: repoUrl,
        branch: branch,
        resourceProvider: resourceProvider,
        apiVersion: apiVersion,
        duration: durationInSeconds
    });
    let validationId = JSON.parse(response).validationId;

    let validationResultUrl = `${validationService}/${validationId}`;
    console.log(`Request done, results will be available in ${durationInSeconds} seconds...`);

    await timeout((durationInSeconds + processingDelay) * 1000);
    let validationResult = JSON.parse(await request(validationResultUrl));

    console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    console.log(`Results of validation ${validationId}:`);

    let analyticsUrl = await createAnalyticsLink(validationId);

    let failingOperations = [];
    let noTrafficOperations = [];
    for (const [operationId, operationResult] of Object.entries(validationResult.operationResults)) {

        if (operationResult.operationCount === 0) {
            noTrafficOperations.push(operationResult.operationId)
        } else if (operationResult.successRate < successThreshold) {
            failingOperations.push(operationResult.operationId);
        }

        console.log(JSON.stringify(operationResult));
    }

    console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    if (validationResult.totalOperationCount === 0) {
        console.log(`There was no traffic detected for the provided RP and API version:${resourceProvider}-${apiVersion}. Please make sure there is traffic so the changes can be validated.`);
        process.exitCode = 1;
    } else if (failingOperations.length > 0 || noTrafficOperations.length > 0) {
        console.log(`The changes in the specs introduced by this PR potentially do not reflect the Service API.`);

        console.log(`Active traffic and success rate > ${successThreshold}% FOR EACH OPERATION is required. Please review the following operations before moving forward.`);
        console.log(`SUCCESS RATE < ${successThreshold}%:
        ${JSON.stringify(failingOperations)}`);

        if (noTrafficOperations.length > 0) {
            console.log(`NO TRAFFIC:
         ${JSON.stringify(noTrafficOperations)}
         `);
        }
        console.log(`To inspect the individual failures go to the url (add '| where customDimensions.operationId == "<OPERATION_ID>"' to filter for individual operations.):
        ${analyticsUrl}
        `);
        process.exitCode = 1;
    } else {
        console.log(`SUCCESS RATE: ${validationResult.successRate} > ${successThreshold}. You can move forward.`);
    }
}

function timeout(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function createAnalyticsLink(validationId) {
    return new Promise(resolve => {
        const query = `
traces
| where customDimensions.validationId == "${validationId}"
| where customDimensions.logType == "data"
| where customDimensions.isSuccess == "false"
| project timestamp, message, customDimensions
`;

        zlib.deflate(query, (err, buffer) => {
            if (!err) {
                let queryParams = buffer.toString('base64');
                let analyticsLink = `https://analytics.applicationinsights.io/subscriptions/6b085460-5f21-477e-ba44-1035046e9101/resourcegroups/openapi-platform-logs/components/openapiAI?q=${queryParams}&apptype=Node.JS&timespan=P1D`;
                resolve(analyticsLink);
            }
        });
    });
}

runScript().then(success => {
    console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    console.log(`Thanks for using live validation.`);
    console.log(`If you encounter any issue(s), please open issue(s) at https://github.com/Azure/openapi-platform/issues .`);
}).catch(err => {
    console.log(err);
    process.exitCode = 1;
});
