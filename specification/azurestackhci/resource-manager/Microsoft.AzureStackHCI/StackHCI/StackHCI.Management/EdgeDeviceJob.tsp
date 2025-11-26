import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
// FIXME: EdgeDeviceJob has no properties property
/**
 * EdgeDevice Jobs resource
 */
@parentResource(EdgeDevice)
model EdgeDeviceJob is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = EdgeDeviceJob,
    KeyName = "jobsName",
    SegmentName = "jobs"
  >;

  /**
   * Edge Solution type to support polymorphic resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: EdgeDeviceKind = EdgeDeviceKind.HCI;
}

@armResourceOperations
interface EdgeDeviceJobs {
  /**
   * Get a EdgeDeviceJob
   */
  get is ArmResourceRead<EdgeDeviceJob>;
  /**
   * Create a EdgeDeviceJob
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeDeviceJob>;

  /**
   * Delete a EdgeDeviceJob
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeDeviceJob>;

  /**
   * List EdgeDeviceJob resources by EdgeDevice
   */
  listByEdgeDevice is ArmResourceListByParent<EdgeDeviceJob>;
}

@@doc(EdgeDeviceJob.name, "Name of EdgeDevice Job");
