import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

@added(Versions.v2026_10_01_preview)
@doc("The release lifecycle state of a Function App version.")
union FunctionAppVersionState {
  /** The ZIP version has been created and is awaiting a package. */
  AwaitingPackage: "AwaitingPackage",

  /** A package is being uploaded for the ZIP version. */
  Uploading: "Uploading",

  /** A package is being built for the ZIP version. */
  Building: "Building",

  /** The container image reference is being resolved. */
  ResolvingArtifact: "ResolvingArtifact",

  /** The version is being validated. */
  Validating: "Validating",

  /** The version is ready to receive traffic. */
  Ready: "Ready",

  /** Materialization or validation failed. */
  Failed: "Failed",

  string,
}

@added(Versions.v2026_10_01_preview)
@doc("The status of a Function App version validation attempt.")
union FunctionAppVersionValidationStatus {
  /** Validation is running. */
  Running: "Running",

  /** Validation succeeded. */
  Succeeded: "Succeeded",

  /** Validation failed. */
  Failed: "Failed",

  string,
}

@added(Versions.v2026_10_01_preview)
@doc("The runtime configuration of a Function App version.")
model FunctionAppVersionRuntime {
  /** The runtime name. */
  name: string;

  /** The runtime version. */
  version?: string;
}

@added(Versions.v2026_10_01_preview)
@doc("The Function App version artifact type.")
union FunctionAppVersionArtifactType {
  /** A ZIP package artifact. */
  ZipPackage: "zipPackage",

  /** A container image artifact. */
  ContainerImage: "containerImage",

  string,
}

@added(Versions.v2026_10_01_preview)
@doc("The artifact used by a Function App version.")
@discriminator("type")
model FunctionAppVersionArtifact {
  /** The artifact type. */
  type: FunctionAppVersionArtifactType;
}

@added(Versions.v2026_10_01_preview)
@doc("A ZIP package artifact.")
model ZipPackageAppArtifact extends FunctionAppVersionArtifact {
  /** The artifact type. */
  type: "zipPackage";
}

@added(Versions.v2026_10_01_preview)
@doc("A container image artifact.")
model ContainerImageAppArtifact extends FunctionAppVersionArtifact {
  /** The artifact type. */
  type: "containerImage";

  /** The container image reference. */
  reference: string;
}

@added(Versions.v2026_10_01_preview)
@doc("The deployment configuration of a Function App version.")
model FunctionAppVersionDeployment {
  /** The application artifact. */
  appArtifact: FunctionAppVersionArtifact;

  /**
   * The URI from which to materialize a ZIP package. This value is treated as a
   * secret and is never returned by read or list operations.
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  packageUri?: url;

  /** Whether to perform a remote build while materializing the ZIP package. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  remoteBuild?: boolean;
}

@added(Versions.v2026_10_01_preview)
@doc("The immutable customer-authored configuration of a Function App version.")
model FunctionAppVersionConfig {
  /** The runtime configuration. */
  runtime: FunctionAppVersionRuntime;

  /** The deployment configuration. */
  deployment: FunctionAppVersionDeployment;

  /**
   * The complete version-scoped application settings. Values are omitted from
   * normal read and list operations.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Application settings are an open name-value dictionary by design."
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  appSettings: Record<string>;
}

@added(Versions.v2026_10_01_preview)
@doc("Safe details about a Function App version validation failure.")
model FunctionAppVersionValidationDetail {
  /** A stable validation failure code. */
  code: string;

  /** A safe validation failure message that does not contain secrets. */
  message: string;

  /** The function or configuration field associated with the failure. */
  target?: string;
}

@added(Versions.v2026_10_01_preview)
@doc("Metadata for the latest Function App version validation attempt.")
model FunctionAppVersionValidationAttempt {
  /** The validation attempt status. */
  status: FunctionAppVersionValidationStatus;

  /** The time at which validation started. */
  startedAt: utcDateTime;

  /** The time at which terminal validation completed. */
  completedAt?: utcDateTime;
}

@added(Versions.v2026_10_01_preview)
@doc("The properties of a Function App version.")
model FunctionAppVersionProperties {
  /** The status of the resource provisioning operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /** The release lifecycle state of the version. */
  @visibility(Lifecycle.Read)
  versionState?: FunctionAppVersionState;

  /** The immutable customer-authored version configuration. */
  functionAppVersionConfig: FunctionAppVersionConfig;

  /** Safe details for the latest failed validation attempt. */
  @visibility(Lifecycle.Read)
  validationDetail?: FunctionAppVersionValidationDetail;

  /** Metadata for the latest validation attempt. */
  @visibility(Lifecycle.Read)
  validationAttempt?: FunctionAppVersionValidationAttempt;
}

@added(Versions.v2026_10_01_preview)
@parentResource(Site)
@doc("An immutable Function App version resource.")
model FunctionAppVersion
  is Azure.ResourceManager.ProxyResource<FunctionAppVersionProperties> {
  ...ResourceNameParameter<
    Resource = FunctionAppVersion,
    KeyName = "versionName",
    SegmentName = "functionAppVersions",
    NamePattern = "^[a-z0-9](?:[a-z0-9._-]{0,62}[a-z0-9])?$"
  >;
}

@added(Versions.v2026_10_01_preview)
@doc("Version-scoped application settings.")
model FunctionAppVersionAppSettings {
  /** The version-scoped application settings. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Application settings are an open name-value dictionary by design."
  @secret
  properties: Record<string>;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "This protocol-only model represents the accepted HTTP response and is not emitted as a body model."
@added(Versions.v2026_10_01_preview)
@doc("The accepted response for a Function App version validation operation.")
model FunctionAppVersionValidateAcceptedResponse {
  /** The HTTP status code. */
  @statusCode statusCode: 202;

  ...ArmAsyncOperationHeader<FinalResult = FunctionAppVersion>;
  ...Azure.Core.Foundations.RetryAfterHeader;

  /** The Function App version while validation is running. */
  @body body: FunctionAppVersion;
}

@added(Versions.v2026_10_01_preview)
@tag("FunctionAppVersions")
@armResourceOperations
@doc("Operations for Function App versions.")
interface FunctionAppVersions {
  /** Gets a Function App version. */
  get is ArmResourceRead<FunctionAppVersion, Error = DefaultErrorResponse>;

  /** Creates an immutable Function App version or returns an equivalent version. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The immutable create contract intentionally returns 200 for an idempotent retry, 201 for a ZIP placeholder, and 202 for materialization and validation."
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "The create LRO uses Azure-AsyncOperation as the authoritative ARM status monitor."
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FunctionAppVersion,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = FunctionAppVersion> &
      Azure.Core.Foundations.RetryAfterHeader,
    Response =
      | ArmResourceUpdatedResponse<FunctionAppVersion>
      | ArmResourceCreatedSyncResponse<FunctionAppVersion>
      | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = FunctionAppVersion> &
          Azure.Core.Foundations.RetryAfterHeader>,
    Error = DefaultErrorResponse
  >;

  /** Lists Function App versions for a site. */
  listBySite is ArmResourceListByParent<
    FunctionAppVersion,
    Response = ArmResponse<ResourceListResult<FunctionAppVersion>>,
    Error = DefaultErrorResponse
  >;

  /** Deletes an eligible inactive Function App version. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Deleting an eligible Function App version completes with 204 and has no success response body."
  delete is ArmResourceDeleteSync<
    FunctionAppVersion,
    Response = ArmDeletedNoContentResponse,
    Error = DefaultErrorResponse
  >;

  /** Lists the application settings of a Function App version. */
  @action("config/appsettings/list")
  listAppSettings is ArmResourceActionSync<
    FunctionAppVersion,
    void,
    ArmResponse<FunctionAppVersionAppSettings>,
    Error = DefaultErrorResponse,
    OptionalRequestBody = true
  >;

  /** Retries validation of an inactive failed Function App version. */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "The design explicitly requires Azure-AsyncOperation and Retry-After without Location."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The design explicitly requires the accepted Function App version in the 202 response body."
  @action("validate")
  validate is ArmResourceActionAsyncBase<
    FunctionAppVersion,
    void,
    FunctionAppVersionValidateAcceptedResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<FunctionAppVersion>,
    Error = DefaultErrorResponse,
    OptionalRequestBody = true
  >;
}
