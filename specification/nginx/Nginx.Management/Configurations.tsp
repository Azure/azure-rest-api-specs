import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Azure.ResourceManager;

namespace Nginx.NginxPlus;

/**
 * Represents an Nginx configuration resource.
 */
@parentResource(NginxDeployment)
model Configuration is ProxyResource<NginxConfigurationResponseProperties> {
  ...ResourceNameParameter<Configuration>;
}

/**
 * Request model for creating or updating an Nginx configuration.
 */
@parentResource(NginxDeployment)
@resource("configurations")
model NginxConfigurationRequest
  is ProxyResource<NginxConfigurationRequestProperties> {
  ...ResourceNameParameter<Configuration>;
}

/**
 * Represents a configuration file.
 */
model NginxConfigurationFile {
  /**
   * File content.
   */
  content?: string;

  /**
   * Virtual path of the file.
   */
  virtualPath?: string;
}

/**
 * Request model for a protected configuration file.
 */
model NginxConfigurationProtectedFileRequest {
  /**
   * File content.
   */
  content?: string;

  /**
   * Virtual path of the file.
   */
  virtualPath?: string;

  /**
   * Content hash of the file.
   */
  contentHash?: string;
}

/**
 * Response model for a protected configuration file.
 */
model NginxConfigurationProtectedFileResponse {
  /**
   * Virtual path of the file.
   */
  virtualPath?: string;

  /**
   * Content hash of the file.
   */
  contentHash?: string;
}

/**
 * Represents a configuration package.
 */
model NginxConfigurationPackage {
  /**
   * Package data.
   */
  data?: string;

  /**
   * List of protected files in the package.
   */
  protectedFiles?: string[];
}

/**
 * Properties returned for an Nginx configuration resource.
 */
model NginxConfigurationResponseProperties {
  /**
   * Provisioning state of the configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * List of configuration files.
   */
  @OpenAPI.extension("x-ms-identifiers", #["virtualPath"])
  files?: NginxConfigurationFile[];

  /**
   * List of protected files.
   */
  @OpenAPI.extension("x-ms-identifiers", #["virtualPath"])
  protectedFiles?: NginxConfigurationProtectedFileResponse[];

  /**
   * Configuration package details.
   */
  package?: NginxConfigurationPackage;

  /**
   * Root file of the configuration.
   */
  rootFile?: string;
}

/**
 * Properties for an Nginx configuration request.
 */
model NginxConfigurationRequestProperties {
  /**
   * Provisioning state of the configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * List of configuration files.
   */
  @OpenAPI.extension("x-ms-identifiers", #["virtualPath"])
  files?: NginxConfigurationFile[];

  /**
   * List of protected file requests.
   */
  @OpenAPI.extension("x-ms-identifiers", #["virtualPath"])
  protectedFiles?: NginxConfigurationProtectedFileRequest[];

  /**
   * Configuration package data.
   */
  package?: NginxConfigurationPackage;

  /**
   * Root file path.
   */
  rootFile?: string;
}

/**
 * Response model for listing Nginx configurations.
 */
model NginxConfigurationListResponse {
  /**
   * List of configurations.
   */
  value: Configuration[];

  /**
   * URL to fetch the next page of configurations.
   */
  nextLink?: string;
}

/**
 * Operations on Nginx configurations under a given deployment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "We already have a delete operation defined in the interface"
@armResourceOperations
interface Configurations {
  /**
   * Retrieves the properties of a specific configuration.
   */
  get is ArmResourceRead<Configuration>;

  /**
   * Creates or updates a configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "The request and response models are different by design"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "We have all the response codes defined in the model"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Resource = NginxConfigurationRequest,
    Response = Configuration
  >;

  /**
   * Patches an existing configuration.
   */
  update is ArmCustomPatchSync<
    Configuration,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Configuration,
      NginxConfigurationRequestProperties
    >
  >;

  /**
   * Deletes a specific configuration.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Configuration>;

  /**
   * Lists all configurations in a parent deployment.
   */
  listByDeployment is ArmResourceListByParent<Configuration>;
}
