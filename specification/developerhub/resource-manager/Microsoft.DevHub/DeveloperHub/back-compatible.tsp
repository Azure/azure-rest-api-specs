import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DevHub;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IacProfileProperties.githubProfile);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IacProfileProperties.terraformProfile);

@@clientName(IacProfiles.createOrUpdate::parameters.resource, "parameters");
@@clientName(IacProfiles.updateTags::parameters.properties, "parameters");
@@clientName(IacProfiles.export::parameters.body, "parameters");
@@clientName(IacProfiles.scale::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IacProfile.properties);

@@clientLocation(GitHubOAuthResponses.gitHubOAuthCallback, "");
@@clientLocation(GitHubOAuthResponses.listGitHubOAuth, "");
@@clientLocation(GitHubOAuthResponses.gitHubOAuth, "");
@@clientName(GitHubOAuthResponses.gitHubOAuth::parameters.body, "parameters");

@@clientLocation(Workflows.get, "Workflow");
@@clientLocation(Workflows.createOrUpdate, "Workflow");
@@clientName(Workflows.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Workflows.updateTags, "Workflow");
@@clientName(Workflows.updateTags::parameters.properties, "parameters");
@@clientLocation(Workflows.delete, "Workflow");
@@clientLocation(Workflows.listByResourceGroup, "Workflow");
@@clientLocation(Workflows.list, "Workflow");

@@clientLocation(AdooAuthResponses.get, "ADOOAuth");
@@clientLocation(AdooAuthResponses.list, "ADOOAuth");
@@clientLocation(AdooAuthResponses.getADOOAuthInfo, "");
@@clientName(AdooAuthResponses.getADOOAuthInfo::parameters.body, "parameters");

@@clientLocation(Templates.get, "Template");
@@clientLocation(Templates.list, "Template");

@@clientLocation(VersionedTemplates.get, "VersionedTemplate");
@@clientLocation(VersionedTemplates.list, "VersionedTemplate");
@@clientLocation(VersionedTemplates.generate, "VersionedTemplate");
@@clientName(VersionedTemplates.generate::parameters.body, "parameters");
