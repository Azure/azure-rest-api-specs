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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface StorageInsights {
  /**
   * Gets a storage insight instance.
   */
  get is ArmResourceRead<StorageInsight>;

  /**
   * Create or update a storage insight.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageInsight>;

  /**
   * Deletes a storageInsightsConfigs resource
   */
  delete is ArmResourceDeleteSync<StorageInsight>;

  /**
   * Lists the storage insight instances within a workspace
   */
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
