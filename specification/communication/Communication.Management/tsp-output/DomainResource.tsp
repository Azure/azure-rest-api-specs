import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EmailServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
@doc("A class representing a Domains resource.")
@parentResource(EmailServiceResource)
model DomainResource is TrackedResource<DomainProperties> {
  @doc("The name of the Domains resource.")
  @maxLength(253)
  @minLength(1)
  @path
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface DomainResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the Domains resource and its properties.")
  @operationId("Domains_Get")
  get is ArmResourceRead<DomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Add a new Domains resource under the parent EmailService resource or update an existing Domains resource.")
  @operationId("Domains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DomainResource,
    BaseParameters<DomainResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to update an existing Domains resource.")
  @operationId("Domains_Update")
  update is ArmCustomPatchAsync<
    DomainResource,
    UpdateDomainRequestParameters,
    BaseParameters<DomainResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a Domains resource.")
  @operationId("Domains_Delete")
  delete is ArmResourceDeleteAsync<
    DomainResource,
    BaseParameters<DomainResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all Domains resources under the parent EmailServices resource.")
  @operationId("Domains_ListByEmailServiceResource")
  listByEmailServiceResource is ArmResourceListByParent<DomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Initiate verification of DNS record.")
  @operationId("Domains_InitiateVerification")
  initiateVerification is ArmResourceActionNoResponseContentAsync<
    DomainResource,
    VerificationParameter,
    BaseParameters<DomainResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Cancel verification of DNS record.")
  @operationId("Domains_CancelVerification")
  cancelVerification is ArmResourceActionNoResponseContentAsync<
    DomainResource,
    VerificationParameter,
    BaseParameters<DomainResource>,
    ArmLroLocationHeader
  >;
}

@@projectedName(DomainResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DomainResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DomainResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(DomainResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(DomainResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(DomainResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@projectedName(DomainResources.initiateVerification::parameters.body,
  "json",
  "parameters"
);
@@extension(DomainResources.initiateVerification::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(DomainResources.initiateVerification::parameters.body,
  "Type of verification to be initiated."
);
@@projectedName(DomainResources.cancelVerification::parameters.body,
  "json",
  "parameters"
);
@@extension(DomainResources.cancelVerification::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(DomainResources.cancelVerification::parameters.body,
  "Type of verification to be canceled."
);
