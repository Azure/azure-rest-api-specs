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
interface EmailServices {
  /**
   * Get the EmailService and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<EmailServiceResource>;

  /**
   * Create a new EmailService or update an existing EmailService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EmailServiceResource>;

  /**
   * Operation to update an existing EmailService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    EmailServiceResource,
    PatchModel = EmailServiceResourceUpdate,
    Response = EmailServiceResource | ArmResourceCreatedResponse<
      EmailServiceResource,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = EmailServiceResource> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Operation to delete a EmailService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    EmailServiceResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByResourceGroup is ArmResourceListByParent<
    EmailServiceResource,
    Response = ArmResponse<EmailServiceResourceList>
  >;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listBySubscription is ArmListBySubscription<
    EmailServiceResource,
    Response = ArmResponse<EmailServiceResourceList>
  >;

  /**
   * Get a list of domains that are fully verified in Exchange Online.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("List Verified Domains From Exchange Online")
  @autoRoute
  listVerifiedExchangeOnlineDomains is ArmProviderActionSync<
    Response = ArmResponse<VerifiedExchangeOnlineDomainList>,
    Scope = SubscriptionActionScope
  >;
}

@@maxLength(EmailServiceResource.name, 63);
@@minLength(EmailServiceResource.name, 1);
@@doc(EmailServiceResource.name, "The name of the EmailService resource.");
@@doc(EmailServiceResource.properties, "The properties of the service.");
@@doc(EmailServices.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(EmailServices.update::parameters.properties,
  "Parameters for the update operation"
);
