import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Azure.ResourceManager;

namespace NGINX.NGINXPLUS;

/**
 * API key resource returned by the service.
 */
@parentResource(NginxDeployment)
model ApiKey is ProxyResource<ApiKeyResponseProperties> {
  ...ResourceNameParameter<ApiKey>;
}

/**
 * Request payload for creating or updating an API key.
 */
@parentResource(NginxDeployment)
@resource("apiKeys")
model ApiKeyRequest is ProxyResource<ApiKeyRequestProperties> {
  ...ResourceNameParameter<ApiKey>;
}

/**
 * Properties returned for an API key resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "We intentionally do not include provisioning state for API keys."
model ApiKeyResponseProperties {
  /**
   * Hint for the secret (read-only)
   */
  hint: string;

  /**
   * Expiry of the key
   */
  endDateTime: string;
}

/**
 * Properties for an API key request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "We intentionally do not include provisioning state for API keys."
model ApiKeyRequestProperties {
  /**
   * The secret text for the API key
   */
  secretText: string;

  /**
   * Expiry of the key
   */
  endDateTime: string;
}

/**
 * Operations on API Keys under a given Nginx deployment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "We already have a delete operation defined in the interface"
@armResourceOperations
interface ApiKeys {
  /**
   * Retrieves the properties of a specific API key.
   * @returns The details of the requested API key.
   */
  get is ArmResourceRead<ApiKey>;

  /**
   * Creates a new API key or replaces an existing one.
   * @returns The created or updated API key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "We have different data models by design"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "We have all the response codes defined in the model"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Resource = ApiKeyRequest,
    Response = ApiKey
  >;

  /**
   * Deletes the specified API key.
   * @returns A 204 No Content response on success.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ApiKey>;

  /**
   * Lists all API keys under the specified Nginx deployment.
   * @returns A paged list of API keys.
   */
  listByDeployment is ArmResourceListByParent<ApiKey>;
}
