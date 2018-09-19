// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

'use strict';

const octokit = require('@octokit/rest')(),
      crypto = require('crypto');

let githubTemplatePostToGitHub = `
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

let potentialNewWarningErrorSummaryHeaderPostToGitHub = `
|   Code  |  Id |  Source   |   Message  |
|---------|----------|-------|-----------|
{list_of_new_warnings_errors}
`;

let potentialNewWarningErrorSummary = `| {warning_error_code} | {warning_error_id} | [Link]({warning_error_source}) | {warning_error_message} |
`;


let token = process.env.GITHUB_TOKEN;

if(token != undefined) {
    octokit.authenticate({
        type: 'token',
        token: token
    });
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

module.exports = {
    postSummariesToGithub: function(summaryTitle, fileSummaries, org, repository, prNumber, contactMessage) {
        let githubTemplateCopy = githubTemplatePostToGitHub;
        githubTemplateCopy = githubTemplateCopy.replace("{title}", summaryTitle);
        githubTemplateCopy = githubTemplateCopy.replace("{file_summaries}", fileSummaries);
        githubTemplateCopy = githubTemplateCopy.replace("{contact_message}", contactMessage);
        postGithubComment(org, repository, prNumber, githubTemplateCopy);
    },

    getFileSummaryPostToGitHub: function(fileName, beforeWarningsArray, afterWarningsArray, beforeErrorsArray, afterErrorsArray, newWarnings, newErrors, prNumber) {
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
            fileSummaryCopy = fileSummaryCopy.replace("{potential_new_warnings}", potentialNewWarningErrorSummaryHeaderPostToGitHub.replace("{list_of_new_warnings_errors}", potentialNewWarnings).replace("{table_title}", "Potential New Warnings"))
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
            fileSummaryCopy = fileSummaryCopy.replace("{potential_new_errors}", potentialNewWarningErrorSummaryHeaderPostToGitHub.replace("{list_of_new_warnings_errors}", potentialNewErrors).replace("{table_title}", "Potential New Errors"))
        } else {
            fileSummaryCopy = fileSummaryCopy.replace("{potential_new_errors}", "");
        }
    
        return fileSummaryCopy;
    }
}