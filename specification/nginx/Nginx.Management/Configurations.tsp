import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using Azure.ResourceManager;

namespace NGINX.NGINXPLUS;

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
   * File content in Nginx configuration format, base64 encoded.
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
model NginxConfigurationProtectedFileContent {
  /**
   * File content in Nginx configuration format, UTF-8 encoded.
   */
  content?: string;

  /**
   * Virtual path of the file.
   */
  virtualPath?: string;

  /**
   * Content hash of the file using SHA-256 algorithm.
   */
  contentHash?: string;
}

/**
 * Response model for a protected configuration file.
 */
model NginxConfigurationProtectedFileResult {
  /**
   * Virtual path of the file.
   */
  virtualPath?: string;

  /**
   * Content hash of the file using SHA-256 algorithm.
   */
  contentHash?: string;
}

/**
 * Represents a configuration package.
 */
model NginxConfigurationPackage {
  /**
   * Package data. This is base64 encoded content of the files archive.
   */
  data?: string;

  /**
   * List of protected files in the package.
   * These are standard file paths relative to the archive uploaded
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
  protectedFiles?: NginxConfigurationProtectedFileResult[];

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
  protectedFiles?: NginxConfigurationProtectedFileContent[];

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
 * The request body for creating an analysis for an NGINX configuration.
 */
@doc("The request body for creating an analysis for an NGINX configuration.")
model AnalysisCreate {
  /**
   * Configuration details for analysis.
   */
  config: AnalysisConfig;
}

/**
 * Configuration details for analysis.
 */
model AnalysisConfig {
  /**
   * The root file of the NGINX config file(s). It must match one of the files' filepath.
   */
  rootFile?: string;

  /**
   * List of configuration files.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  files?: NginxConfigurationFile[];

  /**
   * List of protected files.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  protectedFiles?: NginxConfigurationProtectedFileContent[];

  /**
   * Configuration package details.
   */
  package?: NginxConfigurationPackage;
}

/**
 * The response body for an analysis request. Contains the status of the analysis and any errors.
 */
model AnalysisResult {
  /**
   * The status of the analysis.
   */
  status: string;

  /**
   * Analysis result data.
   */
  data?: AnalysisResultContent;
}

/**
 * Analysis result data containing errors and diagnostics.
 */
model AnalysisResultContent {
  /**
   * List of errors found during analysis.
   */
  errors?: AnalysisDiagnostic[];

  /**
   * List of diagnostics found during analysis.
   */
  diagnostics?: DiagnosticItem[];
}

/**
 * An error object found during the analysis of an NGINX configuration.
 */
model AnalysisDiagnostic {
  /**
   * Unique identifier for the error.
   */
  id?: string;

  /**
   * The directive being analyzed.
   */
  directive: string;

  /**
   * Description of the error.
   */
  description: string;

  /**
   * The filepath of the most relevant config file.
   */
  file: string;

  /**
   * Line number where the error was found.
   */
  line: int64;

  /**
   * Error message.
   */
  message: string;

  /**
   * Rule that triggered the error.
   */
  rule: string;
}

/**
 * A diagnostic is a message associated with an NGINX config. The Analyzer returns diagnostics with a level indicating the importance of the diagnostic with optional category.
 */
model DiagnosticItem {
  /**
   * Unique identifier for the diagnostic error type. Generated by the analyzer as a free form text.
   */
  id?: string;

  /**
   * The directive being analyzed. This is a free form text that can be used to identify the directive.
   */
  directive: string;

  /**
   * Description of the diagnostic.
   */
  description: string;

  /**
   * The filepath of the most relevant config file.
   */
  file: string;

  /**
   * Line number where the diagnostic was found.
   */
  line: int64;

  /**
   * Diagnostic message.
   */
  message: string;

  /**
   * Rule that triggered the diagnostic. Rule names can be any free form text that can be used to identify.
   */
  rule: string;

  /**
   * Warning or Info.
   */
  level: DiagnosticLevel;

  /**
   * Category of warning like Best-practices, Recommendation, Security etc. Can be any free form text.
   */
  category?: string;
}

/**
 * Diagnostic level indicating the importance of the diagnostic.
 */
union DiagnosticLevel {
  /** Information level diagnostic. */
  Info: "Info",

  /** Warning level diagnostic. */
  Warning: "Warning",

  /** Other diagnostic levels not covered by pre-defined values. */
  string,
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "The request and response models are different by design"
  @put
  @armResourceCreateOrUpdate(Configuration)
  createOrUpdate(
    ...ResourceInstanceParameters<Configuration>,

    /**
     * The configuration resource to create or update.
     */
    @bodyRoot resource: NginxConfigurationRequest,
  ): ArmResponse<Configuration> | ArmCreatedResponse<Configuration> | ErrorResponse;

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
  @armResourceAction(Configuration)
  @post
  @action("analyze")
  analyze is ArmResourceActionSync<
    Configuration,
    AnalysisCreate,
    AnalysisResult | ErrorResponse
  >;
}
