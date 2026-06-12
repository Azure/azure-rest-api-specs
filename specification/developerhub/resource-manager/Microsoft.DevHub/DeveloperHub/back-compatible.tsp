import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DevHub;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IacProfileProperties.githubProfile);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IacProfileProperties.terraformProfile);

@@clientName(IacProfiles.createOrUpdate::parameters.resource, "parameters");
@@clientName(IacProfiles.updateTags::parameters.properties, "parameters");
@@clientName(IacProfiles.export::parameters.body, "parameters");
@@clientName(IacProfiles.scale::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IacProfile.properties);

@@clientLocation(GitHubOAuthResponses.gitHubOAuthCallback, Microsoft.DevHub);
@@clientLocation(GitHubOAuthResponses.listGitHubOAuth, Microsoft.DevHub);
@@clientLocation(GitHubOAuthResponses.gitHubOAuth, Microsoft.DevHub);
@@clientName(GitHubOAuthResponses.gitHubOAuth::parameters.body, "parameters");

@@clientLocation(Workflows.get, "Workflow", "!javascript");
@@clientLocation(Workflows.createOrUpdate, "Workflow", "!javascript");
@@clientName(Workflows.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Workflows.updateTags, "Workflow", "!javascript");
@@clientName(Workflows.updateTags::parameters.properties, "parameters");
@@clientLocation(Workflows.delete, "Workflow", "!javascript");
@@clientLocation(Workflows.listByResourceGroup, "Workflow", "!javascript");
@@clientLocation(Workflows.list, "Workflow", "!javascript");

@@clientLocation(Workflows.get, "WorkflowOperations", "javascript");
@@clientLocation(Workflows.createOrUpdate, "WorkflowOperations", "javascript");
@@clientLocation(Workflows.updateTags, "WorkflowOperations", "javascript");
@@clientLocation(Workflows.delete, "WorkflowOperations", "javascript");
@@clientLocation(
  Workflows.listByResourceGroup,
  "WorkflowOperations",
  "javascript"
);
@@clientLocation(Workflows.list, "WorkflowOperations", "javascript");

@@clientLocation(AdooAuthResponses.get, "ADOOAuth", "!java");
@@clientLocation(AdooAuthResponses.list, "ADOOAuth", "!java");
@@clientLocation(AdooAuthResponses.getADOOAuthInfo, Microsoft.DevHub);
@@clientName(AdooAuthResponses.getADOOAuthInfo::parameters.body, "parameters");

@@clientLocation(Templates.get, "Template");
@@clientLocation(Templates.list, "Template");

@@clientLocation(VersionedTemplates.get, "VersionedTemplate");
@@clientLocation(VersionedTemplates.list, "VersionedTemplate");
@@clientLocation(VersionedTemplates.generate, "VersionedTemplate");
@@clientName(VersionedTemplates.generate::parameters.body, "parameters");
@@clientName(AdooAuthCallRequest, "ADOOAuthCallRequest");
@@clientName(AdooAuthInfoResponse, "ADOOAuthInfoResponse");
@@clientName(AdooAuthListResponse, "ADOOAuthListResponse");
@@clientName(AdooAuthResponse, "ADOOAuthResponse");
@@clientName(PrLinkResponse, "prLinkResponse");

@@clientName(
  AdooAuthCallRequest,
  "DeveloperHubADOOAuthCallRequestContent",
  "csharp"
);
@@clientName(
  AdooAuthInfoResponse,
  "DeveloperHubADOOAuthInfoResponseResult",
  "csharp"
);
@@clientName(
  DeleteWorkflowResponse,
  "DeveloperHubDeleteWorkflowResponseResult",
  "csharp"
);
@@clientName(
  ExportTemplateRequest,
  "DeveloperHubExportTemplateRequestContent",
  "csharp"
);
@@clientName(
  GenerateVersionedTemplateResponse,
  "DeveloperHubGenerateVersionedTemplateResponseResult",
  "csharp"
);
@@clientName(
  GitHubOAuthCallRequest,
  "DeveloperHubGitHubOAuthCallRequestContent",
  "csharp"
);
@@clientName(
  GitHubOAuthInfoResponse,
  "DeveloperHubGitHubOAuthInfoResponseResult",
  "csharp"
);
@@clientName(
  GitHubOAuthListResponse,
  "DeveloperHubGitHubOAuthListResponseResult",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.Foundations.Operation,
  "DeveloperHubOperationInfo",
  "csharp"
);
@@clientName(Parameter, "DeveloperHubParameterContent", "csharp");
@@clientName(PrLinkResponse, "DeveloperHubPrLinkResponseResult", "csharp");
@@clientName(PullRequest, "DeveloperHubPullRequestContent", "csharp");
@@clientName(
  ScaleTemplateRequest,
  "DeveloperHubScaleTemplateRequestContent",
  "csharp"
);

@@visibility(
  Azure.ResourceManager.Foundations.OperationListResult.nextLink,
  Lifecycle.Read
);
@@visibility(
  Azure.ResourceManager.Foundations.OperationListResult.value,
  Lifecycle.Read
);
