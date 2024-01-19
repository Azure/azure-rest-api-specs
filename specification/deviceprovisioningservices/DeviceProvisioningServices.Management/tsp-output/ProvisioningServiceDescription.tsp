import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
@doc("The description of the provisioning service.")
model ProvisioningServiceDescription
  is TrackedResource<IotDpsPropertiesDescription> {
  @doc("Name of the provisioning service to retrieve.")
  @path
  @key("provisioningServiceName")
  @segment("provisioningServices")
  name: string;

  @doc("The Etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal ETag convention.")
  etag?: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ProvisioningServiceDescriptions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the metadata of the provisioning service without SAS keys.")
  @operationId("IotDpsResource_Get")
  get is ArmResourceRead<ProvisioningServiceDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the metadata of the provisioning service. The usual pattern to modify a property is to retrieve the provisioning service metadata and security metadata, and then combine them with the modified values in a new body to update the provisioning service.")
  @operationId("IotDpsResource_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProvisioningServiceDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update an existing provisioning service's tags. to update other fields use the CreateOrUpdate method")
  @operationId("IotDpsResource_Update")
  update is ArmCustomPatchAsync<ProvisioningServiceDescription, TagsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the Provisioning Service.")
  @operationId("IotDpsResource_Delete")
  delete is ArmResourceDeleteAsync<ProvisioningServiceDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a list of all provisioning services in the given resource group.")
  @operationId("IotDpsResource_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ProvisioningServiceDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all the provisioning services for a given subscription id.")
  @operationId("IotDpsResource_ListBySubscription")
  listBySubscription is ArmListBySubscription<ProvisioningServiceDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the primary and secondary keys for a provisioning service.")
  @operationId("IotDpsResource_ListKeys")
  listKeys is ArmResourceActionSync<
    ProvisioningServiceDescription,
    void,
    SharedAccessSignatureAuthorizationRuleListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List primary and secondary keys for a specific key name")
  @operationId("IotDpsResource_ListKeysForKeyName")
  listKeysForKeyName is ArmResourceActionSync<
    ProvisioningServiceDescription,
    void,
    SharedAccessSignatureAuthorizationRuleAccessRightsDescription,
    {
      ...BaseParameters<ProvisioningServiceDescription>;

      @doc("Logical key name to get key-values for.")
      @path
      keyName: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_listValidSkus")
  @summary("Get the list of valid SKUs for a provisioning service.")
  @doc("Gets the list of valid SKUs and tiers for a provisioning service.")
  // FIXME: IotDpsResource_listValidSkus could not be converted to a resource operation
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

@@projectedName(ProvisioningServiceDescriptions.createOrUpdate::parameters.resource,
  "json",
  "iotDpsDescription"
);
@@extension(ProvisioningServiceDescriptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "iotDpsDescription"
);
@@doc(ProvisioningServiceDescriptions.createOrUpdate::parameters.resource,
  "Description of the provisioning service to create or update."
);
@@projectedName(ProvisioningServiceDescriptions.update::parameters.properties,
  "json",
  "ProvisioningServiceTags"
);
@@extension(ProvisioningServiceDescriptions.update::parameters.properties,
  "x-ms-client-name",
  "ProvisioningServiceTags"
);
@@doc(ProvisioningServiceDescriptions.update::parameters.properties,
  "Updated tag information to set into the provisioning service instance."
);
