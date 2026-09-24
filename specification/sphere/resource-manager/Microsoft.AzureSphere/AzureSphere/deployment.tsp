using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.AzureSphere;
/**
 * An deployment resource belonging to a device group resource.
 */
@parentResource(DeviceGroup)
model Deployment is ProxyResource<DeploymentProperties> {
  /**
   * Deployment name. Use .default for deployment creation and to get the current deployment for the associated device group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @path
  @key("deploymentName")
  @segment("deployments")
  @visibility(Lifecycle.Read)
  name: string;
}

@armResourceOperations
interface Deployments {
  /**
   * Get a Deployment. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  get is ArmResourceRead<Deployment>;

  /**
   * Create a Deployment. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Deployment,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a Deployment. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  #suppress "deprecated" "For backward compatible"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatible"
  delete is ArmResourceDeleteAsync<Deployment>;

  /**
   * List Deployment resources by DeviceGroup. '.default' and '.unassigned' are system defined values and cannot be used for product or device group name.
   */
  listByDeviceGroup is ArmResourceListByParent<
    Deployment,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<Deployment>;
      ...CustomFilterQueryParameter;
      ...CustomTopQueryParameter;
      ...CustomSkipQueryParameter;
      ...CustomMaxPageSizeQueryParameter;
    }
  >;
}
