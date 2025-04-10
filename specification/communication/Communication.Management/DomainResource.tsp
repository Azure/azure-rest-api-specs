import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EmailServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
/**
 * A class representing a Domains resource.
 */
@parentResource(EmailServiceResource)
model DomainResource
  is Azure.ResourceManager.TrackedResource<DomainProperties> {
  ...ResourceNameParameter<
    Resource = DomainResource,
    KeyName = "domainName",
    SegmentName = "domains",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DomainResources {
  /**
   * Get the Domains resource and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Domains_Get")
  get is ArmResourceRead<DomainResource>;

  /**
   * Add a new Domains resource under the parent EmailService resource or update an existing Domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Domains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DomainResource>;

  /**
   * Operation to update an existing Domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Domains_Update")
  update is ArmCustomPatchAsync<
    DomainResource,
    PatchModel = UpdateDomainRequestParameters,
    Response = ArmResponse<DomainResource> | ArmResourceCreatedResponse<DomainResource>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to delete a Domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Domains_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DomainResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all Domains resources under the parent EmailServices resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Domains_ListByEmailServiceResource")
  listByEmailServiceResource is ArmResourceListByParent<
    DomainResource,
    Response = ArmResponse<DomainResourceList>
  >;

  /**
   * Initiate verification of DNS record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Domains_InitiateVerification")
  initiateVerification is ArmResourceActionAsyncBase<
    DomainResource,
    VerificationParameter,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<DomainResource>
  >;

  /**
   * Cancel verification of DNS record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Domains_CancelVerification")
  cancelVerification is ArmResourceActionAsyncBase<
    DomainResource,
    VerificationParameter,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<DomainResource>
  >;
}

@@maxLength(DomainResource.name, 253);
@@minLength(DomainResource.name, 1);
@@doc(DomainResource.name, "The name of the Domains resource.");
@@doc(DomainResource.properties, "The properties of a Domains resource.");
@@doc(DomainResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(DomainResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@doc(DomainResources.initiateVerification::parameters.body,
  "Type of verification to be initiated."
);
@@doc(DomainResources.cancelVerification::parameters.body,
  "Type of verification to be canceled."
);
