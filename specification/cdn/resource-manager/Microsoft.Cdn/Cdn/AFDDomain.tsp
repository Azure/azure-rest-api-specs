import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Friendly domain name mapping to the endpoint hostname that the customer provides for branding purposes, e.g. www.contoso.com.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Profile)
model AFDDomain is Azure.ResourceManager.ProxyResource<AFDDomainProperties> {
  ...ResourceNameParameter<
    Resource = AFDDomain,
    KeyName = "customDomainName",
    SegmentName = "customDomains",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AFDDomains {
  /**
   * Gets an existing AzureFrontDoor domain with the specified domain name under the specified subscription, resource group and profile.
   */
  get is ArmResourceRead<AFDDomain>;

  /**
   * Creates a new domain within the specified profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    AFDDomain,
    Response = ArmResourceUpdatedResponse<AFDDomain> | ArmResourceCreatedResponse<
      AFDDomain,
      LroHeaders = ArmLroLocationHeader<FinalResult = AFDDomain>
    > | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AFDDomain> &
      ArmLroLocationHeader<FinalResult = AFDDomain>> & {
      @bodyRoot
      _: AFDDomain;
    })
  >;

  /**
   * Updates an existing domain within a profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AFDDomain,
    PatchModel = AFDDomainUpdateParameters,
    Response = ArmResponse<AFDDomain> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AFDDomain> &
      ArmLroLocationHeader<FinalResult = AFDDomain> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AFDDomain;
    })
  >;

  /**
   * Deletes an existing AzureFrontDoor domain with the specified domain name under the specified subscription, resource group and profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    AFDDomain,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists existing AzureFrontDoor domains.
   */
  @list
  listByProfile is ArmResourceListByParent<AFDDomain>;

  /**
   * Updates the domain validation token.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  refreshValidationToken is ArmResourceActionAsync<
    AFDDomain,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(AFDDomain.name,
  "Name of the domain under the profile which is unique globally."
);
@@doc(AFDDomain.properties,
  "The JSON object that contains the properties of the domain to create."
);
@@doc(AFDDomains.create::parameters.resource, "Domain properties");
@@doc(AFDDomains.update::parameters.properties, "Domain properties");
