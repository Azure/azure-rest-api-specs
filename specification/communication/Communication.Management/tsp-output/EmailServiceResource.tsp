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
@doc("A class representing an EmailService resource.")
model EmailServiceResource is TrackedResource<EmailServiceProperties> {
  @doc("The name of the EmailService resource.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  @path
  @key("emailServiceName")
  @segment("emailServices")
  name: string;
}

@armResourceOperations
interface EmailServiceResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the EmailService and its properties.")
  @operationId("EmailServices_Get")
  get is ArmResourceRead<EmailServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a new EmailService or update an existing EmailService.")
  @operationId("EmailServices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    EmailServiceResource,
    BaseParameters<EmailServiceResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to update an existing EmailService.")
  @operationId("EmailServices_Update")
  update is ArmCustomPatchAsync<
    EmailServiceResource,
    EmailServiceResourceUpdate,
    BaseParameters<EmailServiceResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a EmailService.")
  @operationId("EmailServices_Delete")
  delete is ArmResourceDeleteAsync<
    EmailServiceResource,
    BaseParameters<EmailServiceResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a resource group.")
  @operationId("EmailServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<EmailServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a subscription.")
  @operationId("EmailServices_ListBySubscription")
  listBySubscription is ArmListBySubscription<EmailServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a list of domains that are fully verified in Exchange Online.")
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
