import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * The bandwidth schedule details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DataBoxEdgeDevice)
@Azure.ResourceManager.Private.armResourceInternal(BandwidthScheduleProperties)
@includeInapplicableMetadataInPayload(false)
model BandwidthSchedule extends ProxyResourceBase {
  /**
   * The bandwidth schedule name.
   */
  @path
  @key("name")
  @segment("bandwidthSchedules")
  name: string;

  /**
   * The properties of the bandwidth schedule.
   */
  @extension("x-ms-client-flatten", true)
  properties: BandwidthScheduleProperties;
}

@armResourceOperations
interface BandwidthSchedules {
  /**
   * Gets the properties of the specified bandwidth schedule.
   */
  get is ArmResourceRead<BandwidthSchedule>;

  /**
   * Creates or updates a bandwidth schedule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BandwidthSchedule>;

  /**
   * Deletes the specified bandwidth schedule.
   */
  delete is ArmResourceDeleteAsync<BandwidthSchedule>;

  /**
   * Gets all the bandwidth schedules for a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BandwidthSchedules_ListByDataBoxEdgeDevice")
  listByDataBoxEdgeDevice is ArmResourceListByParent<BandwidthSchedule>;
}

@@projectedName(BandwidthSchedules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(BandwidthSchedules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(BandwidthSchedules.createOrUpdate::parameters.resource,
  "The bandwidth schedule to be added or updated."
);
