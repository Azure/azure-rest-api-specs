import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DevHub;

@@clientName(GitHubOAuthInfoResponse.authURL, "authUrl", "java");
@@clientName(AdooAuthInfoResponse.authURL, "authUrl", "java");
@@clientName(GitHubWorkflowProfile.prURL, "prUrl", "java");
@@clientName(WorkflowRun.workflowRunURL, "workflowRunUrl", "java");
@@clientName(PullRequest.prURL, "prUrl", "java");
@@clientName(Microsoft.DevHub, "DeveloperHubServiceClient", "javascript,java");
@@clientName(ACR, "Acr", "java,javascript");
@@clientName(Deployment, "DeploymentProperties", "java,javascript");
@@clientName(GitHubWorkflowProfile.deploymentProperties,
  "deploymentProperties",
  "java"
);
@@clientLocation(GitHubOAuthResponses.gitHubOAuthCallback,
  Microsoft.DevHub,
  "javascript"
);
@@clientLocation(GitHubOAuthResponses.listGitHubOAuth,
  Microsoft.DevHub,
  "javascript"
);
@@clientLocation(GitHubOAuthResponses.gitHubOAuth,
  Microsoft.DevHub,
  "javascript"
);
