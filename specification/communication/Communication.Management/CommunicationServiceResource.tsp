import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
/**
 * A class representing a CommunicationService resource.
 */
model CommunicationServiceResource
  is Azure.ResourceManager.TrackedResource<CommunicationServiceProperties> {
  ...ResourceNameParameter<
    Resource = CommunicationServiceResource,
    KeyName = "communicationServiceName",
    SegmentName = "communicationServices",
    NamePattern = "^[-\\w]+$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface CommunicationServiceResources {
  /**
   * Get the CommunicationService and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommunicationServices_Get")
  get is ArmResourceRead<CommunicationServiceResource>;

  /**
   * Create a new CommunicationService or update an existing CommunicationService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommunicationServices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CommunicationServiceResource>;

  /**
   * Operation to update an existing CommunicationService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("CommunicationServices_Update")
  update is ArmCustomPatchSync<
    CommunicationServiceResource,
    PatchModel = CommunicationServiceResourceUpdate
  >;

  /**
   * Operation to delete a CommunicationService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("CommunicationServices_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    CommunicationServiceResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommunicationServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    CommunicationServiceResource,
    Response = ArmResponse<CommunicationServiceResourceList>
  >;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommunicationServices_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    CommunicationServiceResource,
    Response = ArmResponse<CommunicationServiceResourceList>
  >;

  /**
   * Links an Azure Notification Hub to this communication service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommunicationServices_LinkNotificationHub")
  linkNotificationHub is ArmResourceActionSync<
    CommunicationServiceResource,
    {
      /**
       * Parameters supplied to the operation.
       */
      @bodyRoot
      linkNotificationHubParameters?: LinkNotificationHubParameters;
    },
    ArmResponse<LinkedNotificationHub>
  >;

  /**
   * Get the access keys of the CommunicationService resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommunicationServices_ListKeys")
  listKeys is ArmResourceActionSync<
    CommunicationServiceResource,
    void,
    ArmResponse<CommunicationServiceKeys>
  >;

  /**
   * Regenerate CommunicationService access key. PrimaryKey and SecondaryKey cannot be regenerated at the same time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommunicationServices_RegenerateKey")
  regenerateKey is ArmResourceActionSync<
    CommunicationServiceResource,
    RegenerateKeyParameters,
    ArmResponse<CommunicationServiceKeys>
  >;
}

@@maxLength(CommunicationServiceResource.name, 63);
@@minLength(CommunicationServiceResource.name, 1);
@@doc(CommunicationServiceResource.name,
  "The name of the CommunicationService resource."
);
@@doc(CommunicationServiceResource.properties,
  "The properties of the service."
);
@@doc(CommunicationServiceResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(CommunicationServiceResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@doc(CommunicationServiceResources.regenerateKey::parameters.body,
  "Parameter that describes the Regenerate Key Operation."
);
