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
 * A class representing an EmailService resource.
 */
model EmailServiceResource
  is Azure.ResourceManager.TrackedResource<EmailServiceProperties> {
  ...ResourceNameParameter<
    Resource = EmailServiceResource,
    KeyName = "emailServiceName",
    SegmentName = "emailServices",
    NamePattern = "^[a-zA-Z0-9-]+$"
  >;
}

@armResourceOperations
interface EmailServiceResources {
  /**
   * Get the EmailService and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EmailServices_Get")
  get is ArmResourceRead<EmailServiceResource>;

  /**
   * Create a new EmailService or update an existing EmailService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EmailServices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EmailServiceResource>;

  /**
   * Operation to update an existing EmailService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("EmailServices_Update")
  update is ArmCustomPatchAsync<
    EmailServiceResource,
    PatchModel = EmailServiceResourceUpdate,
    Response = ArmResponse<EmailServiceResource> | ArmResourceCreatedResponse<EmailServiceResource>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to delete a EmailService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("EmailServices_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    EmailServiceResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EmailServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    EmailServiceResource,
    Response = ArmResponse<EmailServiceResourceList>
  >;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EmailServices_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    EmailServiceResource,
    Response = ArmResponse<EmailServiceResourceList>
  >;
}

@@maxLength(EmailServiceResource.name, 63);
@@minLength(EmailServiceResource.name, 1);
@@doc(EmailServiceResource.name, "The name of the EmailService resource.");
@@doc(EmailServiceResource.properties, "The properties of the service.");
@@doc(EmailServiceResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(EmailServiceResources.update::parameters.properties,
  "Parameters for the update operation"
);
