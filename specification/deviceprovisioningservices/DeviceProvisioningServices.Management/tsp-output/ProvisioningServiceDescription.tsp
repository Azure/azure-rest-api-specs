import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Devices;
@doc("The description of the provisioning service.")
model ProvisioningServiceDescription
  is TrackedResource<IotDpsPropertiesDescription> {
  @doc("Name of the provisioning service to retrieve.")
  @path
  @key("provisioningServiceName")
  @segment("provisioningServices")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ProvisioningServiceDescriptions {
  @doc("Get the metadata of the provisioning service without SAS keys.")
  get is ArmResourceRead<ProvisioningServiceDescription>;
  @doc("Create or update the metadata of the provisioning service. The usual pattern to modify a property is to retrieve the provisioning service metadata and security metadata, and then combine them with the modified values in a new body to update the provisioning service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProvisioningServiceDescription>;
  @doc("Update an existing provisioning service's tags. to update other fields use the CreateOrUpdate method")
  update is ArmTagsPatchAsync<ProvisioningServiceDescription>;
  @doc("Deletes the Provisioning Service.")
  delete is ArmResourceDeleteAsync<ProvisioningServiceDescription>;
  @doc("Get a list of all provisioning services in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<ProvisioningServiceDescription>;
  @doc("List all the provisioning services for a given subscription id.")
  listBySubscription is ArmListBySubscription<ProvisioningServiceDescription>;
  @doc("List the primary and secondary keys for a provisioning service.")
  listKeys is ArmResourceActionSync<
    ProvisioningServiceDescription,
    {},
    SharedAccessSignatureAuthorizationRuleListResult
  >;
  @doc("List primary and secondary keys for a specific key name")
  listKeysForKeyName is ArmResourceActionSync<
    ProvisioningServiceDescription,
    {},
    SharedAccessSignatureAuthorizationRuleAccessRightsDescription,
    {
      ...BaseParameters<ProvisioningServiceDescription>;

      @doc("Logical key name to get key-values for.")
      @path
      keyName: string;
    }
  >;
  @doc("Gets the status of a long running operation, such as create, update or delete a provisioning service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/operationresults/{operationId}")
  @get
  GetOperationResult is Azure.Core.Foundations.Operation<
    {
      @doc("Operation id corresponding to long running operation. Use this to poll for the status.")
      @path
      operationId: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group identifier.")
      @path
      resourceGroupName: string;

      @doc("Name of provisioning service that the operation is running on.")
      @path
      provisioningServiceName: string;

      @doc("Async header used to poll on the status of the operation, obtained while creating the long running operation.")
      @query("asyncinfo")
      asyncinfo: string;
    },
    AsyncOperationResult
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
