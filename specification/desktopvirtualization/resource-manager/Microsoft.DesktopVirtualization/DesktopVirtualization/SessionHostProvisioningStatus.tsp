import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SessionHostManagement.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.DesktopVirtualization;

/**
 * Schema for SessionHostManagementUpdateStatus properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Composition over inheritance"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@parentResource(SessionHostManagement)
@Azure.ResourceManager.Legacy.customAzureResource
@singleton("default")
@added(Versions.v2025_04_01_preview)
model SessionHostManagementProvisioningStatus {
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

  ...ProvisioningOperationStatusProperty;
  ...ProvisioningStatusProperty;
}

@armResourceOperations
@added(Versions.v2025_04_01_preview)
@tag("SessionHostManagement")
interface SessionHostManagementProvisioningStatuses {
  /**
   * Get the session host provisioning status for a given hostpool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "casing issue"
  @OpenAPI.operationId("SessionHostProvisioningStatuses_Get")
  @get
  @action("sessionHostProvisioningStatuses/default")
  get is ArmResourceActionSync<
    SessionHostManagement,
    Request = void,
    Response = SessionHostManagementProvisioningStatus
  >;
}
