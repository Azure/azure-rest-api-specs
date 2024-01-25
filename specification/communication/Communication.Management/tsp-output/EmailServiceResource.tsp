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

namespace Microsoft.Communication;
/**
 * A class representing an EmailService resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(EmailServiceProperties)
model EmailServiceResource extends TrackedResourceBase {
  /**
   * The name of the EmailService resource.
   */
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  @path
  @key("emailServiceName")
  @segment("emailServices")
  @visibility("read")
  name: string;

  /**
   * The properties of the service.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EmailServiceProperties;
}

@armResourceOperations
interface EmailServiceResources {
  /**
   * Get the EmailService and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EmailServices_Get")
  get is ArmResourceRead<EmailServiceResource>;

  /**
   * Create a new EmailService or update an existing EmailService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EmailServices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EmailServiceResource,
    BaseParameters<EmailServiceResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Operation to update an existing EmailService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("EmailServices_Update")
  update is ArmCustomPatchAsync<
    EmailServiceResource,
    EmailServiceResourceUpdate,
    BaseParameters<EmailServiceResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Operation to delete a EmailService.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EmailServices_Delete")
  delete is ArmResourceDeleteAsync<
    EmailServiceResource,
    BaseParameters<EmailServiceResource>,
    ArmLroLocationHeader
  >;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EmailServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<EmailServiceResource>;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EmailServices_ListBySubscription")
  listBySubscription is ArmListBySubscription<EmailServiceResource>;

  /**
   * Get a list of domains that are fully verified in Exchange Online.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EmailServices_ListVerifiedExchangeOnlineDomains")
  listVerifiedExchangeOnlineDomains is ArmListBySubscription<EmailServiceResource>;
}

@@projectedName(EmailServiceResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(EmailServiceResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EmailServiceResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(EmailServiceResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(EmailServiceResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(EmailServiceResources.update::parameters.properties,
  "Parameters for the update operation"
);
