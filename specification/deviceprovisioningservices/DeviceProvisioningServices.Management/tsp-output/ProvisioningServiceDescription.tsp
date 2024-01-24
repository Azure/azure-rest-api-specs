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
/**
 * The description of the provisioning service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(IotDpsPropertiesDescription)
@includeInapplicableMetadataInPayload(false)
model ProvisioningServiceDescription extends TrackedResourceBase {
  /**
   * Name of the provisioning service to retrieve.
   */
  @path
  @key("provisioningServiceName")
  @segment("provisioningServices")
  name: string;

  /**
   * The Etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal ETag convention.
   */
  etag?: string;

  /**
   * Service specific properties for a provisioning service
   */
  @extension("x-ms-client-flatten", true)
  properties: IotDpsPropertiesDescription;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ProvisioningServiceDescriptions {
  /**
   * Get the metadata of the provisioning service without SAS keys.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_Get")
  get is ArmResourceRead<ProvisioningServiceDescription>;

  /**
   * Create or update the metadata of the provisioning service. The usual pattern to modify a property is to retrieve the provisioning service metadata and security metadata, and then combine them with the modified values in a new body to update the provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ProvisioningServiceDescription>;

  /**
   * Update an existing provisioning service's tags. to update other fields use the CreateOrUpdate method
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("IotDpsResource_Update")
  update is ArmCustomPatchAsync<ProvisioningServiceDescription, TagsResource>;

  /**
   * Deletes the Provisioning Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_Delete")
  delete is ArmResourceDeleteAsync<ProvisioningServiceDescription>;

  /**
   * Get a list of all provisioning services in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ProvisioningServiceDescription>;

  /**
   * List all the provisioning services for a given subscription id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_ListBySubscription")
  listBySubscription is ArmListBySubscription<ProvisioningServiceDescription>;

  /**
   * List the primary and secondary keys for a provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_ListKeys")
  listKeys is ArmResourceActionSync<
    ProvisioningServiceDescription,
    void,
    SharedAccessSignatureAuthorizationRuleListResult
  >;

  /**
   * List primary and secondary keys for a specific key name
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_ListKeysForKeyName")
  listKeysForKeyName is ArmResourceActionSync<
    ProvisioningServiceDescription,
    void,
    SharedAccessSignatureAuthorizationRuleAccessRightsDescription,
    {
      ...BaseParameters<ProvisioningServiceDescription>;

      /**
       * Logical key name to get key-values for.
       */
      @path
      keyName: string;
    }
  >;

  /**
   * Gets the list of valid SKUs and tiers for a provisioning service.
   */
  // FIXME: IotDpsResource_listValidSkus could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_listValidSkus")
  @summary("Get the list of valid SKUs for a provisioning service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/skus")
  @get
  listValidSkus is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of provisioning service.
       */
      @path
      provisioningServiceName: string;

      /**
       * The subscription identifier.
       */
      @path
      subscriptionId: string;

      /**
       * Name of resource group.
       */
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
