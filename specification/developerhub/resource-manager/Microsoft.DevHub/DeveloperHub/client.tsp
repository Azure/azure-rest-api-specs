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
// consistency on "AdoOAuth"
@@clientName(AdooAuthResponse, "AdoOAuthResponse", "java");
@@clientName(AdooAuthResponses, "AdoOAuthResponses", "java");
@@clientName(AdooAuthCallRequest, "AdoOAuthCallRequest", "java");
@@clientName(AdooAuthInfoResponse, "AdoOAuthInfoResponse", "java");
@@clientName(AdooAuthListResponse, "AdoOAuthListResponse", "java");
@@clientName(ADOOAuth, "AdoOAuth", "java");
@@clientName(AdooAuthResponses.getADOOAuthInfo, "getAdoOAuthInfo", "java");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "list should be pageable"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(GitHubOAuthResponses.listGitHubOAuth,
  "java"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Workflow.properties,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkflowProperties.artifactGenerationProperties,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GitHubOAuthResponse.properties,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkflowProperties.githubWorkflowProfile,
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

@@clientLocation(GitHubOAuthResponses.gitHubOAuthCallback,
  "DeveloperHubServiceClient",
  "go"
);
@@clientLocation(GitHubOAuthResponses.listGitHubOAuth,
  "DeveloperHubServiceClient",
  "go"
);
@@clientLocation(GitHubOAuthResponses.gitHubOAuth,
  "DeveloperHubServiceClient",
  "go"
);
@@clientLocation(generatePreviewArtifacts, "DeveloperHubServiceClient", "go");
@@clientLocation(AdooAuthResponses.getADOOAuthInfo,
  "DeveloperHubServiceClient",
  "go"
);
