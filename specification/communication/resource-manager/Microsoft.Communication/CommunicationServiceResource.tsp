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
interface CommunicationServices {
  /**
   * Get the CommunicationService and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<CommunicationServiceResource>;

  /**
   * Create a new CommunicationService or update an existing CommunicationService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CommunicationServiceResource>;

  /**
   * Operation to update an existing CommunicationService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    CommunicationServiceResource,
    PatchModel = CommunicationServiceResourceUpdate
  >;

  /**
   * Operation to delete a CommunicationService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    CommunicationServiceResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByResourceGroup is ArmResourceListByParent<
    CommunicationServiceResource,
    Response = ArmResponse<CommunicationServiceResourceList>
  >;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listBySubscription is ArmListBySubscription<
    CommunicationServiceResource,
    Response = ArmResponse<CommunicationServiceResourceList>
  >;

  /**
   * Links an Azure Notification Hub to this communication service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  linkNotificationHub is ArmResourceActionSync<
    CommunicationServiceResource,
    LinkNotificationHubParameters,
    ArmResponse<LinkedNotificationHub>,
    OptionalRequestBody = true
  >;

  /**
   * Get the access keys of the CommunicationService resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listKeys is ArmResourceActionSync<
    CommunicationServiceResource,
    void,
    ArmResponse<CommunicationServiceKeys>
  >;

  /**
   * Regenerate CommunicationService access key. PrimaryKey and SecondaryKey cannot be regenerated at the same time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  regenerateKey is ArmResourceActionSync<
    CommunicationServiceResource,
    RegenerateKeyParameters,
    ArmResponse<CommunicationServiceKeys>
  >;

  /**
   * Checks that the CommunicationService name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Check Name Availability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = NameAvailabilityParameters,
    Response = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope
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
@@doc(CommunicationServices.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(CommunicationServices.update::parameters.properties,
  "Parameters for the update operation"
);
@@doc(CommunicationServices.linkNotificationHub::parameters.body,
  "Parameters supplied to the operation."
);
@@doc(CommunicationServices.regenerateKey::parameters.body,
  "Parameter that describes the Regenerate Key Operation."
);
