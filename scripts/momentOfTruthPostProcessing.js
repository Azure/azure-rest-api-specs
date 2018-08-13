// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

'use strict';

const fs = require('fs'),
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

let githubTemplate = (title, contact_message, file_summaries) => `# AutoRest linter results for ${title}\n${contact_message}\n\n${file_summaries}`;

let githubFooter = `[AutoRest Linter Guidelines](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/openapi-authoring-automated-guidelines.md) | ` +
    `[AutoRest Linter Issues](https://github.com/Azure/azure-openapi-validator/issues) | ` +
    `Send ${emailLink("feedback", "azure-swag-tooling@microsoft.com", "Feedback | AutoRest Linter Diff Tool")}` +
    `\n\nThanks for your co-operation.`;

let fileSummaryHeader = (file_name, file_href) => `## Config file: [${file_name}](${file_href})\n`;
let fileSummaryNewTemplate = (issue_type, issue_count, issue_table) => `### <a name="${issue_type.replace(/\s/g, "-")}s"></a>${iconFor(issue_type)} ${issue_count} new ${pluralize(issue_type, issue_count)}\n\n${issue_table}\n`;
let fileSummaryExistingTemplate = (issue_type, issue_count, issue_table) => `<details><summary>${iconFor(issue_type)} ${issue_count} existing ${pluralize(issue_type, issue_count)}</summary><br>\n\n${issue_table}\n</details>\n\n`;

let potentialNewWarningErrorSummaryHeader = `
| | Rule | Location | Message |
|-|------|----------|---------|
`;

let potentialNewWarningErrorSummary = (count, warning_error_id, warning_error_code, warning_error_file, warning_error_line, warning_error_message) =>
    `|${count}|[${warning_error_id} - ${warning_error_code}](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/openapi-authoring-automated-guidelines.md#${warning_error_id})|` +
    `[${shortName(warning_error_file)}:${warning_error_line}](${blobHref(warning_error_file)}#L${warning_error_line} "${warning_error_file}")|` +
    `${warning_error_message}|\n`;

let sdkContactMessage = "These errors are reported by the SDK team's validation tools, reachout to [ADX Swagger Reviewers](mailto:adxsr@microsoft.com) directly for any questions or concerns.";
let armContactMessage = "These errors are reported by the ARM team's validation tools, reachout to [ARM RP API Review](mailto:armrpapireview@microsoft.com) directly for any questions or concerns.";
let sdkFileSummaries = '', armFileSummaries = '';

let data = undefined;
let jsonData = undefined;
try {
    data = fs.readFileSync(logFilepath, 'utf8');
    jsonData = JSON.parse(data);
} catch (e) {
    console.log(`Failed to read diff results from file ${logFilepath}`);
    console.log("File content:");
    console.log(data);
}

function compareJsonRef(beforeJsonRef, afterJsonRef) {
    return (beforeJsonRef.replace(/json:\d+:\d+/, '') == afterJsonRef.replace(/json:\d+:\d+/, ''));
}

function getOutputMessages(newSDKErrorsCount, newARMErrorsCount, newSDKWarningsCount, newARMWarningsCount) {
    const totalNewErrors = newSDKErrorsCount + newARMErrorsCount;
    const totalNewWarnings = newSDKWarningsCount + newARMWarningsCount;

    const title = `${totalNewErrors} new ${pluralize('error', totalNewErrors)} / ${totalNewWarnings} new ${pluralize('warning', totalNewWarnings)}`;
    let summary = `Compared to the target branch (**${targetBranch}**), this pull request introduces:\n\n`;
    summary += formatSummaryLine("SDK Error", newSDKErrorsCount);
    summary += formatSummaryLine("ARM Error", newARMErrorsCount);
    summary += formatSummaryLine("SDK Warning", newSDKWarningsCount);
    summary += formatSummaryLine("ARM Warning", newARMWarningsCount);

    return [title, summary];
}

function formatSummaryLine(issueType, count) {
    let line = `&nbsp;&nbsp;&nbsp;${iconFor(issueType, count)}&nbsp;&nbsp;&nbsp;`;
    if (count > 0) {
        line += '[';
    }
    line += `**${count}** new ${pluralize(issueType, count)}`;
    if (count > 0) {
        line += `](#user-content-${issueType.replace(/\s/g, "-")}s)`;
    }
    line += "\n\n";
    return line;
}

function getSummaryBlock(summaryTitle, fileSummaries, contactMessage) {
    return githubTemplate(
        summaryTitle,
        contactMessage,
        fileSummaries !== "" ? fileSummaries : `**There were no files containing ${summaryTitle}.**`
    );
}

function compareBeforeAfterArrays(afterArray, beforeArray, existingArray, newArray) {
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
            if(errorFound) {
                existingArray.push(afterValue);
            } else {
                newArray.push(afterValue);
            }
        });
    }
}

function iconFor(type, num = undefined) {
    if (num === 0) {
        return ':white_check_mark:';
    }
    
    if (type.toLowerCase().includes('error')) {
        return ':x:';
    } else {
        return ':warning:';
    }
}

function pluralize(word, num) {
    return num !== 1 ? `${word}s` : word;
}

function getLine(jsonRef) {
    try {
        return jsonRef.substr(jsonRef.indexOf(".json:") + 6).split(':')[0];
    } catch (error) {
        return undefined;
    }
}

function getFile(jsonRef) {
    try {
        const start = jsonRef.indexOf("specification");
        return jsonRef.substr(start, (jsonRef.indexOf(".json") + 5) - start);
    } catch (error) {
        return undefined;
    }
}

function shortName(filePath) {
    return `${path.basename(path.dirname(filePath))}/&#8203;<strong>${path.basename(filePath)}</strong>`;
}

function blobHref(file) {
    return `https://github.com/${process.env.TRAVIS_PULL_REQUEST_SLUG}/blob/${process.env.TRAVIS_PULL_REQUEST_SHA}/${file}`;
}

function getFileSummaryTable(issues, prNumber) {
    let potentialNewIssues = potentialNewWarningErrorSummaryHeader;

    issues.sort((a, b) => {
        if (!a.filePath) {
            a.filePath = getFile(a.jsonref) || "";
            a.lineNumber = getLine(a.jsonref) || "1";
        }

        if (!b.filePath) {
            b.filePath = getFile(b.jsonref) || "";
            b.lineNumber = getLine(b.jsonref) || "1";
        }

        const comparison = a.filePath.localeCompare(b.filePath);
        if (comparison !== 0) {
            return comparison;
        } else if (a.lineNumber !== b.lineNumber) {
            return a.lineNumber - b.lineNumber;
        } else {
            return a.id.localeCompare(b.id);
        }
    });

    issues.forEach(function (issue, count) {
        if (!issue.filePath) {
            issue.filePath = getFile(issue.jsonref) || "";
            issue.lineNumber = getLine(issue.jsonref) || "1";
        }

        potentialNewIssues += potentialNewWarningErrorSummary(
            count + 1,
            issue.id,
            issue.code,
            issue.filePath,
            issue.lineNumber,
            issue.message
        );
    });

    return potentialNewIssues;
}

function getFileSummary(issueType, fileName, existingWarnings, existingErrors, newWarnings, newErrors, prNumber) {
    let fileSummary = "";

    if (newErrors.length > 0) {
        fileSummary += fileSummaryNewTemplate(`${issueType} Error`, newErrors.length, getFileSummaryTable(newErrors, prNumber));
    }

    if (existingErrors.length > 0) {
        fileSummary += fileSummaryExistingTemplate(`${issueType} Error`, existingErrors.length, getFileSummaryTable(existingErrors, prNumber));
    }

    if (fileSummary !== "") {
        fileSummary += "<br>\n\n";
    }

    if (newWarnings.length > 0) {
        fileSummary += fileSummaryNewTemplate(`${issueType} Warning`, newWarnings.length, getFileSummaryTable(newWarnings, prNumber));
    }

    if (existingWarnings.length > 0) {
        fileSummary += fileSummaryExistingTemplate(`${issueType} Warning`, existingWarnings.length, getFileSummaryTable(existingWarnings, prNumber));
    }

    if (fileSummary !== "") {
        return fileSummaryHeader(fileName, blobHref(fileName)) + fileSummary;
    } else {
        return "";
    }
}

function emailLink(title, addr, subject = "", body = "") {
    let link = `<a href='mailto:${addr}`;
    let sep = "?";
    if (subject && subject.length > 0) {
        link += `${sep}subject=${encodeURIComponent(subject)}`;
        sep = "&";
    }
    if (body && body.length > 0) {
        link += `${sep}body=${encodeURIComponent(body)}`;
    }
    link += `'>${title}</a>`;

    return link;
}

function postProcessing() {
    let newSDKErrorsCount = 0, newARMErrorsCount = 0, newSDKWarningsCount = 0, newARMWarningsCount = 0;

    if (!jsonData) {
        const reportLink = emailLink(
            "report this failure",
            "azure-swag-tooling@microsoft.com",
            "Failure | AutoRest Linter Diff Tool",
            `Please examine the failure in PR https://github.com/${process.env.TRAVIS_REPO_SLUG}/pull/${pullRequestNumber}\r\nThe failing job is https://travis-ci.org/${process.env.TRAVIS_REPO_SLUG}/jobs/${process.env.TRAVIS_JOB_ID}`
        );

        const output = {
            title: "Failed to produce a result",
            summary: `The Linter Diff tool failed to produce a result. Work with your reviewer to examine the lint results manually before merging.\n\nPlease ${reportLink}!`
        };

        console.log("---output");
        console.log(JSON.stringify(output));
        console.log("---");

        return;
    }

    const configFiles = Object.keys(jsonData['files']);
    configFiles.sort();

    for (const fileName of configFiles) {
        let beforeErrorsSDKArray = [], beforeWarningsSDKArray = [], beforeErrorsARMArray = [], beforeWarningsARMArray = [];
        let afterErrorsSDKArray = [], afterWarningsSDKArray = [], afterErrorsARMArray = [], afterWarningsARMArray = [];
        let newSDKErrors = [], newSDKWarnings = [], newARMErrors = [], newARMWarnings = [];
        let existingSDKErrors = [], existingSDKWarnings = [], existingARMErrors = [], existingARMWarnings = [];

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

        compareBeforeAfterArrays(afterErrorsARMArray, beforeErrorsARMArray, existingARMErrors, newARMErrors);
        compareBeforeAfterArrays(afterErrorsSDKArray, beforeErrorsSDKArray, existingSDKErrors, newSDKErrors);
        compareBeforeAfterArrays(afterWarningsARMArray, beforeWarningsARMArray, existingARMWarnings, newARMWarnings);
        compareBeforeAfterArrays(afterWarningsSDKArray, beforeWarningsSDKArray, existingSDKWarnings, newSDKWarnings);

        console.log("SDK Errors/Warnings");
        console.log("===================");
        console.log("Errors:    Before: ", beforeErrorsSDKArray.length, " - After: ", afterErrorsSDKArray.length);
        console.log("Warnings:  Before: ", beforeWarningsSDKArray.length, " - After: ", afterWarningsSDKArray.length);
        console.log("New SDK Errors: ", newSDKErrors.length);
        console.log("New SDK Warnings: ", newSDKWarnings.length);
        console.log("Existing SDK Errors: ", existingSDKErrors.length);
        console.log("Existing SDK Warnings: ", existingSDKWarnings.length);
        console.log();
        console.log("ARM Errors/Warnings");
        console.log("===================");
        console.log("Errors:    Before: ", beforeErrorsARMArray.length, " - After: ", afterErrorsARMArray.length);
        console.log("Warnings:  Before: ", beforeWarningsARMArray.length, " - After: ", afterWarningsARMArray.length);
        console.log("New ARM Errors: ", newARMErrors.length);
        console.log("New ARM Warnings: ", newARMWarnings.length);
        console.log("Existing ARM Errors: ", existingARMErrors.length);
        console.log("Existing ARM Warnings: ", existingARMWarnings.length);
        console.log();

        newSDKErrorsCount += newSDKErrors.length;
        newARMErrorsCount += newARMErrors.length;
        newSDKWarningsCount += newSDKWarnings.length;
        newARMWarningsCount += newARMWarnings.length;

        sdkFileSummaries += getFileSummary("SDK", fileName, existingSDKWarnings, existingSDKErrors, newSDKWarnings, newSDKErrors, pullRequestNumber);
        armFileSummaries += getFileSummary("ARM", fileName, existingARMWarnings, existingARMErrors, newARMWarnings, newARMErrors, pullRequestNumber);
    }

    const sdkSummary = getSummaryBlock("SDK-related validation Errors / Warnings", sdkFileSummaries, sdkContactMessage);
    const armSummary = getSummaryBlock("ARM-related validation Errors / Warnings", armFileSummaries, armContactMessage);
    
    const [title, summary] = getOutputMessages(newSDKErrorsCount, newARMErrorsCount, newSDKWarningsCount, newARMWarningsCount);
    const output = {
        title,
        summary,
        text: `${sdkSummary}<br><br>\n\n${armSummary}<br><br>\n\n${githubFooter}`
    }

    console.log("---output");
    console.log(JSON.stringify(output, null, 2));
    console.log("---");

    if (newSDKErrorsCount > 0 || newARMErrorsCount > 0) {
        process.exitCode = 1;
    }
}

postProcessing();
