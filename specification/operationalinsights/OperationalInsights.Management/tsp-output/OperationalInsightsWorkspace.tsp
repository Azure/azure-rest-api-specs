import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("The top level Workspace resource container.")
model OperationalInsightsWorkspace is TrackedResource<WorkspaceProperties> {
  @doc("The name of the workspace.")
  @maxLength(63)
  @minLength(4)
  @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface OperationalInsightsWorkspaces {
  @doc("Gets a workspace instance.")
  get is ArmResourceRead<OperationalInsightsWorkspace>;
  @doc("Create or update a workspace.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OperationalInsightsWorkspace>;
  @doc("Updates a workspace.")
  update is ArmResourcePatchSync<
    OperationalInsightsWorkspace,
    WorkspaceProperties
  >;
  @doc("Deletes a workspace resource. To recover the workspace, create it again with the same name, in the same subscription, resource group and location. The name is kept for 14 days and cannot be used for another workspace. To remove the workspace completely and release the name, use the force flag.")
  delete is ArmResourceDeleteAsync<
    OperationalInsightsWorkspace,
    {
      ...BaseParameters<OperationalInsightsWorkspace>;

      @doc("Deletes the workspace without the recovery option. A workspace that was deleted with this flag cannot be recovered.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("Gets workspaces in a resource group.")
  listByResourceGroup is ArmResourceListByParent<OperationalInsightsWorkspace>;
  @doc("Gets the workspaces in a subscription.")
  list is ArmListBySubscription<OperationalInsightsWorkspace>;
  @doc("Disables an intelligence pack for a given workspace.")
  disable is ArmResourceActionSync<
    OperationalInsightsWorkspace,
    {},
    {},
    {
      ...BaseParameters<OperationalInsightsWorkspace>;

      @doc("The name of the intelligence pack to be disabled.")
      @path
      intelligencePackName: string;
    }
  >;
  @doc("Enables an intelligence pack for a given workspace.")
  enable is ArmResourceActionSync<
    OperationalInsightsWorkspace,
    {},
    {},
    {
      ...BaseParameters<OperationalInsightsWorkspace>;

      @doc("The name of the intelligence pack to be enabled.")
      @path
      intelligencePackName: string;
    }
  >;
  @doc("Gets the shared keys for a workspace.")
  getSharedKeys is ArmResourceActionSync<
    OperationalInsightsWorkspace,
    {},
    SharedKeys
  >;
  @doc("Regenerates the shared keys for a Log Analytics Workspace. These keys are used to connect Microsoft Operational Insights agents to the workspace.")
  regenerate is ArmResourceActionSync<
    OperationalInsightsWorkspace,
    {},
    SharedKeys
  >;
  @doc("Gets the schema for a given workspace.")
  get is ArmResourceActionSync<
    OperationalInsightsWorkspace,
    {},
    SearchGetSchemaResponse
  >;
  @doc("""
Purges data in an Log Analytics workspace by a set of user-defined filters.

In order to manage system resources, purge requests are throttled at 50 requests per hour. You should batch the execution of purge requests by sending a single command whose predicate includes all user identities that require purging. Use the in operator to specify multiple identities. You should run the query prior to using for a purge request to verify that the results are expected.
Log Analytics only supports purge operations required for compliance with GDPR. The Log Analytics product team reserves the right to reject requests for purge operations that are not for the purpose of GDPR compliance. In the event of a dispute, please create a support ticket
""")
  purge is ArmResourceActionNoContentSync<
    OperationalInsightsWorkspace,
    WorkspacePurgeBody
  >;
  @doc("Lists all the intelligence packs possible and whether they are enabled or disabled for a given workspace.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(63)
      @minLength(4)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets a list of management groups connected to a workspace.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(63)
      @minLength(4)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    WorkspaceListManagementGroupsResult
  >;

  @doc("Gets a list of usage metrics for a workspace.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/usages")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(63)
      @minLength(4)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    WorkspaceListUsagesResult
  >;

  @doc("Gets the available service tiers for the workspace.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers")
  @get
  ListByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(63)
      @minLength(4)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;
    },
    void
  >;

  @doc("Gets status of an ongoing purge operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/operations/{purgeId}")
  @get
  GetPurgeStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the workspace.")
      @maxLength(63)
      @minLength(4)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("In a purge status request, this is the Id of the operation the status of which is returned.")
      @path
      purgeId: string;
    },
    WorkspacePurgeStatusResponse
  >;
}
