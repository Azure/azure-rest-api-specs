import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager.Private;
namespace Microsoft.Devices;
/**
 * The description of the provisioning service.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" ""
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@Azure.ResourceManager.Private.armResourceInternal(IotDpsPropertiesDescription)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model ProvisioningServiceDescription
  extends Azure.ResourceManager.Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = ProvisioningServiceDescription,
    KeyName = "provisioningServiceName",
    SegmentName = "provisioningServices",
    NamePattern = ""
  >;

  /**
   * The Etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal ETag convention.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.conditionalClientFlatten
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(false)
  properties: IotDpsPropertiesDescription;

  /**
   * Sku info for a provisioning Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: IotDpsSkuInfo;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface ProvisioningServiceDescriptions {
  /**
   * Get the metadata of the provisioning service without SAS keys.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotDpsResource_Get")
  get is ArmResourceRead<ProvisioningServiceDescription, Error = ErrorDetails>;

  /**
   * Create or update the metadata of the provisioning service. The usual pattern to modify a property is to retrieve the provisioning service metadata and security metadata, and then combine them with the modified values in a new body to update the provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotDpsResource_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ProvisioningServiceDescription,
    LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorDetails
  >;

  /**
   * Update an existing provisioning service's tags. to update other fields use the CreateOrUpdate method
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("IotDpsResource_Update")
  update is ArmCustomPatchAsync<
    ProvisioningServiceDescription,
    PatchModel = TagsResource,
    Response = ArmResponse<ProvisioningServiceDescription> &
      ArmLroLocationHeader
  >;

  /**
   * Deletes the Provisioning Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("IotDpsResource_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProvisioningServiceDescription,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
      | ArmResourceNotFoundResponse,
    Error = ErrorDetails
  >;

  /**
   * Get a list of all provisioning services in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotDpsResource_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ProvisioningServiceDescription,
    Error = ErrorDetails
  >;

  /**
   * List all the provisioning services for a given subscription id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotDpsResource_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    ProvisioningServiceDescription,
    Error = ErrorDetails
  >;

  /**
   * Gets the status of a long running operation, such as create, update or delete a provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @operationId("IotDpsResource_GetOperationResult")
  getOperationResult is ArmResourceActionSync<
    ProvisioningServiceDescription,
    void,
    ArmResponse<AsyncOperationResult>,
    Parameters = {
      /**
       * Operation id corresponding to long running operation. Use this to poll for the status.
       */
      @path
      @segment("operationresults")
      operationId: string;

      /**
       * Async header used to poll on the status of the operation, obtained while creating the long running operation.
       */
      @query("asyncinfo")
      asyncinfo: string = "true";
    },
    Error = ErrorDetails
  >;

  /**
   * Gets the list of valid SKUs and tiers for a provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("skus")
  @operationId("IotDpsResource_listValidSkus")
  listValidSkus is ArmResourceActionSync<
    ProvisioningServiceDescription,
    void,
    ArmResponse<IotDpsSkuDefinitionListResult>,
    Error = ErrorDetails
  >;

  /**
   * List the primary and secondary keys for a provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listkeys")
  @operationId("IotDpsResource_ListKeys")
  listKeys is ArmResourceActionSync<
    ProvisioningServiceDescription,
    void,
    ArmResponse<SharedAccessSignatureAuthorizationRuleListResult>,
    Error = ErrorDetails
  >;

  /**
   * List primary and secondary keys for a specific key name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listkeys")
  @operationId("IotDpsResource_ListKeysForKeyName")
  listKeysForKeyName is ArmResourceActionSync<
    ProvisioningServiceDescription,
    void,
    ArmResponse<SharedAccessSignatureAuthorizationRuleAccessRightsDescription>,
    Parameters = {
      /**
       * Logical key name to get key-values for.
       */
      @path
      @segment("keys")
      keyName: string;
    },
    Error = ErrorDetails
  >;
}

@@doc(ProvisioningServiceDescription.name,
  "Name of the provisioning service to retrieve."
);
@@doc(ProvisioningServiceDescription.properties,
  "Service specific properties for a provisioning service"
);
@@doc(ProvisioningServiceDescriptions.createOrUpdate::parameters.resource,
  "Description of the provisioning service to create or update."
);
@@doc(ProvisioningServiceDescriptions.update::parameters.properties,
  "Updated tag information to set into the provisioning service instance."
);
