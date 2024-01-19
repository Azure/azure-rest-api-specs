import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
@doc("The top level Workspace resource container.")
model Workspace is TrackedResource<WorkspaceProperties> {
  @doc("The name of the workspace.")
  @maxLength(63)
  @minLength(4)
  @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;

  @doc("The etag of the workspace.")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Workspaces {
  @doc("Gets a workspace instance.")
  get is ArmResourceRead<Workspace>;

  @doc("Create or update a workspace.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Workspace>;

  @doc("Updates a workspace.")
  update is ArmCustomPatchSync<Workspace, WorkspacePatch>;

  @doc("Deletes a workspace resource. To recover the workspace, create it again with the same name, in the same subscription, resource group and location. The name is kept for 14 days and cannot be used for another workspace. To remove the workspace completely and release the name, use the force flag.")
  delete is ArmResourceDeleteAsync<
    Workspace,
    {
      ...BaseParameters<Workspace>;

      @doc("Deletes the workspace without the recovery option. A workspace that was deleted with this flag cannot be recovered.")
      @query("force")
      force?: boolean;
    }
  >;

  @doc("Gets workspaces in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Workspace>;

  @doc("Gets the workspaces in a subscription.")
  list is ArmListBySubscription<Workspace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Disables an intelligence pack for a given workspace.")
  @operationId("IntelligencePacks_Disable")
  disable is ArmResourceActionSync<
    Workspace,
    void,
    void,
    {
      ...BaseParameters<Workspace>;

      @doc("The name of the intelligence pack to be disabled.")
      @path
      intelligencePackName: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Enables an intelligence pack for a given workspace.")
  @operationId("IntelligencePacks_Enable")
  enable is ArmResourceActionSync<
    Workspace,
    void,
    void,
    {
      ...BaseParameters<Workspace>;

      @doc("The name of the intelligence pack to be enabled.")
      @path
      intelligencePackName: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the shared keys for a workspace.")
  @operationId("SharedKeys_GetSharedKeys")
  getSharedKeys is ArmResourceActionSync<Workspace, void, SharedKeys>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerates the shared keys for a Log Analytics Workspace. These keys are used to connect Microsoft Operational Insights agents to the workspace.")
  @operationId("SharedKeys_Regenerate")
  regenerate is ArmResourceActionSync<Workspace, void, SharedKeys>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the schema for a given workspace.")
  @operationId("Schema_Get")
  get is ArmResourceActionSync<Workspace, void, SearchGetSchemaResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("""
Purges data in an Log Analytics workspace by a set of user-defined filters.

In order to manage system resources, purge requests are throttled at 50 requests per hour. You should batch the execution of purge requests by sending a single command whose predicate includes all user identities that require purging. Use the in operator to specify multiple identities. You should run the query prior to using for a purge request to verify that the results are expected.
Log Analytics only supports purge operations required for compliance with GDPR. The Log Analytics product team reserves the right to reject requests for purge operations that are not for the purpose of GDPR compliance. In the event of a dispute, please create a support ticket
""")
  @operationId("WorkspacePurge_Purge")
  purge is ArmResourceActionNoContentSync<Workspace, WorkspacePurgeBody>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntelligencePacks_List")
  @doc("Lists all the intelligence packs possible and whether they are enabled or disabled for a given workspace.")
  // FIXME: IntelligencePacks_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagementGroups_List")
  @doc("Gets a list of management groups connected to a workspace.")
  // FIXME: ManagementGroups_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Usages_List")
  @doc("Gets a list of usage metrics for a workspace.")
  // FIXME: Usages_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/usages")
  @get
  list is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AvailableServiceTiers_ListByWorkspace")
  @doc("Gets the available service tiers for the workspace.")
  // FIXME: AvailableServiceTiers_ListByWorkspace could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers")
  @get
  listByWorkspace is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkspacePurge_GetPurgeStatus")
  @doc("Gets status of an ongoing purge operation.")
  // FIXME: WorkspacePurge_GetPurgeStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/operations/{purgeId}")
  @get
  getPurgeStatus is Azure.Core.Foundations.Operation<
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

@@projectedName(Workspaces.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Workspaces.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Workspaces.createOrUpdate::parameters.resource,
  "The parameters required to create or update a workspace."
);
@@projectedName(Workspaces.update::parameters.properties, "json", "parameters");
@@extension(Workspaces.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Workspaces.update::parameters.properties,
  "The parameters required to patch a workspace."
);
@@doc(Workspaces.purge::parameters.body,
  "Describes the body of a request to purge data in a single table of an Log Analytics Workspace"
);
