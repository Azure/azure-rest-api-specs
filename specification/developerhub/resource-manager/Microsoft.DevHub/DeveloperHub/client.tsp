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
@@clientName(ScaleProperty.numberOfStore, "NumberOfStores", "csharp");
@@clientName(GenerationLanguage.csharp, "CSharp", "csharp");
@@clientName(GenerationLanguage.javascript, "JavaScript", "csharp");
@@clientName(RepositoryProviderType.github, "GitHub", "csharp");
@@clientName(VersionedTemplate, "DevHubVersionedTemplate", "csharp");

@@clientName(ACR, "DevHubContainerRegistryInfo", "csharp");
@@clientName(Build, "DevHubDockerBuildInfo", "csharp");
@@clientName(Deployment, "DevHubDeploymentProperties", "csharp");
// Targets Azure.ResourceManager.CommonTypes.Origin (the ARM common-type actually
// emitted via Foundations.Operation.origin), not the unused local `union Origin` in
// models.tsp; a bare `Origin` would rename the dead local type and leave the generated one unchanged.
@@clientName(
  Azure.ResourceManager.CommonTypes.Origin,
  "DevHubOperationOrigin",
  "csharp"
);

// csharp: add DevHub prefix to otherwise-generic model/enum names
// Targets Azure.ResourceManager.CommonTypes.ActionType (the ARM common-type actually
// emitted via Foundations.Operation.actionType), not the unused local `union ActionType`
// in models.tsp; a bare `ActionType` would rename the dead local type only.
@@clientName(
  Azure.ResourceManager.CommonTypes.ActionType,
  "DevHubActionType",
  "csharp"
);
@@clientName(
  ArtifactGenerationProperties,
  "DevHubArtifactGenerationProperties",
  "csharp"
);
@@clientName(AuthorizationStatus, "DevHubAuthorizationStatus", "csharp");
@@clientName(
  DockerfileGenerationMode,
  "DevHubDockerfileGenerationMode",
  "csharp"
);
@@clientName(GenerationLanguage, "DevHubGenerationLanguage", "csharp");
@@clientName(GenerationManifestType, "DevHubGenerationManifestType", "csharp");
@@clientName(IacTemplateDetails, "DevHubIacTemplateDetails", "csharp");
@@clientName(IacTemplateProperties, "DevHubIacTemplateProperties", "csharp");
@@clientName(ManifestGenerationMode, "DevHubManifestGenerationMode", "csharp");
@@clientName(ManifestType, "DevHubManifestType", "csharp");
@@clientName(OidcCredentials, "DevHubOidcCredentials", "csharp");
// Targets Azure.ResourceManager.CommonTypes.OperationDisplay (the ARM common-type actually
// emitted via Foundations.Operation.display), not any local model; use the qualified name so
// the rename reaches the generated type.
@@clientName(
  Azure.ResourceManager.CommonTypes.OperationDisplay,
  "DevHubOperationDisplay",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.Foundations.OperationListResult,
  "DevHubOperationListResult",
  "csharp"
);
@@clientName(ParameterDefault, "DevHubTemplateParameterDefault", "csharp");
@@clientName(ParameterKind, "DevHubTemplateParameterKind", "csharp");
@@clientName(ParameterType, "DevHubTemplateParameterType", "csharp");
@@clientName(PullRequestStatus, "DevHubPullRequestStatus", "csharp");
@@clientName(QuickStartTemplateType, "DevHubQuickStartTemplateType", "csharp");
@@clientName(RepositoryProviderType, "DevHubRepositoryProviderType", "csharp");
@@clientName(ScaleProperty, "DevHubScaleProperty", "csharp");
@@clientName(StageProperties, "DevHubStageInfo", "csharp");
@@clientName(TemplateProperties, "DevHubTemplateProperties", "csharp");
@@clientName(TemplateReference, "DevHubTemplateReference", "csharp");
@@clientName(TemplateType, "DevHubTemplateType", "csharp");
@@clientName(
  TemplateWorkflowProfile,
  "DevHubTemplateWorkflowProfile",
  "csharp"
);
@@clientName(
  VersionedTemplateProperties,
  "DevHubVersionedTemplateProperties",
  "csharp"
);
@@clientName(WorkflowProperties, "DevHubWorkflowProperties", "csharp");
@@clientName(WorkflowRun, "DevHubWorkflowRun", "csharp");
@@clientName(WorkflowRunStatus, "DevHubWorkflowRunStatus", "csharp");
@@clientName(TagsObject, "DevHubResourceTagsPatch", "csharp");

@@clientName(AdooAuthCallRequest, "DeveloperHubAdoOAuthCallContent", "csharp");
@@clientName(
  ExportTemplateRequest,
  "DeveloperHubExportTemplateContent",
  "csharp"
);
@@clientName(
  GitHubOAuthCallRequest,
  "DeveloperHubGitHubOAuthCallContent",
  "csharp"
);
@@clientName(
  ScaleTemplateRequest,
  "DeveloperHubScaleTemplateContent",
  "csharp"
);
