import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * The bandwidth schedule details.
 */
@parentResource(DataBoxEdgeDevice)
model BandwidthSchedule
  is Azure.ResourceManager.ProxyResource<BandwidthScheduleProperties, false> {
  ...ResourceNameParameter<
    Resource = BandwidthSchedule,
    KeyName = "name",
    SegmentName = "bandwidthSchedules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BandwidthSchedules {
  /**
   * Gets the properties of the specified bandwidth schedule.
   */
  get is ArmResourceRead<BandwidthSchedule, Error = CloudError>;

  /**
   * Creates or updates a bandwidth schedule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BandwidthSchedule,
    Response = ArmResourceUpdatedResponse<BandwidthSchedule> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BandwidthSchedule> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Deletes the specified bandwidth schedule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    BandwidthSchedule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the bandwidth schedules for a Data Box Edge/Data Box Gateway device.
   */
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    BandwidthSchedule,
    Response = ArmResponse<BandwidthSchedulesList>,
    Error = CloudError
  >;
}

@@doc(BandwidthSchedule.name, "The bandwidth schedule name.");
@@doc(BandwidthSchedule.properties,
  "The properties of the bandwidth schedule."
);
@@doc(BandwidthSchedules.createOrUpdate::parameters.resource,
  "The bandwidth schedule to be added or updated."
);
