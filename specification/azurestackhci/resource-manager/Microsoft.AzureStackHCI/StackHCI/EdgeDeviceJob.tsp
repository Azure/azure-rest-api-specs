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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
@parentResource(EdgeDevice)
model EdgeDeviceJob
  is Azure.ResourceManager.Legacy.DiscriminatedExtensionResource<EdgeDeviceKind> {
  ...ResourceNameParameter<
    Resource = EdgeDeviceJob,
    KeyName = "jobsName",
    SegmentName = "jobs"
  >;
}

@armResourceOperations
interface EdgeDeviceJobs {
  /**
   * Get a EdgeDeviceJob
   */
  get is Azure.ResourceManager.Extension.Read<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDeviceJob
  >;

  /**
   * Create a EdgeDeviceJob
   */
  createOrUpdate is Azure.ResourceManager.Extension.CreateOrReplaceAsync<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDeviceJob
  >;

  /**
   * Delete a EdgeDeviceJob
   */
  delete is Azure.ResourceManager.Extension.DeleteWithoutOkAsync<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDeviceJob
  >;

  /**
   * List EdgeDeviceJob resources by EdgeDevice
   */
  listByEdgeDevice is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    EdgeDeviceJob
  >;
}

@@doc(EdgeDeviceJob.name, "Name of EdgeDevice Job");
