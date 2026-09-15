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
  /** The ZIP version has been created and is awaiting a package. */
  AwaitingPackage: "AwaitingPackage",

  /** A package is being uploaded for the ZIP version. */
  Uploading: "Uploading",

  /** A package is being built for the ZIP version. */
  Building: "Building",

  /** The version is being validated, including resolving a container image reference. */
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
@doc("The status of a Function App version operation.")
union FunctionAppVersionOperationStatus {
  /** The operation is running. */
  InProgress: "InProgress",

  /** The operation succeeded. */
  Succeeded: "Succeeded",

  /** The operation failed. */
  Failed: "Failed",

  /** The operation was canceled. */
  Canceled: "Canceled",

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
@tag("FunctionAppVersions")
@armResourceOperations
@doc("Operations for Function App versions.")
interface FunctionAppVersions {
  /** Gets a Function App version. */
  get is ArmResourceRead<FunctionAppVersion>;

  /** Creates an immutable Function App version or returns an equivalent version. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FunctionAppVersion,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = FunctionAppVersion> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Lists Function App versions for a site. */
  listBySite is ArmResourceListByParent<
    FunctionAppVersion,
    Response = ArmResponse<ResourceListResult<FunctionAppVersion>>
  >;

  /** Deletes an eligible inactive Function App version. */
  delete is ArmResourceDeleteSync<FunctionAppVersion>;

  /** Lists the application settings of a Function App version. */
  @action("listAppSettings")
  listAppSettings is ArmResourceActionSync<
    FunctionAppVersion,
    void,
    ArmResponse<StringDictionary>,
    OptionalRequestBody = true
  >;

  /** Retries validation of an inactive failed Function App version. */
  @action("validate")
  validate is ArmResourceActionAsync<
    FunctionAppVersion,
    void,
    FunctionAppVersion,
    LroHeaders = ArmCombinedLroHeaders<
      ArmOperationStatus<StatusValues = FunctionAppVersionOperationStatus>,
      FunctionAppVersion
    > &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;
}

@added(Versions.v2026_10_01_preview)
@tag("FunctionAppVersionOperations")
@armResourceOperations
@doc("Operations for tracking asynchronous Function App version work.")
interface FunctionAppVersionOperations {
  /** Gets the status of an asynchronous Function App version operation. */
  @autoRoute
  @get
  @armResourceCollectionAction
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "Matches the provider namespace behavior of GetResourceOperationStatus while using the ARM common operationId parameter."
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "Operation status is a provider collection action, not a resource lifecycle operation."
  @Azure.ResourceManager.Private.armUpdateProviderNamespace
  op get(
    ...DefaultBaseParameters<SubscriptionLocationActionScope>,
    ...ProviderNamespace<SubscriptionLocationActionScope>,
    ...SubscriptionLocationActionScope,
    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ):
    | ArmResponse<
        ArmOperationStatus<
          StatusValues = FunctionAppVersionOperationStatus
        >
      >
    | ErrorResponse;
}

@@segment(
  FunctionAppVersionOperations.get::parameters.operationId,
  "functionAppVersionOperations"
);
