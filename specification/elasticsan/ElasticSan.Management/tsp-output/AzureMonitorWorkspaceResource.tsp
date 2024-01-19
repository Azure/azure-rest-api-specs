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
@doc("An Azure Monitor Workspace definition")
model AzureMonitorWorkspaceResource
  is TrackedResource<AzureMonitorWorkspaceResourceProperties> {
  @doc("The name of the Azure Monitor workspace.  The name is case insensitive")
  @pattern("^(?!-)[a-zA-Z0-9-]+[^-]$")
  @path
  @key("azureMonitorWorkspaceName")
  @segment("accounts")
  name: string;

  @doc("Resource entity tag (ETag)")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface AzureMonitorWorkspaceResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the specific Azure Monitor workspace")
  @operationId("AzureMonitorWorkspaces_Get")
  get is ArmResourceRead<AzureMonitorWorkspaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a workspace")
  @operationId("AzureMonitorWorkspaces_Create")
  create is ArmResourceCreateOrReplaceSync<AzureMonitorWorkspaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates part of a workspace")
  @operationId("AzureMonitorWorkspaces_Update")
  update is ArmCustomPatchSync<
    AzureMonitorWorkspaceResource,
    AzureMonitorWorkspaceResourceForUpdate
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a workspace")
  @operationId("AzureMonitorWorkspaces_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AzureMonitorWorkspaceResource,
    BaseParameters<AzureMonitorWorkspaceResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all workspaces in the specified resource group")
  @operationId("AzureMonitorWorkspaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AzureMonitorWorkspaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all workspaces in the specified subscription")
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
