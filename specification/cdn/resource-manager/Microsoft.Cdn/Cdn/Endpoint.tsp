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
 * CDN endpoint is the entity within a CDN profile containing configuration information such as origin, protocol, content caching and delivery behavior. The CDN endpoint uses the URL format <endpointname>.azureedge.net.
 */
@parentResource(Profile)
model Endpoint is Azure.ResourceManager.TrackedResource<EndpointProperties> {
  ...ResourceNameParameter<
    Resource = Endpoint,
    KeyName = "endpointName",
    SegmentName = "endpoints",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Endpoints {
  /**
   * Gets an existing CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  get is ArmResourceRead<Endpoint>;

  /**
   * Creates a new CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<
    Endpoint,
    Response = ArmResourceUpdatedResponse<Endpoint> | ArmResourceCreatedResponse<Endpoint> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Endpoint>> & {
      @bodyRoot
      _: Endpoint;
    })
  >;

  /**
   * Updates an existing CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile. Only tags can be updated after creating an endpoint. To update origins, use the Update Origin operation. To update origin groups, use the Update Origin group operation. To update custom domains, use the Update Custom Domain operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Endpoint,
    PatchModel = EndpointUpdateParameters,
    Response = ArmResponse<Endpoint> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Endpoint>> & {
      @bodyRoot
      _: Endpoint;
    })
  >;

  /**
   * Deletes an existing CDN endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Endpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists existing CDN endpoints.
   */
  @list
  listByProfile is ArmResourceListByParent<Endpoint>;

  /**
   * Starts an existing CDN endpoint that is on a stopped state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  start is Azure.ResourceManager.ArmResourceActionAsyncBase<
    Endpoint,
    void,
    (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Endpoint>> & {
      @bodyRoot
      _: Endpoint;
    }) | ArmResponse<Endpoint>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Endpoint>
  >;

  /**
   * Stops an existing running CDN endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  stop is Azure.ResourceManager.ArmResourceActionAsyncBase<
    Endpoint,
    void,
    (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Endpoint>> & {
      @bodyRoot
      _: Endpoint;
    }) | ArmResponse<Endpoint>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Endpoint>
  >;

  /**
   * Removes a content from CDN.
   */
  @action("purge")
  purgeContent is ArmResourceActionAsyncBase<
    Endpoint,
    PurgeParameters,
    ArmAcceptedLroResponse | OkResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Endpoint>
  >;

  /**
   * Pre-loads a content to CDN. Available for Verizon Profiles.
   */
  @action("load")
  loadContent is ArmResourceActionAsyncBase<
    Endpoint,
    LoadParameters,
    ArmAcceptedLroResponse | OkResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Endpoint>
  >;

  /**
   * Validates the custom domain mapping to ensure it maps to the correct CDN endpoint in DNS.
   */
  validateCustomDomain is ArmResourceActionSync<
    Endpoint,
    ValidateCustomDomainInput,
    ArmResponse<ValidateCustomDomainOutput>
  >;

  /**
   * Checks the quota and usage of geo filters and custom domains under the given endpoint.
   */
  @action("checkResourceUsage")
  @list
  listResourceUsage is ArmResourceActionSync<
    Endpoint,
    void,
    ArmResponse<ResourceUsageListResult>
  >;
}

@@doc(Endpoint.name,
  "Name of the endpoint under the profile which is unique globally."
);
@@doc(Endpoint.properties,
  "The JSON object that contains the properties required to create an endpoint."
);
@@doc(Endpoints.create::parameters.resource, "Endpoint properties");
@@doc(Endpoints.update::parameters.properties, "Endpoint update properties");
@@doc(Endpoints.purgeContent::parameters.body,
  "The path to the content to be purged. Path can be a full URL, e.g. '/pictures/city.png' which removes a single file, or a directory with a wildcard, e.g. '/pictures/*' which removes all folders and files in the directory."
);
@@doc(Endpoints.loadContent::parameters.body,
  "The path to the content to be loaded. Path should be a full URL, e.g. ‘/pictures/city.png' which loads a single file "
);
@@doc(Endpoints.validateCustomDomain::parameters.body,
  "Custom domain to be validated."
);
