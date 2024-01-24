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

namespace Microsoft.Insights;
/**
 * An Azure Monitor Workspace definition
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  AzureMonitorWorkspaceResourceProperties
)
@includeInapplicableMetadataInPayload(false)
model AzureMonitorWorkspaceResource extends TrackedResourceBase {
  /**
   * The name of the Azure Monitor workspace.  The name is case insensitive
   */
  @pattern("^(?!-)[a-zA-Z0-9-]+[^-]$")
  @path
  @key("azureMonitorWorkspaceName")
  @segment("accounts")
  name: string;

  /**
   * Resource entity tag (ETag)
   */
  @visibility("read")
  etag?: string;

  /**
   * Resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureMonitorWorkspaceResourceProperties;
}

@armResourceOperations
interface AzureMonitorWorkspaceResources {
  /**
   * Returns the specific Azure Monitor workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureMonitorWorkspaces_Get")
  get is ArmResourceRead<AzureMonitorWorkspaceResource>;

  /**
   * Create or update a workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureMonitorWorkspaces_Create")
  create is ArmResourceCreateOrReplaceSync<AzureMonitorWorkspaceResource>;

  /**
   * Updates part of a workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("AzureMonitorWorkspaces_Update")
  update is ArmCustomPatchSync<
    AzureMonitorWorkspaceResource,
    AzureMonitorWorkspaceResourceForUpdate
  >;

  /**
   * Delete a workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureMonitorWorkspaces_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AzureMonitorWorkspaceResource,
    BaseParameters<AzureMonitorWorkspaceResource>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all workspaces in the specified resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureMonitorWorkspaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AzureMonitorWorkspaceResource>;

  /**
   * Lists all workspaces in the specified subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureMonitorWorkspaces_ListBySubscription")
  listBySubscription is ArmListBySubscription<AzureMonitorWorkspaceResource>;
}

@@projectedName(AzureMonitorWorkspaceResources.create::parameters.resource,
  "json",
  "azureMonitorWorkspaceProperties"
);
@@extension(AzureMonitorWorkspaceResources.create::parameters.resource,
  "x-ms-client-name",
  "azureMonitorWorkspaceProperties"
);
@@doc(AzureMonitorWorkspaceResources.create::parameters.resource,
  "Properties that need to be specified to create a new workspace"
);
@@projectedName(AzureMonitorWorkspaceResources.update::parameters.properties,
  "json",
  "azureMonitorWorkspaceProperties"
);
@@extension(AzureMonitorWorkspaceResources.update::parameters.properties,
  "x-ms-client-name",
  "azureMonitorWorkspaceProperties"
);
@@doc(AzureMonitorWorkspaceResources.update::parameters.properties,
  "The payload"
);
