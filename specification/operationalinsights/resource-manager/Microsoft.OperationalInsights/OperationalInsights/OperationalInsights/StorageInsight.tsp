import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * The top level storage insight resource container.
 */
@parentResource(Workspace)
model StorageInsight
  is Azure.ResourceManager.ProxyResource<StorageInsightProperties> {
  ...ResourceNameParameter<
    Resource = StorageInsight,
    KeyName = "storageInsightName",
    SegmentName = "storageInsightConfigs",
    NamePattern = ""
  >;

  /**
   * The ETag of the storage insight.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  eTag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface StorageInsights {
  /**
   * Gets a storage insight instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageInsightConfigs_Get")
  get is ArmResourceRead<StorageInsight>;

  /**
   * Create or update a storage insight.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageInsightConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageInsight>;

  /**
   * Deletes a storageInsightsConfigs resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageInsightConfigs_Delete")
  delete is ArmResourceDeleteSync<StorageInsight>;

  /**
   * Lists the storage insight instances within a workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageInsightConfigs_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<
    StorageInsight,
    Response = ArmResponse<StorageInsightListResult>
  >;
}

@@doc(StorageInsight.name, "Name of the storageInsightsConfigs resource");
@@doc(StorageInsight.properties, "Storage insight properties.");
@@doc(StorageInsights.createOrUpdate::parameters.resource,
  "The parameters required to create or update a storage insight."
);
