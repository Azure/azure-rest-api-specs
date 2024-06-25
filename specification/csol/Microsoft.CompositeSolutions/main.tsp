import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft.CompositeSolutions",
})
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@versioned(Versions)
namespace Microsoft.CompositeSolutions;

@doc("Supported API versions for the Microsoft.CompositeSolutions resource provider.")
enum Versions {
  @doc("The 2024-03-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_03_01_preview: "2024-03-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A CompositeSolutionProviderHub resource")
model CompositeSolutionDefinition
  is TrackedResource<CompositeSolutionDefinitionProperties> {
  @doc("The name of the composite solution definition")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("compositeSolutionDefinition")
  @segment("compositeSolutionDefinitions")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A CompositeSolutionProviderHub resource")
model CompositeSolution is TrackedResource<CompositeSolutionProperties> {
  @doc("The name of the composite solution")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("compositeSolutionName")
  @segment("compositeSolutions")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  /** Resource has been created. */
  Succeeded: "Succeeded",

  /** Resource creation failed. */
  Failed: "Failed",

  /** Resource creation was canceled. */
  Canceled: "Canceled",

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

@doc("Details of the CompositeSolutionDefinition.")
model CompositeSolutionDefinitionProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read", "create", "update")
  @doc("Bundle Profile.")
  bundleProfile: BundleProfile;

  @visibility("read")
  @doc("Parameters for the composite solution")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  parameters?: Array<Parameter>;

  @visibility("read")
  @doc("Credentials for the composite solution")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  credentials?: Array<Credential>;

  @visibility("read")
  @doc("List of mixins used in the composite solution package")
  mixins?: Array<string>;
}

@doc("Metadata associated with the bundle")
model CrpMetadata {
  @doc("Schema version of the metadata")
  schema: string;

  @doc("Name of the metadata")
  mixin: string;
}

@doc("Details of the CompositeSolution.")
model CompositeSolutionProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read", "create", "update")
  @doc("compositeSolutionDefinition resource identifier indicating which solution to deploy")
  compositeSolutionDefinitionId: string;

  @visibility("read", "create", "update")
  @doc("Bundle Parameters.")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  parameters: Array<ParameterValue>;

  // This isn't actually a secret, but a reference to a secret in AKV, so is it safe to return back in the read request?
  @visibility("read", "create", "update")
  @doc("Array of secret")
  @OpenAPI.extension("x-ms-identifiers", ["credentialName"])
  credentials?: Array<KeyVaultSecretReference>;

  // TODO: Do we need this?
  @visibility("read")
  @doc("Bundle Outputs.")
  outputs?: Array<string>; // TODO: Array or Record?

  @visibility("read", "create", "update")
  @doc("Bundle Friendly Name.")
  friendlyName?: string;

  @visibility("read", "create", "update")
  @doc("Solution Center Offer ID.")
  saasOfferId?: string;
}

/** Path request body for CompositeSolutionProperties */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-properties-correspond-to-put-properties" "Existing Template"
model CompositeSolutionUpdate1 {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  identity?: ManagedServiceIdentityUpdate;

  /** RP-specific properties */
  properties?: CompositeSolutionPropertiesUpdate;
}

model CompositeSolutionPropertiesUpdate
  is OptionalProperties<UpdateableProperties<CompositeSolutionProperties>>;

/** Path request body for CompositeSolutionDefinitionProperties */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-properties-correspond-to-put-properties" "Existing Template"
model CompositeSolutionDefinitionUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  identity?: ManagedServiceIdentityUpdate;

  /** RP-specific properties */
  properties?: CompositeSolutionDefinitionPropertiesUpdate;
}

model CompositeSolutionDefinitionPropertiesUpdate
  is OptionalProperties<UpdateableProperties<CompositeSolutionDefinitionProperties>>;

model ManagedServiceIdentityUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.Foundations.ManagedServiceIdentity>>;

@doc("KeyVault Secret Reference")
model KeyVaultSecretReference {
  @doc("The secret name")
  credentialName: string;

  @doc("The secret name")
  secretName: string;
}

@doc("Paramter Value")
model ParameterValue {
  @doc("The parameter name")
  name: string;

  //TODO: "value is removed when generate Models because of a bug, but added back when generating openapi.json
  /** Value of the Parameter */
  value: {};
}

@doc("Parameter model")
model Parameter {
  @doc("Parameter name")
  name: string;

  @doc("Data type of the parameter (string, int, etc)")
  type?: string;

  @doc("Minimum value allowed (> than value specified).  Only applies to numerics.")
  exclusiveMinimum?: int64;

  @doc("Maximum value allowed (< than value specified). Only applies to numerics.")
  exclusiveMaximum?: int64;

  @doc("Whether the parameter is required or not")
  isRequired: boolean;

  @doc("Maximum value allowed (>= value specified). Only applies to numerics.")
  maximum?: int64;

  @doc("Minimum value allowed (<= value specified). Only applies to numerics.")
  minimum?: int64;

  @doc("Description of the parameter")
  description?: string;

  @doc("The maximum length of the parameter. Only applies to strings.")
  maxLength?: int64;

  @doc("The minimum length of the parameter. Only applies to strings.")
  minLength?: int64;

  @doc("Which operations this parameter applies to. If not specified, this parameter applies to all operations.")
  applicableOperations: Array<string>;

  @doc("Which Microsoft cloud(s) the parameter applies to")
  microsoftTargets: Array<string>;

  @doc("Whether the property is read only")
  readOnly: boolean;

  @doc("Display name of the parameter")
  displayName: string;

  @doc("The default value of the parameter")
  default?: {};

  @doc("Allowed values")
  @OpenAPI.extension("x-ms-identifiers", [])
  allowedValues?: Array<{}>;
}

@doc("Credential model")
model Credential {
  @doc("Credential name")
  name: string;

  @doc("Whether the credential is required or not")
  isRequired: boolean;

  @doc("Which operations this credential applies to. If not specified, this credential applies to all operations.")
  applicableOperations: Array<string>;

  @doc("Which Microsoft cloud(s) the parameter applies to")
  microsoftTargets: Array<string>;

  @doc("Description of the credential")
  description?: string;

  @doc("Display name of the parameter")
  displayName: string;
}

@doc("Detailed Status Response")
model DetailedStatusResponse {
  @doc("Array of responses")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["resourceId"])
  value: Array<MixinDetailedStatus>;
}

@doc("Mixin Detailed Status")
model MixinDetailedStatus {
  /** Resource Id */
  resourceId: string;

  /** Item Name */
  itemName: string;

  /** Execution Status */
  executionStatus: string;

  /** Date */
  dateTime: string;

  /** Mixin Name */
  mixinName: string;

  /** Whether is active */
  isActive: boolean;

  /** Correlation Id to flow across all components */
  correlationId: string;

  /** Porter installation name */
  installationName: string;

  /** Porter namespace '-n' */
  installationNameSpace: string;

  /** Porter Correlation Id */ //TODO: Confirm how compares to correlation id above
  porterCorrelationId: string;

  /** CNAB revision */
  cnabRevision: string;
}

@doc("The properties related to Bundle")
model BundleProfile {
  @doc("OCI repository of the current bundle")
  @visibility("read", "create")
  repository: string;

  @doc("OCI tag of the current bundle definition.")
  @visibility("read", "create", "update")
  tag?: string;
}

@armResourceOperations(CompositeSolution)
interface CompositeSolutions {
  get is ArmResourceRead<CompositeSolution>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CompositeSolution>;
  update is ArmCustomPatchSync<CompositeSolution, CompositeSolutionUpdate1>;
  delete is ArmResourceDeleteWithoutOkAsync<CompositeSolution>;
  listByResourceGroup is ArmResourceListByParent<CompositeSolution>;
  listBySubscription is ArmListBySubscription<CompositeSolution>;
  detailedStatus is ArmResourceActionAsync<
    CompositeSolution,
    void,
    DetailedStatusResponse
  >;
}

@armResourceOperations(CompositeSolutionDefinition)
interface CompositeSolutionDefinitions {
  get is ArmResourceRead<CompositeSolutionDefinition>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<CompositeSolutionDefinition>;
  update is ArmCustomPatchSync<
    CompositeSolutionDefinition,
    CompositeSolutionDefinitionUpdate
  >;
  delete is ArmResourceDeleteSync<CompositeSolutionDefinition>;
  listByResourceGroup is ArmResourceListByParent<CompositeSolutionDefinition>;
  listBySubscription is ArmListBySubscription<CompositeSolutionDefinition>;
}
