import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NginxDeployment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Nginx.NginxPlus;

@parentResource(NginxDeployment)
model NginxDeploymentApiKeyResponse
  is Azure.ResourceManager.ProxyResource<NginxDeploymentApiKeyResponseProperties> {
  ...ResourceNameParameter<
    Resource = NginxDeploymentApiKeyResponse,
    KeyName = "apiKeyName",
    SegmentName = "apiKeys",
    NamePattern = "^([a-z0-9A-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]|[a-z0-9A-Z])$"
  >;
}

@armResourceOperations
interface NginxDeploymentApiKeyResponses {
  /**
   * Get the specified API Key of the given Nginx deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ApiKeys_Get")
  get is ArmResourceRead<NginxDeploymentApiKeyResponse>;

  /**
   * Create or update an API Key for the Nginx deployment in order to access the dataplane API endpoint
   */
  /**
   * Delete API key for Nginx deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ApiKeys_CreateOrUpdate")
  @armResourceCreateOrUpdate(NginxDeploymentApiKeyResponse)
  createOrUpdate is Azure.ResourceManager.Legacy.UpdateOperation<
    ResourceInstanceParameters<
      NginxDeploymentApiKeyResponse,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<NginxDeploymentApiKeyResponse>
    >,
    NginxDeploymentApiKeyRequest,
    NginxDeploymentApiKeyResponse | ArmResourceCreatedResponse<NginxDeploymentApiKeyResponse>,
    ErrorResponse,
    OptionalRequestBody = true
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ApiKeys_Delete")
  delete is ArmResourceDeleteSync<NginxDeploymentApiKeyResponse>;

  /**
   * List all API Keys of the given Nginx deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ApiKeys_List")
  list is ArmResourceListByParent<
    NginxDeploymentApiKeyResponse,
    Response = ArmResponse<NginxDeploymentApiKeyListResponse>
  >;
}

@@doc(NginxDeploymentApiKeyResponse.name, "The resource name of the API key");
@@doc(NginxDeploymentApiKeyResponse.properties, "");
@@doc(NginxDeploymentApiKeyResponses.createOrUpdate::parameters.properties,
  "The API Key object containing fields (e.g. secret text, expiration date) to upsert the key."
);
