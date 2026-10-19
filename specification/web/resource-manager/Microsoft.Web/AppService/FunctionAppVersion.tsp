import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

@added(Versions.v2026_10_01_preview)
@doc("The release lifecycle state of a Function App version.")
union FunctionAppVersionState {
  /** The version is being created and its artifact is being bound. */
  Creating: "Creating",

  /** The uploaded ZIP artifact is being remotely built. */
  Building: "Building",

  /** The bound artifact is being validated, including container image resolution. */
  Validating: "Validating",

  /** The version is ready to receive traffic. */
  Ready: "Ready",

  /** Materialization or validation failed. */
  Failed: "Failed",

  string,
}

@added(Versions.v2026_10_01_preview)
@doc("The status of a Function App version or label operation.")
union FunctionAppOperationStatus {
  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation succeeded. Validation readiness is reported on the version. */
  Succeeded: "Succeeded",

  /** The operation failed. */
  Failed: "Failed",

  string,
}

@added(Versions.v2026_10_01_preview)
@doc("The status of a Function App version or label operation.")
model FunctionAppOperationResult {
  /** The operation status, independent of version validation readiness. */
  @Azure.Core.lroStatus
  status: FunctionAppOperationStatus;

  /** Safe details of an operation failure, not a completed negative validation outcome. */
  @Azure.Core.lroErrorResult
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

@added(Versions.v2026_10_01_preview)
@armResourceOperations
@tag("FunctionAppOperationResults")
@doc("Operation status reads for Function App versions and labels.")
interface FunctionAppOperationResults {
  /** Gets the status of a Function App version or label operation. */
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "This site-scoped status monitor returns a top-level operation status, not an ARM resource envelope."
  @autoRoute
  @get
  get(
    ...ResourceInstanceParameters<Site>,

    /** The operation identifier returned in Azure-AsyncOperation. */
    @path
    @segment("functionAppOperationResults")
    operationId: string,
  ):
    | FunctionAppOperationResult
    | Azure.ResourceManager.CommonTypes.ErrorResponse;
}

@added(Versions.v2026_10_01_preview)
@doc("The artifact type of a Function App version.")
union FunctionAppVersionArtifactType {
  /** A previously uploaded ZIP artifact. */
  zipPackage: "zipPackage",

  /** A container image reference. */
  containerImage: "containerImage",

  string,
}

@added(Versions.v2026_10_01_preview)
@doc("The application artifact used by a Function App version.")
@discriminator("type")
model FunctionAppVersionArtifact {
  /** The artifact type. */
  type: FunctionAppVersionArtifactType;
}

@added(Versions.v2026_10_01_preview)
@doc("A reusable ZIP artifact previously uploaded through the SCM artifact API.")
model FunctionAppVersionZipPackageArtifact extends FunctionAppVersionArtifact {
  /** The artifact type. */
  type: "zipPackage";

  /** The service-generated artifact identifier, scoped to this Function App incarnation. */
  artifactId: string;

  /** Whether to remotely build the source ZIP before binding and validating the version. */
  remoteBuild?: boolean = false;
}

@added(Versions.v2026_10_01_preview)
@doc("A container image resolved to an immutable manifest digest during version creation.")
model FunctionAppVersionContainerImageArtifact
  extends FunctionAppVersionArtifact {
  /** The artifact type. */
  type: "containerImage";

  /** The container image reference to resolve during creation. */
  reference: string;
}

@added(Versions.v2026_10_01_preview)
@doc("The deployment configuration of a Function App version.")
model FunctionAppVersionDeployment {
  /** The application artifact. */
  appArtifact: FunctionAppVersionArtifact;
}

@added(Versions.v2026_10_01_preview)
@doc("The immutable customer-authored configuration of a Function App version.")
model FunctionAppVersionConfig {
  /** The deployment configuration. */
  deployment: FunctionAppVersionDeployment;

  /**
   * Immutable application-setting overrides over the current Function App defaults.
   * Keys are case-insensitive; null values and duplicate names differing only by
   * case are rejected. Values are omitted from normal read and list operations.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Application settings are an open name-value dictionary by design."
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  appSettings?: Record<string>;
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
@tag("FunctionAppVersions")
@armResourceOperations
@doc("Operations for Function App versions.")
interface FunctionAppVersions {
  /** Gets a Function App version. */
  get is ArmResourceRead<FunctionAppVersion>;

  /**
   * Creates an immutable Function App version without changing production.
   * Completion waits for artifact binding and a durable validation outcome.
   * A completed negative validation outcome succeeds the operation but leaves
   * versionState Failed; binding or platform failures fail the operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The version-creation contract returns 202 with an empty body and a site-scoped status monitor, followed by GET of the final resource."
  @Azure.Core.pollingOperation(FunctionAppOperationResults.get)
  @Azure.Core.finalOperation(FunctionAppVersions.get)
  @Azure.Core.useFinalStateVia("location")
  create is ArmResourceCreateOrReplaceAsync<
    FunctionAppVersion,
    Response =
      | ArmResponse<FunctionAppVersion>
      | ArmAcceptedLroResponse<
          "Version creation accepted.",
          ArmCombinedLroHeaders<
            FunctionAppOperationResult,
            FunctionAppVersion,
            string
          > &
            Azure.Core.Foundations.RetryAfterHeader
        >
  >;

  /** Lists Function App versions for a site. */
  listBySite is ArmResourceListByParent<
    FunctionAppVersion,
    Response = ArmResponse<ResourceListResult<FunctionAppVersion>>
  >;

  /** Deletes an eligible inactive Function App version. */
  delete is ArmResourceDeleteSync<FunctionAppVersion>;

  /** Lists only the immutable version-owned application-setting overrides, not effective settings. */
  @action("listAppSettings")
  listAppSettings is ArmResourceActionSync<
    FunctionAppVersion,
    void,
    ArmResponse<StringDictionary>,
    OptionalRequestBody = true
  >;

  /**
   * Retries listener-free validation of an inactive Failed version with a bound
   * artifact and no serving reference or conflicting operation. Reuses the bound
   * artifact without rebuilding or resolving the original source again.
   * A completed negative validation outcome returns a Failed version, not an
   * operation error.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Validation retries accept an optional empty JSON object and introduce no request fields."
  @action("validate")
  @Azure.Core.pollingOperation(FunctionAppOperationResults.get)
  @Azure.Core.finalOperation(FunctionAppVersions.get)
  @Azure.Core.useFinalStateVia("location")
  validate is ArmResourceActionAsync<
    FunctionAppVersion,
    {},
    ArmResponse<FunctionAppVersion>,
    LroHeaders = ArmCombinedLroHeaders<
      FunctionAppOperationResult,
      FunctionAppVersion,
      string
    > &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;
}
