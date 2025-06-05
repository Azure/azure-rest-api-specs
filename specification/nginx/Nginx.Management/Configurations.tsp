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
 * Analysis request payload for configuration analysis.
 */
model AnalysisCreate {
  /**
   * The configuration details to analyze.
   */
  config: {
    /**
     * Path to the root configuration file.
     */
    rootFile: string;

    /**
     * List of additional configuration files.
     */
    @OpenAPI.extension("x-ms-identifiers", #["virtualPath"])
    files?: NginxConfigurationFile[];

    /**
     * List of protected file requests for analysis.
     */
    @OpenAPI.extension("x-ms-identifiers", #["virtualPath"])
    protectedFiles?: NginxConfigurationProtectedFileRequest[];

    /**
     * Configuration package data for analysis.
     */
    package?: NginxConfigurationPackage;
  };
}

/**
 * Represents a diagnostic message from analysis.
 */
model AnalysisDiagnostic {
  /**
   * Unique identifier of the diagnostic.
   */
  id?: string;

  /**
   * Directive that triggered the diagnostic.
   */
  directive: string;

  /**
   * Description of the diagnostic.
   */
  description: string;

  /**
   * File in which the diagnostic occurred.
   */
  file: string;

  /**
   * Line number where the issue was found.
   */
  line: int32;

  /**
   * Detailed diagnostic message.
   */
  message: string;

  /**
   * Identifier of the rule violated.
   */
  rule: string;
}

/**
 * Detailed diagnostic item including severity.
 */
model DiagnosticItem {
  /**
   * Unique diagnostic identifier.
   */
  id?: string;

  /**
   * Directive text related to the diagnostic.
   */
  directive: string;

  /**
   * Human-readable description of the issue.
   */
  description: string;

  /**
   * File path associated with the diagnostic.
   */
  file: string;

  /**
   * Line number in the file.
   */
  line: int32;

  /**
   * Diagnostic message.
   */
  message: string;

  /**
   * Rule name that was violated.
   */
  rule: string;

  /**
   * Severity level of the diagnostic.
   */
  level: SeverityLevel;

  /**
   * Category of the diagnostic.
   */
  category?: string;
}

/** Severity Level of the analysis */
union SeverityLevel {
  /** Severity Level Info. */
  Info: "Info",

  /** Severity Level Warning. */
  Warning: "Warning",

  /** Custom identity type not covered by pre-defined values. */
  string,
}

/**
 * Result of configuration analysis.
 */
model AnalysisResult {
  /**
   * Overall status of the analysis process.
   */
  status: string;

  /**
   * Detailed analysis data, including errors and diagnostics.
   */
  data?: {
    /**
     * List of error diagnostics.
     */
    errors?: AnalysisDiagnostic[];

    /**
     * List of analysis diagnostic items.
     */
    diagnostics?: DiagnosticItem[];
  };
}

/**
 * Operations on Nginx configurations under a given deployment.
 */
@armResourceOperations
interface Configurations {
  /**
   * Retrieves the properties of a specific configuration.
   */
  get is ArmResourceRead<Configuration>;

  /**
   * Creates or updates a configuration.
   */
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
   * Analyzes a configuration.
   */
  @post
  @segment("analyze")
  @armResourceCollectionAction
  analyzeConfiguration(
    ...ResourceInstanceParameters<Configuration>,

    @doc("The analysis request body containing configuration details.")
    @bodyRoot
    resource: AnalysisCreate,
  ): ArmResponse<AnalysisResult>;
}
