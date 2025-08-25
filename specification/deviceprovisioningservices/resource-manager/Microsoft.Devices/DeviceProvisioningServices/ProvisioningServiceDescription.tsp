import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The description of the provisioning service.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * The resource group of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourcegroup?: string;

  /**
   * The subscription id of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionid?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(false)
  properties: IotDpsPropertiesDescription;

  /**
   * Sku info for a provisioning Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: IotDpsSkuInfo;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProvisioningServiceDescriptionOperationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Name of the provisioning service to retrieve.
         */
        @path
        @segment("provisioningServices")
        provisioningServiceName: string,
      },
      {
        /**
         * Operation id corresponding to long running operation. Use this to poll for the status.
         */
        @path
        @segment("operationresults")
        operationId: string,
      },
      ErrorDetails
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProvisioningServiceDescriptionOperations {
  /**
   * Gets the status of a long running operation, such as create, update or delete a provisioning service.
   */
  getOperationResult is ProvisioningServiceDescriptionOperationOps.Read<
    ProvisioningServiceDescription,
    Parameters = {
      /**
       * Async header used to poll on the status of the operation, obtained while creating the long running operation.
       */
      @query("asyncinfo")
      asyncinfo: string = "true";
    },
    Response = ArmResponse<AsyncOperationResult>
  >;
}

@armResourceOperations
interface ProvisioningServiceDescriptions {
  /**
   * Get the metadata of the provisioning service without SAS keys.
   */
  get is ArmResourceRead<ProvisioningServiceDescription, Error = ErrorDetails>;

  /**
   * Create or update the metadata of the provisioning service. The usual pattern to modify a property is to retrieve the provisioning service metadata and security metadata, and then combine them with the modified values in a new body to update the provisioning service.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ProvisioningServiceDescription,
    LroHeaders = ArmLroLocationHeader<FinalResult = ProvisioningServiceDescription> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorDetails
  >;

  /**
   * Update an existing provisioning service's tags. to update other fields use the CreateOrUpdate method
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ProvisioningServiceDescription,
    PatchModel = TagsResource,
    Response = ArmResponse<ProvisioningServiceDescription> &
      ArmLroLocationHeader<FinalResult = ProvisioningServiceDescription>
  >;

  /**
   * Deletes the Provisioning Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  listByResourceGroup is ArmResourceListByParent<
    ProvisioningServiceDescription,
    Error = ErrorDetails
  >;

  /**
   * List all the provisioning services for a given subscription id.
   */
  listBySubscription is ArmListBySubscription<
    ProvisioningServiceDescription,
    Error = ErrorDetails
  >;

  /**
   * Gets the list of valid SKUs and tiers for a provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("skus")
  @list
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
  @action("listkeys")
  @list
  listKeys is ArmResourceActionSync<
    ProvisioningServiceDescription,
    void,
    ArmResponse<SharedAccessSignatureAuthorizationRuleListResult>,
    Error = ErrorDetails
  >;

  /**
   * List primary and secondary keys for a specific key name
   */
  @action("listkeys")
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
