// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

'use strict';

const octokit = require('@octokit/rest')(),
      fs = require('fs'),
      crypto = require('crypto'),
      utils = require('../test/util/utils'),
      path = require('path');

let pullRequestNumber = utils.getPullRequestNumber();
let filename = `${pullRequestNumber}.json`;
let logFilepath = path.join(getLogDir(), filename);

function getLogDir() {
    let logDir = path.join(__dirname, '../', 'output');
    return logDir;
}

let githubTemplate = `
<h1>
    AutoRest linter results for {title}
</h1>

{contact_message}

{file_summaries}

[AutoRest Linter Guidelines](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/openapi-authoring-automated-guidelines.md) | [AutoRest Linter Issues](https://github.com/Azure/azure-openapi-validator/issues) | Send <a href='mailto:azure-swag-tooling@microsoft.com?subject=Feedback%20|%20AutoRest%20Linter%20Azure%20Bot'>feedback</a>

Thanks for your co-operation.
`;

let fileSummaryTemplate = `

**File**: {file_name}

<details>
    <summary>:warning:<strong>{new_warnings}</strong> new Warnings.(<strong>{total_warnings}</strong> total)</summary>
    <br/>
    {potential_new_warnings}
</details>

<details>
    <summary>:x:<strong>{new_errors}</strong> new Errors.(<strong>{total_errors}</strong> total)</summary>
    <br/>
    {potential_new_errors}
</details>

`;

let potentialNewWarningErrorSummaryHeader = `
|   Code  |  Id |  Source   |   Message  |
|---------|----------|-------|-----------|
{list_of_new_warnings_errors}
`;

let potentialNewWarningErrorSummary = `| {warning_error_code} | {warning_error_id} | [Link]({warning_error_source}) | {warning_error_message} |
`;

let sdkContactMessage = "These errors are reported by the SDK team's validation tools, reachout to [ADX Swagger Reviewers](mailto:adxsr@microsoft.com) directly for any questions or concerns.";;
let armContactMessage = "These errors are reported by the ARM team's validation tools, reachout to [ARM RP API Review](mailto:armrpapireview@microsoft.com) directly for any questions or concerns.";
let sdkFileSummaries = '', armFileSummaries = '';

let data = fs.readFileSync(logFilepath, 'utf8');
let jsonData = JSON.parse(data);

let token = process.env.GH_TOKEN;

octokit.authenticate({
    type: 'token',
    token: token
});

function compareJsonRef(beforeJsonRef, afterJsonRef) {
    return (beforeJsonRef.replace(/json:\d+:\d+/, '') == afterJsonRef.replace(/json:\d+:\d+/, ''));
}

function postGithubComment(owner, repository, prNumber, commentBody) {
    octokit.issues.createComment({
        "owner": owner,
        "repo": repository,
        "number": prNumber,
        "body": commentBody
    }).then(data => {
        console.log("Comment has been posted");
    }). catch(err => {
        console.log(err);
    });
}

function postSummariesToGithub(summaryTitle, fileSummaries, org, repository, prNumber, contactMessage) {
    let githubTemplateCopy = githubTemplate;
    githubTemplateCopy = githubTemplateCopy.replace("{title}", summaryTitle);
    githubTemplateCopy = githubTemplateCopy.replace("{file_summaries}", fileSummaries);
    githubTemplateCopy = githubTemplateCopy.replace("{contact_message}", contactMessage);
    postGithubComment(org, repository, prNumber, githubTemplateCopy);
}

function compareBeforeAfterArrays(afterArray, beforeArray, newArray) {
    if(afterArray.length > beforeArray.length){
        afterArray.forEach(afterValue => {
            let errorFound = false;
            beforeArray.forEach(beforeValue => {
                if(
                    beforeValue.type               == afterValue.type &&
                    beforeValue.code               == afterValue.code &&
                    beforeValue.message            == afterValue.message &&
                    beforeValue.id                 == afterValue.id &&
                    beforeValue.validationCategory == afterValue.validationCategory &&
                    beforeValue.providerNamespace  == afterValue.providerNamespace &&
                    beforeValue.resourceType       == afterValue.resourceType &&
                    beforeValue.sources.length     == afterValue.sources.length &&
                    compareJsonRef(beforeValue.jsonref, afterValue.jsonref)
                ) {
                    errorFound = true;
                }
            });
            if(!errorFound) {
                newArray.push(afterValue);
            }
        });
    }
}

function getLink(jsonRef, prNumber){    
    let line = "1";
    
    try {
        line = jsonRef.substr(jsonRef.indexOf(".json:") + 6).split(':')[0];
    } catch(error) {
        line = "1";
    }

    let fileName = jsonRef.substr(jsonRef.indexOf("specification"), (jsonRef.indexOf(".json") + 5) - jsonRef.indexOf("specification"));
    let md5 = crypto.createHash('md5').update(fileName).digest("hex");

    let link = "https://github.com/" + process.env.TRAVIS_REPO_SLUG + "/pull/"
                        + prNumber 
                        + "/files?diff=unified#diff-" 
                        + md5 + "R" + line;

    return link;
}

function getFileSummary(fileName, beforeWarningsArray, afterWarningsArray, beforeErrorsArray, afterErrorsArray, newWarnings, newErrors, prNumber) {
    let fileSummaryCopy = fileSummaryTemplate;
    fileSummaryCopy = fileSummaryCopy.replace("{file_name}", fileName);
    fileSummaryCopy = fileSummaryCopy.replace("{before_warnings}", beforeWarningsArray.length);
    fileSummaryCopy = fileSummaryCopy.replace("{after_warnings}", afterWarningsArray.length);
    fileSummaryCopy = fileSummaryCopy.replace("{before_errors}", beforeErrorsArray.length);
    fileSummaryCopy = fileSummaryCopy.replace("{after_errors}", afterErrorsArray.length);

    
    fileSummaryCopy = fileSummaryCopy.replace("{new_warnings}", newWarnings.length);
    fileSummaryCopy = fileSummaryCopy.replace("{new_errors}", newErrors.length);
    fileSummaryCopy = fileSummaryCopy.replace("{total_warnings}", afterWarningsArray.length);
    fileSummaryCopy = fileSummaryCopy.replace("{total_errors}", afterErrorsArray.length);

    if(newWarnings.length > 0){
        let potentialNewWarnings = '';
        newWarnings.forEach(function(newWarning) {
            let potentialNewWarningErrorSummaryCopy = potentialNewWarningErrorSummary;
            potentialNewWarningErrorSummaryCopy = potentialNewWarningErrorSummaryCopy.replace("{warning_error_code}", newWarning.code);
            potentialNewWarningErrorSummaryCopy = potentialNewWarningErrorSummaryCopy.replace("{warning_error_message}", newWarning.message);
            potentialNewWarningErrorSummaryCopy = potentialNewWarningErrorSummaryCopy.replace("{warning_error_id}", newWarning.id);
            potentialNewWarningErrorSummaryCopy = potentialNewWarningErrorSummaryCopy.replace("{warning_error_source}", getLink(newWarning.jsonref, prNumber));
            potentialNewWarnings = potentialNewWarnings.concat(potentialNewWarningErrorSummaryCopy);
        });
        fileSummaryCopy = fileSummaryCopy.replace("{potential_new_warnings}", potentialNewWarningErrorSummaryHeader.replace("{list_of_new_warnings_errors}", potentialNewWarnings).replace("{table_title}", "Potential New Warnings"))
    } else {
        fileSummaryCopy = fileSummaryCopy.replace("{potential_new_warnings}", "");
    }

    if(newErrors.length > 0){
        let potentialNewErrors = '';
        newErrors.forEach(function(newError) {
            let potentialNewWarningErrorSummaryCopy = potentialNewWarningErrorSummary;
            potentialNewWarningErrorSummaryCopy = potentialNewWarningErrorSummaryCopy.replace("{warning_error_code}", newError.code);
            potentialNewWarningErrorSummaryCopy = potentialNewWarningErrorSummaryCopy.replace("{warning_error_message}", newError.message);
            potentialNewWarningErrorSummaryCopy = potentialNewWarningErrorSummaryCopy.replace("{warning_error_id}", newError.id);
            potentialNewWarningErrorSummaryCopy = potentialNewWarningErrorSummaryCopy.replace("{warning_error_source}", getLink(newError.jsonref, prNumber));
            potentialNewErrors = potentialNewErrors.concat(potentialNewWarningErrorSummaryCopy);
        });
        fileSummaryCopy = fileSummaryCopy.replace("{potential_new_errors}", potentialNewWarningErrorSummaryHeader.replace("{list_of_new_warnings_errors}", potentialNewErrors).replace("{table_title}", "Potential New Errors"))
    } else {
        fileSummaryCopy = fileSummaryCopy.replace("{potential_new_errors}", "");
    }

    return fileSummaryCopy;
}

function postProcessing() {
    for(var fileName in jsonData['files']) {
        let beforeErrorsSDKArray = [], beforeWarningsSDKArray = [], beforeErrorsARMArray = [], beforeWarningsARMArray = [];
        let afterErrorsSDKArray = [], afterWarningsSDKArray = [], afterErrorsARMArray = [], afterWarningsARMArray = [];
        let newSDKErrors = [], newSDKWarnings = [], newARMErrors = [], newARMWarnings = [];

        let beforeErrorsAndWarningsArray = jsonData['files'][fileName]['before'];
        beforeErrorsAndWarningsArray.forEach(beforeErrorOrWarning => {
            if(beforeErrorOrWarning.type.toLowerCase() == 'warning'){
                if(beforeErrorOrWarning.validationCategory.toLowerCase() == 'sdkviolation') {
                    beforeWarningsSDKArray.push(beforeErrorOrWarning);
                } else {
                    beforeWarningsARMArray.push(beforeErrorOrWarning);
                }
            }

            if(beforeErrorOrWarning.type.toLowerCase() == 'error'){
                if(beforeErrorOrWarning.validationCategory.toLowerCase() == 'sdkviolation') {
                    beforeErrorsSDKArray.push(beforeErrorOrWarning);
                } else {
                    beforeErrorsARMArray.push(beforeErrorOrWarning);
                }
            }
        });

        let afterErrorsAndWarningsArray = jsonData['files'][fileName]['after'];
        afterErrorsAndWarningsArray.forEach(afterErrorOrWarning => {
            if(afterErrorOrWarning.type.toLowerCase() == 'warning'){
                if(afterErrorOrWarning.validationCategory.toLowerCase() == 'sdkviolation') {
                    afterWarningsSDKArray.push(afterErrorOrWarning);
                } else {
                    afterWarningsARMArray.push(afterErrorOrWarning);
                }
            }

            if(afterErrorOrWarning.type.toLowerCase() == 'error'){
                if(afterErrorOrWarning.validationCategory.toLowerCase() == 'sdkviolation') {
                    afterErrorsSDKArray.push(afterErrorOrWarning);
                } else {
                    afterErrorsARMArray.push(afterErrorOrWarning);
                }
            }
        });

        compareBeforeAfterArrays(afterErrorsARMArray, beforeErrorsARMArray, newARMErrors);
        compareBeforeAfterArrays(afterErrorsSDKArray, beforeErrorsSDKArray, newSDKErrors);
        compareBeforeAfterArrays(afterWarningsARMArray, beforeWarningsARMArray, newARMWarnings);
        compareBeforeAfterArrays(afterWarningsSDKArray, beforeWarningsSDKArray, newSDKWarnings);

        console.log("SDK Errors/Warnings");
        console.log("===================");
        console.log("Errors:    Before: ", beforeErrorsSDKArray.length, " - After: ", afterErrorsSDKArray.length);
        console.log("Warnings:  Before: ", beforeWarningsSDKArray.length, " - After: ", afterWarningsSDKArray.length);
        console.log("New SDK Errors: ", newSDKErrors.length);
        console.log("New SDK Warnings: ", newSDKWarnings.length);
        console.log();
        console.log("ARM Errors/Warnings");
        console.log("===================");
        console.log("Errors:    Before: ", beforeErrorsARMArray.length, " - After: ", afterErrorsARMArray.length);
        console.log("Warnings:  Before: ", beforeWarningsARMArray.length, " - After: ", afterWarningsARMArray.length);
        console.log("New ARM Errors: ", newARMErrors.length);
        console.log("New ARM Warnings: ", newARMWarnings.length);
        console.log();

        let fileSummaryCopy = getFileSummary(fileName, beforeWarningsSDKArray, afterWarningsSDKArray, beforeErrorsSDKArray, afterErrorsSDKArray, newSDKWarnings, newSDKErrors, pullRequestNumber);
        sdkFileSummaries = sdkFileSummaries.concat(fileSummaryCopy);
        fileSummaryCopy = getFileSummary(fileName, beforeWarningsARMArray, afterWarningsARMArray, beforeErrorsARMArray, afterErrorsARMArray, newARMWarnings, newARMErrors, pullRequestNumber);
        armFileSummaries = armFileSummaries.concat(fileSummaryCopy);
    }

    let slug = process.env.TRAVIS_REPO_SLUG;
    slug = slug.split("/")[1];
    postSummariesToGithub("SDK Related Validation Errors/Warnings", sdkFileSummaries, "Azure", slug, pullRequestNumber, sdkContactMessage);
    postSummariesToGithub("ARM Related Validation Errors/Warnings", armFileSummaries, "Azure", slug, pullRequestNumber, armContactMessage);
}

postProcessing();
