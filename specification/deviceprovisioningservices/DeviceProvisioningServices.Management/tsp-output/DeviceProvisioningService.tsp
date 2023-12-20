import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DeviceProvisioningServices;
@doc("The description of the provisioning service.")
model DeviceProvisioningService
  is TrackedResource<IotDpsPropertiesDescription> {
  @doc("Name of the provisioning service to retrieve.")
  @path
  @key("provisioningServiceName")
  @segment("provisioningServices")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface DeviceProvisioningServices {
  @doc("Get the metadata of the provisioning service without SAS keys.")
  get is ArmResourceRead<DeviceProvisioningService>;
  @doc("Create or update the metadata of the provisioning service. The usual pattern to modify a property is to retrieve the provisioning service metadata and security metadata, and then combine them with the modified values in a new body to update the provisioning service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DeviceProvisioningService>;
  @doc("Update an existing provisioning service's tags. to update other fields use the CreateOrUpdate method")
  update is ArmTagsPatchAsync<DeviceProvisioningService>;
  @doc("Deletes the Provisioning Service.")
  delete is ArmResourceDeleteAsync<DeviceProvisioningService>;
  @doc("Get a list of all provisioning services in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<DeviceProvisioningService>;
  @doc("List all the provisioning services for a given subscription id.")
  listBySubscription is ArmListBySubscription<DeviceProvisioningService>;
  @doc("List the primary and secondary keys for a provisioning service.")
  listKeys is ArmResourceActionSync<
    DeviceProvisioningService,
    void,
    SharedAccessSignatureAuthorizationRuleListResult
  >;
  @doc("List primary and secondary keys for a specific key name")
  listKeysForKeyName is ArmResourceActionSync<
    DeviceProvisioningService,
    void,
    SharedAccessSignatureAuthorizationRuleAccessRightsDescription,
    {
      ...BaseParameters<DeviceProvisioningService>;

      @doc("Logical key name to get key-values for.")
      @path
      keyName: string;
    }
  >;
  @summary("Get the list of valid SKUs for a provisioning service.")
  @doc("Gets the list of valid SKUs and tiers for a provisioning service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/skus")
  @get
  listValidSkus is Azure.Core.Foundations.Operation<
    {
      @doc("Name of provisioning service.")
      @path
      provisioningServiceName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Name of resource group.")
      @path
      resourceGroupName: string;
    },
    IotDpsSkuDefinitionListResult
  >;
}
