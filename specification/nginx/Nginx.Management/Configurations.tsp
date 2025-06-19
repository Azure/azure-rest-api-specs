import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
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
 * Response model for configuration analysis.
 */
model ConfigurationAnalysisResponse {
  /**
   * List of analysis results for the configuration.
   */
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  value: ConfigurationAnalysisResult[];

  /**
   * URL to fetch the next page of analysis results.
   */
  nextLink?: string;
}

/**
 * Configuration analysis result.
 */
model ConfigurationAnalysisResult {
  /**
   * Unique identifier for the analysis result.
   */
  id: string;

  /**
   * Severity level of the analysis finding.
   */
  severity: AnalysisSeverity;

  /**
   * The type of analysis finding.
   */
  type: string;

  /**
   * Descriptive message about the analysis finding.
   */
  message: string;

  /**
   * File path where the issue was found.
   */
  filePath?: string;

  /**
   * Line number where the issue was found.
   */
  lineNumber?: int32;

  /**
   * Suggested resolution for the issue.
   */
  resolution?: string;
}

/**
 * Severity level of an analysis finding.
 */
union AnalysisSeverity {
  /** Error level finding that should be addressed immediately. */
  Error: "Error",

  /** Warning level finding that should be reviewed. */
  Warning: "Warning",

  /** Information level finding that may be helpful but not critical. */
  Info: "Info",

  /** Other severity levels not covered by pre-defined values. */
  string,
}

/**
 * Request model for analyzing a configuration.
 */
model ConfigurationAnalysisRequest {
  /**
   * Specific files to analyze. If not provided, all configuration files will be analyzed.
   */
  files?: string[];

  /**
   * Specific analysis types to run. If not provided, all available analyses will be run.
   */
  analysisTypes?: string[];

  /**
   * Minimum severity level of findings to include in the results.
   */
  minimumSeverity?: AnalysisSeverity;
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

  /**
   * Analyzes a configuration for potential issues or optimizations.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "This is not a long-running operation"
  @post
  @action("analyze")
  @armResourceAction(ConfigurationAnalysisResponse)
  analyze(
    ...ResourceInstanceParameters<Configuration>,

    /**
     * Request body for the analysis.
     */
    @body request: ConfigurationAnalysisRequest,
  ): ArmResponse<ConfigurationAnalysisResponse> | ArmAcceptedResponse | ErrorResponse;
}
