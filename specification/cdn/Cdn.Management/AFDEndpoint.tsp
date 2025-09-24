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
 * Azure Front Door endpoint is the entity within a Azure Front Door profile containing configuration information such as origin, protocol, content caching and delivery behavior. The AzureFrontDoor endpoint uses the URL format <endpointname>.azureedge.net.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Profile)
model AFDEndpoint
  is Azure.ResourceManager.TrackedResource<AFDEndpointProperties> {
  ...ResourceNameParameter<
    Resource = AFDEndpoint,
    KeyName = "endpointName",
    SegmentName = "afdEndpoints",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AFDEndpoints {
  /**
   * Gets an existing AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  get is ArmResourceRead<AFDEndpoint>;

  /**
   * Creates a new AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    AFDEndpoint,
    Response = ArmResourceUpdatedResponse<AFDEndpoint> | ArmResourceCreatedResponse<AFDEndpoint> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AFDEndpoint> &
      ArmLroLocationHeader<FinalResult = AFDEndpoint> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AFDEndpoint;
    })
  >;

  /**
   * Updates an existing AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile. Only tags can be updated after creating an endpoint. To update origins, use the Update Origin operation. To update origin groups, use the Update Origin group operation. To update domains, use the Update Custom Domain operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AFDEndpoint,
    PatchModel = AFDEndpointUpdateParameters,
    Response = ArmResponse<AFDEndpoint> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AFDEndpoint> &
      ArmLroLocationHeader<FinalResult = AFDEndpoint>> & {
      @bodyRoot
      _: AFDEndpoint;
    })
  >;

  /**
   * Deletes an existing AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    AFDEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists existing AzureFrontDoor endpoints.
   */
  @list
  listByProfile is ArmResourceListByParent<AFDEndpoint>;

  /**
   * Removes a content from AzureFrontDoor.
   */
  @action("purge")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  purgeContent is ArmResourceActionAsync<
    AFDEndpoint,
    AfdPurgeParameters,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Checks the quota and actual usage of endpoints under the given Azure Front Door profile.
   */
  @action("usages")
  @list
  listResourceUsage is ArmResourceActionSync<
    AFDEndpoint,
    void,
    ArmResponse<UsagesListResult>
  >;

  /**
   * Validates the custom domain mapping to ensure it maps to the correct Azure Front Door endpoint in DNS.
   */
  validateCustomDomain is ArmResourceActionSync<
    AFDEndpoint,
    ValidateCustomDomainInput,
    ArmResponse<ValidateCustomDomainOutput>
  >;
}

@@doc(AFDEndpoint.name,
  "Name of the endpoint under the profile which is unique globally."
);
@@doc(AFDEndpoint.properties,
  "The JSON object that contains the properties required to create an endpoint."
);
@@doc(AFDEndpoints.create::parameters.resource, "Endpoint properties");
@@doc(AFDEndpoints.update::parameters.properties, "Endpoint update properties");
@@doc(AFDEndpoints.purgeContent::parameters.body,
  "The list of paths to the content and the list of linked domains to be purged. Path can be a full URL, e.g. '/pictures/city.png' which removes a single file, or a directory with a wildcard, e.g. '/pictures/*' which removes all folders and files in the directory."
);
@@doc(AFDEndpoints.validateCustomDomain::parameters.body,
  "Custom domain to be validated."
);
