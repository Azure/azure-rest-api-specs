import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SessionHostManagement.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;

/**
 * Schema for SessionHostManagementUpdateStatus properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Composition over inheritance"
@parentResource(SessionHostManagement)
@singleton("default")
model SessionHostManagementUpdateStatus {
  /** Fully qualified ID for the async operation. */
  id?: Azure.Core.armResourceIdentifier;

  /** Name of the async operation. */
  name?: string;

  /** Percent of the operation that is complete. */
  @minValue(0)
  @maxValue(100)
  percentComplete?: float64;

  /** The start time of the operation. */
  startTime?: utcDateTime;

  /** The end time of the operation. */
  endTime?: utcDateTime;

  /** If present, details of the operation error. */
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  ...StatusProperty;
  ...UpdateStatusProperty;
}

@armResourceOperations
interface SessionHostManagementUpdateStatuses {
  /**
   * Get a SessionHostManagementUpdateStatus.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "casing issue"
  @OpenAPI.operationId("SessionHostManagementsUpdateStatus_Get")
  @get
  @action("sessionHostUpdateStatuses/default")
  get is ArmResourceRead<SessionHostManagementUpdateStatus>;
}
