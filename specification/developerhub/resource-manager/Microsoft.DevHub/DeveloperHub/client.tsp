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
@@clientName(Microsoft.DevHub, "DevHubMgmtClient", "python");
@@clientName(ACR, "Acr", "java,javascript");
@@clientName(Deployment, "DeploymentProperties", "java,javascript,python");
// consistency on "AdoOAuth"
@@clientName(AdooAuthResponse, "AdoOAuthResponse", "java");
@@clientName(AdooAuthResponses, "AdoOAuthResponses", "java");
@@clientName(AdooAuthCallRequest, "AdoOAuthCallRequest", "java");
@@clientName(AdooAuthInfoResponse, "AdoOAuthInfoResponse", "java");
@@clientName(AdooAuthListResponse, "AdoOAuthListResponse", "java");
@@clientName(ADOOAuth, "AdoOAuth", "java");
@@clientName(AdooAuthResponses.getADOOAuthInfo, "getAdoOAuthInfo", "java");

// csharp acronym-casing consistency (mirrors java,javascript)
@@clientName(ACR, "Acr", "csharp");

// csharp: ADO acronym PascalCase (3-letter acronym)
@@clientName(ADORepository, "AdoRepository", "csharp");
@@clientName(ADOProviderProfile, "AdoProviderProfile", "csharp");

// csharp: add RP/domain context to otherwise-generic resource trio nouns
@@clientName(Workflow, "DevHubWorkflow", "csharp");
@@clientName(Template, "DevHubTemplate", "csharp");

// csharp: enum member casing fixes
@@clientName(WorkflowRunStatus.inprogress, "InProgress", "csharp");
@@clientName(GenerationLanguage.gomodule, "GoModule", "csharp");
@@clientName(QuickStartTemplateType.HCIAKS, "HciAks", "csharp");
@@clientName(QuickStartTemplateType.HCIARCVM, "HciArcVm", "csharp");

// csharp: URL -> Url acronym casing (mirrors java)
@@clientName(GitHubOAuthInfoResponse.authURL, "authUrl", "csharp");
@@clientName(AdooAuthInfoResponse.authURL, "authUrl", "csharp");
@@clientName(GitHubWorkflowProfile.prURL, "prUrl", "csharp");
@@clientName(WorkflowRun.workflowRunURL, "workflowRunUrl", "csharp");
@@clientName(PullRequest.prURL, "prUrl", "csharp");

// csharp: boolean properties need a verb prefix
@@clientName(WorkflowRun.succeeded, "isSucceeded", "csharp");
@@clientName(Parameter.required, "isRequired", "csharp");

// csharp: ARM resource id strings -> ResourceIdentifier
@@alternateType(
  GitHubWorkflowProfile.aksResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  IacTemplateProperties.sourceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// csharp: etag string -> Azure.ETag
@@alternateType(
  Azure.ResourceManager.Legacy.EntityTagProperty.etag,
  Azure.Core.eTag,
  "csharp"
);

// csharp AdoOAuth casing consistency (mirrors java).
@@clientName(AdooAuthResponse, "AdoOAuthResponse", "csharp");
@@clientName(AdooAuthResponses, "AdoOAuthResponses", "csharp");
@@clientName(AdooAuthListResponse, "AdoOAuthListResponse", "csharp");
@@clientName(ADOOAuth, "AdoOAuth", "csharp");
@@clientName(AdooAuthResponses.getADOOAuthInfo, "getAdoOAuthInfo", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "list should be pageable"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  GitHubOAuthResponses.listGitHubOAuth,
  "java"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Workflow.properties,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  WorkflowProperties.artifactGenerationProperties,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  GitHubOAuthResponse.properties,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  WorkflowProperties.githubWorkflowProfile,
  "java"
);

@@clientLocation(
  GitHubOAuthResponses.gitHubOAuthCallback,
  Microsoft.DevHub,
  "javascript"
);
@@clientLocation(
  GitHubOAuthResponses.listGitHubOAuth,
  Microsoft.DevHub,
  "javascript"
);
@@clientLocation(
  GitHubOAuthResponses.gitHubOAuth,
  Microsoft.DevHub,
  "javascript"
);

@@clientLocation(
  GitHubOAuthResponses.gitHubOAuthCallback,
  "DeveloperHubServiceClient",
  "go"
);
@@clientLocation(
  GitHubOAuthResponses.listGitHubOAuth,
  "DeveloperHubServiceClient",
  "go"
);
@@clientLocation(
  GitHubOAuthResponses.gitHubOAuth,
  "DeveloperHubServiceClient",
  "go"
);
@@clientLocation(generatePreviewArtifacts, "DeveloperHubServiceClient", "go");
@@clientLocation(
  AdooAuthResponses.getADOOAuthInfo,
  "DeveloperHubServiceClient",
  "go"
);
