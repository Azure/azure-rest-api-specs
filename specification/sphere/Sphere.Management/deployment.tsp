import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./deviceGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  @visibility("read")
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Deployment>;

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
      ...BaseParameters<Deployment>;
      ...CustomFilterQueryParameter;
      ...CustomTopQueryParameter;
      ...CustomSkipQueryParameter;
      ...CustomMaxPageSizeQueryParameter;
    }
  >;
}
