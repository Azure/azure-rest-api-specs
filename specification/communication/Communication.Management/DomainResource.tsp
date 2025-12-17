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
interface Domains {
  /**
   * Get the Domains resource and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<DomainResource>;

  /**
   * Add a new Domains resource under the parent EmailService resource or update an existing Domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DomainResource>;

  /**
   * Operation to update an existing Domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DomainResource,
    PatchModel = UpdateDomainRequestParameters,
    Response = ArmResponse<DomainResource> | ArmResourceCreatedResponse<
      DomainResource,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = DomainResource> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Operation to delete a Domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DomainResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all Domains resources under the parent EmailServices resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByEmailServiceResource is ArmResourceListByParent<
    DomainResource,
    Response = ArmResponse<DomainResourceList>
  >;

  /**
   * Initiate verification of DNS record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  initiateVerification is ArmResourceActionAsyncBase<
    DomainResource,
    VerificationParameter,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<DomainResource>
  >;

  /**
   * Cancel verification of DNS record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
@@doc(Domains.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(Domains.update::parameters.properties,
  "Parameters for the update operation"
);
@@doc(Domains.initiateVerification::parameters.body,
  "Type of verification to be initiated."
);
@@doc(Domains.cancelVerification::parameters.body,
  "Type of verification to be canceled."
);
