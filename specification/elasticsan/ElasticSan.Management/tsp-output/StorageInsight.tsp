import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
@doc("The top level storage insight resource container.")
@parentResource(Workspace)
model StorageInsight is ProxyResource<StorageInsightProperties> {
  @doc("Name of the storageInsightsConfigs resource")
  @path
  @key("storageInsightName")
  @segment("storageInsightConfigs")
  name: string;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface StorageInsights {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a storage insight instance.")
  @operationId("StorageInsightConfigs_Get")
  get is ArmResourceRead<StorageInsight>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a storage insight.")
  @operationId("StorageInsightConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageInsight>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a storageInsightsConfigs resource")
  @operationId("StorageInsightConfigs_Delete")
  delete is ArmResourceDeleteSync<StorageInsight>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the storage insight instances within a workspace")
  @operationId("StorageInsightConfigs_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<StorageInsight>;
}

@@projectedName(StorageInsights.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(StorageInsights.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(StorageInsights.createOrUpdate::parameters.resource,
  "The parameters required to create or update a storage insight."
);
