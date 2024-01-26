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
/**
 * A class representing a Domains resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(EmailServiceResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(DomainProperties)
model DomainResource extends TrackedResourceBase {
  /**
   * The name of the Domains resource.
   */
  @maxLength(253)
  @minLength(1)
  @path
  @key("domainName")
  @segment("domains")
  @visibility("read")
  name: string;

  /**
   * The properties of a Domains resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DomainProperties;
}

@armResourceOperations
interface DomainResources {
  /**
   * Get the Domains resource and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Domains_Get")
  get is ArmResourceRead<DomainResource>;

  /**
   * Add a new Domains resource under the parent EmailService resource or update an existing Domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Domains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DomainResource,
    BaseParameters<DomainResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Operation to update an existing Domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Domains_Update")
  update is ArmCustomPatchAsync<
    DomainResource,
    UpdateDomainRequestParameters,
    BaseParameters<DomainResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Operation to delete a Domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Domains_Delete")
  delete is ArmResourceDeleteAsync<
    DomainResource,
    BaseParameters<DomainResource>,
    ArmLroLocationHeader
  >;

  /**
   * Handles requests to list all Domains resources under the parent EmailServices resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Domains_ListByEmailServiceResource")
  listByEmailServiceResource is ArmResourceListByParent<DomainResource>;

  /**
   * Initiate verification of DNS record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Domains_InitiateVerification")
  initiateVerification is ArmResourceActionNoResponseContentAsync<
    DomainResource,
    VerificationParameter,
    BaseParameters<DomainResource>,
    ArmLroLocationHeader
  >;

  /**
   * Cancel verification of DNS record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
