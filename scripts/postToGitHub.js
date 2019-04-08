// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

'use strict';

const octokit = require('@octokit/rest')();
let token = process.env.GITHUB_TOKEN;

if(token != undefined) {
    octokit.authenticate({
        type: 'token',
        token: token
    });
}

module.exports = {
    postGithubComment: function(owner, repository, prNumber, commentBody) {
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
}