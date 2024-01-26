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

namespace Microsoft.Elastic;
/**
 * Monitor resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(MonitorProperties)
model ElasticMonitorResource extends TrackedResourceBase {
  /**
   * Monitor resource name
   */
  @path
  @key("monitorName")
  @segment("monitors")
  @visibility("read")
  name: string;

  /**
   * Properties of the monitor resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MonitorProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ElasticMonitorResources {
  /**
   * Get the properties of a specific monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_Get")
  get is ArmResourceRead<ElasticMonitorResource>;

  /**
   * Create a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ElasticMonitorResource,
    BaseParameters<ElasticMonitorResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Monitors_Update")
  update is ArmCustomPatchSync<
    ElasticMonitorResource,
    ElasticMonitorResourceUpdateParameters
  >;

  /**
   * Delete a monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteAsync<ElasticMonitorResource>;

  /**
   * List all monitors under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ElasticMonitorResource>;

  /**
   * List all monitors under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Monitors_List")
  list is ArmListBySubscription<ElasticMonitorResource>;

  /**
   * List the resources currently being monitored by the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MonitoredResources_List")
  list is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    MonitoredResourceListResponse
  >;

  /**
   * Fetch information regarding Elastic cloud deployment corresponding to the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DeploymentInfo_List")
  list is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    DeploymentInfoResponse
  >;

  /**
   * List the vm resources currently being monitored by the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VMHost_List")
  list is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    VMHostListResponse
  >;

  /**
   * List the vm ingestion details that will be monitored by the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VMIngestion_Details")
  details is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    VMIngestionDetailsResponse
  >;

  /**
   * Update the vm details that will be monitored by the Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VMCollection_Update")
  update is ArmResourceActionSync<
    ElasticMonitorResource,
    VMCollectionUpdate,
    void
  >;
}

@@projectedName(ElasticMonitorResources.create::parameters.resource,
  "json",
  "body"
);
@@extension(ElasticMonitorResources.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(ElasticMonitorResources.create::parameters.resource,
  "Elastic monitor resource model"
);
@@projectedName(ElasticMonitorResources.update::parameters.properties,
  "json",
  "body"
);
@@extension(ElasticMonitorResources.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(ElasticMonitorResources.update::parameters.properties,
  "Elastic resource model update parameters."
);
@@doc(ElasticMonitorResources.update::parameters.body, "VM resource Id");
