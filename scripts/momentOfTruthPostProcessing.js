// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

'use strict';

const fs = require('fs'),
      crypto = require('crypto'),
      utils = require('../test/util/utils'),
      path = require('path');

let pullRequestNumber = utils.getPullRequestNumber();
let targetBranch = utils.getTargetBranch();
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
`;

let githubFooter = `
[AutoRest Linter Guidelines](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/openapi-authoring-automated-guidelines.md) | [AutoRest Linter Issues](https://github.com/Azure/azure-openapi-validator/issues) | Send <a href='mailto:azure-swag-tooling@microsoft.com?subject=Feedback%20|%20AutoRest%20Linter%20Azure%20Bot'>feedback</a>

Thanks for your co-operation.
`;

let fileSummaryTemplate = `

**File**: [{file_name}]({file_href})

<details>
    <summary>:warning:<strong>{new_warnings}</strong> new Warnings ({total_warnings} total)</summary>
    {potential_new_warnings}
</details>

<details>
    <summary>:x:<strong>{new_errors}</strong> new Errors ({total_errors} total)</summary>
    {potential_new_errors}
</details>

`;

let potentialNewWarningErrorSummaryHeader = `
<br>
| Code | Id | Source | Message |
|------|----|--------|---------|
{list_of_new_warnings_errors}
`;

let potentialNewWarningErrorSummary = `| {warning_error_code} | {warning_error_id} | [Link]({warning_error_source}) | {warning_error_message} |
`;

let sdkContactMessage = "These errors are reported by the SDK team's validation tools, reachout to [ADX Swagger Reviewers](mailto:adxsr@microsoft.com) directly for any questions or concerns.";;
let armContactMessage = "These errors are reported by the ARM team's validation tools, reachout to [ARM RP API Review](mailto:armrpapireview@microsoft.com) directly for any questions or concerns.";
let sdkFileSummaries = '', armFileSummaries = '';

let data = fs.readFileSync(logFilepath, 'utf8');
let jsonData = JSON.parse(data);

function compareJsonRef(beforeJsonRef, afterJsonRef) {
    return (beforeJsonRef.replace(/json:\d+:\d+/, '') == afterJsonRef.replace(/json:\d+:\d+/, ''));
}

function getOutputMessages(newSDKErrorsCount, newARMErrorsCount, newSDKWarningsCount, newARMWarningsCount) {
    const totalNewErrors = newSDKErrorsCount + newARMErrorsCount;
    const totalNewWarnings = newSDKWarningsCount + newARMWarningsCount;
    const pluralize = (word, num) => num !== 1 ? `${word}s` : word;
    const iconFor = (type, num) => num > 0 ? (type === 'error' ? ':x:' : ':warning:') : ':white_check_mark:';

    const title = `${totalNewErrors} new ${pluralize('error', totalNewErrors)} / ${totalNewWarnings} new ${pluralize('warning', totalNewWarnings)}`;
    let summary = `Compared to the target branch (**${targetBranch}**), this pull request introduces:\n\n`;
    summary += `&nbsp;&nbsp;&nbsp;${iconFor('error', newSDKErrorsCount)}&nbsp;&nbsp;&nbsp;**${newSDKErrorsCount}** new SDK ${pluralize('error', newSDKErrorsCount)}\n\n`;
    summary += `&nbsp;&nbsp;&nbsp;${iconFor('error', newARMErrorsCount)}&nbsp;&nbsp;&nbsp;**${newARMErrorsCount}** new ARM ${pluralize('error', newARMErrorsCount)}\n\n`;
    summary += `&nbsp;&nbsp;&nbsp;${iconFor('warning', newSDKWarningsCount)}&nbsp;&nbsp;&nbsp;**${newSDKWarningsCount}** new SDK ${pluralize('warning', newSDKWarningsCount)}\n\n`;
    summary += `&nbsp;&nbsp;&nbsp;${iconFor('warning', newARMWarningsCount)}&nbsp;&nbsp;&nbsp;**${newARMWarningsCount}** new ARM ${pluralize('warning', newARMWarningsCount)}\n\n`;

    return [title, summary];
}

function getSummaryBlock(summaryTitle, fileSummaries, contactMessage) {
    let githubTemplateCopy = githubTemplate;
    githubTemplateCopy = githubTemplateCopy.replace("{title}", summaryTitle);
    githubTemplateCopy = githubTemplateCopy.replace("{file_summaries}", fileSummaries !== '' ? fileSummaries : `**There were no files containing new ${summaryTitle}.**`);
    githubTemplateCopy = githubTemplateCopy.replace("{contact_message}", contactMessage);
    return githubTemplateCopy;
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

function blobHref(file) {
    return `https://github.com/${process.env.TRAVIS_PULL_REQUEST_SLUG}/blob/${process.env.TRAVIS_PULL_REQUEST_SHA}/${file}`;
}

function getFileSummary(fileName, beforeWarningsArray, afterWarningsArray, beforeErrorsArray, afterErrorsArray, newWarnings, newErrors, prNumber) {
    let fileSummaryCopy = fileSummaryTemplate;
    fileSummaryCopy = fileSummaryCopy.replace("{file_name}", fileName);
    fileSummaryCopy = fileSummaryCopy.replace("{file_href}", blobHref(fileName));
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
    let newSDKErrorsCount = 0, newARMErrorsCount = 0, newSDKWarningsCount = 0, newARMWarningsCount = 0;

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

        newSDKErrorsCount += newSDKErrors.length;
        newARMErrorsCount += newARMErrors.length;
        newSDKWarningsCount += newSDKWarnings.length;
        newARMWarningsCount += newARMWarnings.length;

        let fileSummaryCopy = getFileSummary(fileName, beforeWarningsSDKArray, afterWarningsSDKArray, beforeErrorsSDKArray, afterErrorsSDKArray, newSDKWarnings, newSDKErrors, pullRequestNumber);
        sdkFileSummaries = sdkFileSummaries.concat(fileSummaryCopy);
        fileSummaryCopy = getFileSummary(fileName, beforeWarningsARMArray, afterWarningsARMArray, beforeErrorsARMArray, afterErrorsARMArray, newARMWarnings, newARMErrors, pullRequestNumber);
        armFileSummaries = armFileSummaries.concat(fileSummaryCopy);
    }

    const sdkSummary = getSummaryBlock("SDK-related validation Errors / Warnings", sdkFileSummaries, sdkContactMessage);
    const armSummary = getSummaryBlock("ARM-related validation Errors / Warnings", armFileSummaries, armContactMessage);
    
    const [title, summary] = getOutputMessages(newSDKErrorsCount, newARMErrorsCount, newSDKWarningsCount, newARMWarningsCount);
    const output = {
        title,
        summary,
        text: `${sdkSummary}\n<br><br>\n${armSummary}\n<br><br>\n${githubFooter}`
    }

    console.log("---output");
    console.log(JSON.stringify(output));
    console.log("---");

    if (newSDKErrorsCount > 0 || newARMErrorsCount > 0) {
        process.exitCode = 1;
    }
}

postProcessing();
