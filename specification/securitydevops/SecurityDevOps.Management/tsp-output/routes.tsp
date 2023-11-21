import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.SecurityDevOps;

interface AzureDevOpsConnectorOperations {
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    AzureDevOpsConnectorListResponse
  >;

  @summary("Returns a monitored AzureDevOps Connector resource for a given ID.")
  @doc("Returns a monitored AzureDevOps Connector resource for a given ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;
    },
    AzureDevOpsConnector
  >;

  @summary("Creates or updates an Azure DevOps Connector.")
  @doc("Creates or updates an Azure DevOps Connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Connector resource payload.")
      @body
      azureDevOpsConnector: AzureDevOpsConnector;
    },
    AzureDevOpsConnector
  >;

  @summary("Update monitored AzureDevOps Connector details.")
  @doc("Update monitored AzureDevOps Connector details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Connector resource payload.")
      @body
      azureDevOpsConnector: AzureDevOpsConnector;
    },
    AzureDevOpsConnector
  >;

  @summary("Delete monitored AzureDevOps Connector details.")
  @doc("Delete monitored AzureDevOps Connector details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;
    },
    void
  >;

  @summary("Returns a list of monitored AzureDevOps Connectors.")
  @doc("Returns a list of monitored AzureDevOps Connectors.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    AzureDevOpsConnectorListResponse
  >;
}

interface AzureDevOpsRepoOperations {
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/repos")
  @get
  ListByConnector is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;
    },
    AzureDevOpsRepoListResponse
  >;

  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}/projects/{azureDevOpsProjectName}/repos")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;

      @doc("Name of the AzureDevOps Project.")
      @path
      azureDevOpsProjectName: string;
    },
    AzureDevOpsRepoListResponse
  >;

  @summary("Returns a monitored AzureDevOps Project resource for a given ID.")
  @doc("Returns a monitored AzureDevOps Project resource for a given ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}/projects/{azureDevOpsProjectName}/repos/{azureDevOpsRepoName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;

      @doc("Name of the AzureDevOps Project.")
      @path
      azureDevOpsProjectName: string;

      @doc("Name of the AzureDevOps Repo.")
      @path
      azureDevOpsRepoName: string;
    },
    AzureDevOpsRepo
  >;

  @summary("Updates an Azure DevOps Repo.")
  @doc("Updates an Azure DevOps Repo.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}/projects/{azureDevOpsProjectName}/repos/{azureDevOpsRepoName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;

      @doc("Name of the AzureDevOps Project.")
      @path
      azureDevOpsProjectName: string;

      @doc("Name of the AzureDevOps Repo.")
      @path
      azureDevOpsRepoName: string;

      @doc("Azure DevOps Repo resource payload.")
      @body
      azureDevOpsRepo: AzureDevOpsRepo;
    },
    AzureDevOpsRepo
  >;

  @summary("Update monitored AzureDevOps Project details.")
  @doc("Update monitored AzureDevOps Project details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}/projects/{azureDevOpsProjectName}/repos/{azureDevOpsRepoName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;

      @doc("Name of the AzureDevOps Project.")
      @path
      azureDevOpsProjectName: string;

      @doc("Name of the AzureDevOps Repo.")
      @path
      azureDevOpsRepoName: string;

      @doc("Azure DevOps Org resource payload.")
      @body
      azureDevOpsRepo: AzureDevOpsRepo;
    },
    AzureDevOpsRepo
  >;
}

interface AzureDevOpsConnectorStatsOperations {
  @summary("Returns the summary of the AzureDevOps Connector Stats.")
  @doc("Returns the summary of the AzureDevOps Connector Stats.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/stats")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;
    },
    AzureDevOpsConnectorStatsListResponse
  >;
}

interface AzureDevOpsOrgOperations {
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;
    },
    AzureDevOpsOrgListResponse
  >;

  @summary("Returns a monitored AzureDevOps Org resource for a given ID.")
  @doc("Returns a monitored AzureDevOps Org resource for a given ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;
    },
    AzureDevOpsOrg
  >;

  @summary("Creates or updates an Azure DevOps Org.")
  @doc("Creates or updates an Azure DevOps Org.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;

      @doc("Azure DevOps Org resource payload.")
      @body
      azureDevOpsOrg: AzureDevOpsOrg;
    },
    AzureDevOpsOrg
  >;

  @summary("Update monitored AzureDevOps Org details.")
  @doc("Update monitored AzureDevOps Org details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;

      @doc("Azure DevOps Org resource payload.")
      @body
      azureDevOpsOrg: AzureDevOpsOrg;
    },
    AzureDevOpsOrg
  >;
}

interface AzureDevOpsProjectOperations {
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}/projects")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;
    },
    AzureDevOpsProjectListResponse
  >;

  @summary("Returns a monitored AzureDevOps Project resource for a given ID.")
  @doc("Returns a monitored AzureDevOps Project resource for a given ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}/projects/{azureDevOpsProjectName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;

      @doc("Name of the AzureDevOps Project.")
      @path
      azureDevOpsProjectName: string;
    },
    AzureDevOpsProject
  >;

  @summary("Creates or updates an Azure DevOps Project.")
  @doc("Creates or updates an Azure DevOps Project.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}/projects/{azureDevOpsProjectName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;

      @doc("Name of the AzureDevOps Project.")
      @path
      azureDevOpsProjectName: string;

      @doc("Azure DevOps Org resource payload.")
      @body
      azureDevOpsProject: AzureDevOpsProject;
    },
    AzureDevOpsProject
  >;

  @summary("Update monitored AzureDevOps Project details.")
  @doc("Update monitored AzureDevOps Project details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/azureDevOpsConnectors/{azureDevOpsConnectorName}/orgs/{azureDevOpsOrgName}/projects/{azureDevOpsProjectName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the AzureDevOps Connector.")
      @path
      azureDevOpsConnectorName: string;

      @doc("Name of the AzureDevOps Org.")
      @path
      azureDevOpsOrgName: string;

      @doc("Name of the AzureDevOps Project.")
      @path
      azureDevOpsProjectName: string;

      @doc("Azure DevOps Org resource payload.")
      @body
      azureDevOpsProject: AzureDevOpsProject;
    },
    AzureDevOpsProject
  >;
}

interface GitHubConnectorOperations {
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    GitHubConnectorListResponse
  >;

  @summary("Returns a monitored GitHub Connector resource for a given ID.")
  @doc("Returns a monitored GitHub Connector resource for a given ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;
    },
    GitHubConnector
  >;

  @summary("Create or update a monitored GitHub Connector resource.")
  @doc("Create or update a monitored GitHub Connector resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;

      @doc("Connector resource payload.")
      @body
      gitHubConnector: GitHubConnector;
    },
    GitHubConnector
  >;

  @summary("Update monitored GitHub Connector details.")
  @doc("Update monitored GitHub Connector details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;

      @doc("Connector resource payload.")
      @body
      gitHubConnector: GitHubConnector;
    },
    GitHubConnector
  >;

  @summary("Delete monitored GitHub Connector details.")
  @doc("Delete monitored GitHub Connector details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;
    },
    void
  >;

  @summary("Returns a list of monitored GitHub Connectors.")
  @doc("Returns a list of monitored GitHub Connectors.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.SecurityDevOps/gitHubConnectors")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    GitHubConnectorListResponse
  >;
}

interface GitHubRepoOperations {
  @summary("Returns a list of monitored GitHub repositories.")
  @doc("Returns a list of monitored GitHub repositories.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/repos")
  @get
  ListByConnector is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;
    },
    GitHubRepoListResponse
  >;

  @summary("Returns a list of monitored GitHub repositories.")
  @doc("Returns a list of monitored GitHub repositories.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/owners/{gitHubOwnerName}/repos")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;

      @doc("Name of the GitHub Owner.")
      @path
      gitHubOwnerName: string;
    },
    GitHubRepoListResponse
  >;

  @summary("Returns a monitored GitHub repository.")
  @doc("Returns a monitored GitHub repository.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/owners/{gitHubOwnerName}/repos/{gitHubRepoName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;

      @doc("Name of the GitHub Owner.")
      @path
      gitHubOwnerName: string;

      @doc("Name of the GitHub Repo.")
      @path
      gitHubRepoName: string;
    },
    GitHubRepo
  >;

  @summary("Create or update a monitored GitHub repository.")
  @doc("Create or update a monitored GitHub repository.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/owners/{gitHubOwnerName}/repos/{gitHubRepoName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;

      @doc("Name of the GitHub Owner.")
      @path
      gitHubOwnerName: string;

      @doc("Name of the GitHub Repo.")
      @path
      gitHubRepoName: string;

      @doc("Github repo.")
      @body
      gitHubRepo: GitHubRepo;
    },
    GitHubRepo
  >;

  @summary("Patch a monitored GitHub repository.")
  @doc("Patch a monitored GitHub repository.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/owners/{gitHubOwnerName}/repos/{gitHubRepoName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;

      @doc("Name of the GitHub Owner.")
      @path
      gitHubOwnerName: string;

      @doc("Name of the GitHub Repo.")
      @path
      gitHubRepoName: string;

      @doc("Github repo.")
      @body
      gitHubRepo: GitHubRepo;
    },
    GitHubRepo
  >;
}

interface GitHubConnectorStatsOperations {
  @summary("Returns the summary of the GitHub Connector Stats.")
  @doc("Returns the summary of the GitHub Connector Stats.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/stats")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;
    },
    GitHubConnectorStatsListResponse
  >;
}

interface GitHubOwnerOperations {
  @summary("Returns a list of monitored GitHub owners.")
  @doc("Returns a list of monitored GitHub owners.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/owners")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;
    },
    GitHubOwnerListResponse
  >;

  @summary("Returns a monitored GitHub repository.")
  @doc("Returns a monitored GitHub repository.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/owners/{gitHubOwnerName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;

      @doc("Name of the GitHub Owner.")
      @path
      gitHubOwnerName: string;
    },
    GitHubOwner
  >;

  @summary("Create or update a monitored GitHub owner.")
  @doc("Create or update a monitored GitHub owner.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/owners/{gitHubOwnerName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;

      @doc("Name of the GitHub Owner.")
      @path
      gitHubOwnerName: string;

      @doc("Github owner.")
      @body
      gitHubOwner: GitHubOwner;
    },
    GitHubOwner
  >;

  @summary("Patch a monitored GitHub repository.")
  @doc("Patch a monitored GitHub repository.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityDevOps/gitHubConnectors/{gitHubConnectorName}/owners/{gitHubOwnerName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the GitHub Connector.")
      @path
      gitHubConnectorName: string;

      @doc("Name of the GitHub Owner.")
      @path
      gitHubOwnerName: string;

      @doc("Github owner.")
      @body
      gitHubOwner: GitHubOwner;
    },
    GitHubOwner
  >;
}

interface OperationsOperations {
  @doc("Returns list of operations supported by the Microsoft.SecurityDevOps provider.")
  @route("/providers/Microsoft.SecurityDevOps/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
