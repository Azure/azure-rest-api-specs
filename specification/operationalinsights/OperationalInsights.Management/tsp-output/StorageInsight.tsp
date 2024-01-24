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
/**
 * The top level storage insight resource container.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Workspace)
@Azure.ResourceManager.Private.armResourceInternal(StorageInsightProperties)
@includeInapplicableMetadataInPayload(false)
model StorageInsight extends ProxyResourceBase {
  /**
   * Name of the storageInsightsConfigs resource
   */
  @path
  @key("storageInsightName")
  @segment("storageInsightConfigs")
  name: string;

  /**
   * Storage insight properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: StorageInsightProperties;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface StorageInsights {
  /**
   * Gets a storage insight instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageInsightConfigs_Get")
  get is ArmResourceRead<StorageInsight>;

  /**
   * Create or update a storage insight.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageInsightConfigs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageInsight>;

  /**
   * Deletes a storageInsightsConfigs resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageInsightConfigs_Delete")
  delete is ArmResourceDeleteSync<StorageInsight>;

  /**
   * Lists the storage insight instances within a workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
