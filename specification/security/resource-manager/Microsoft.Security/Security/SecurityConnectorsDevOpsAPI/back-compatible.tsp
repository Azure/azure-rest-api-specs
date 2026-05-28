import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using SecurityConnectorsDevOpsAPI;

@@clientName(AzureDevOpsOrgs.createOrUpdate::parameters.resource,
  "azureDevOpsOrg"
);
@@clientName(AzureDevOpsOrgs.update::parameters.properties, "azureDevOpsOrg");

@@clientName(AzureDevOpsProjects.createOrUpdate::parameters.resource,
  "azureDevOpsProject"
);
@@clientName(AzureDevOpsProjects.update::parameters.properties,
  "azureDevOpsProject"
);

@@clientLocation(AzureDevOpsRepositories.get, "AzureDevOpsRepos");
@@clientLocation(AzureDevOpsRepositories.createOrUpdate, "AzureDevOpsRepos");
@@clientName(AzureDevOpsRepositories.createOrUpdate::parameters.resource,
  "azureDevOpsRepository"
);
@@clientLocation(AzureDevOpsRepositories.update, "AzureDevOpsRepos");
@@clientName(AzureDevOpsRepositories.update::parameters.properties,
  "azureDevOpsRepository"
);
@@clientLocation(AzureDevOpsRepositories.list, "AzureDevOpsRepos");

@@clientName(DevOpsConfigurations.createOrUpdate::parameters.resource,
  "devOpsConfiguration"
);
@@clientName(DevOpsConfigurations.update::parameters.properties,
  "devOpsConfiguration"
);
@@clientLocation(DevOpsConfigurations.listAvailable, AzureDevOpsOrgs);
@@clientLocation(DevOpsConfigurations.gitHubOwnersListAvailable, GitHubOwners);
@@clientName(DevOpsConfigurations.gitHubOwnersListAvailable, "ListAvailable");
@@clientLocation(DevOpsConfigurations.gitLabGroupsListAvailable, GitLabGroups);
@@clientName(DevOpsConfigurations.gitLabGroupsListAvailable, "ListAvailable");
@@clientLocation(DevOpsConfigurations.devOpsOperationResultsGet,
  "DevOpsOperationResults"
);
@@clientName(DevOpsConfigurations.devOpsOperationResultsGet, "Get");

@@clientLocation(GitHubRepositories.get, "GitHubRepos");
@@clientLocation(GitHubRepositories.list, "GitHubRepos");
@@clientLocation(GitHubRepositories.create, "GitHubIssues");
@@clientName(GitHubRepositories.create::parameters.body, "createIssueRequest");

@@clientLocation(GitLabGroups.gitLabSubgroupsList, "GitLabSubgroups");
@@clientName(GitLabGroups.gitLabSubgroupsList, "List");
