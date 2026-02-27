import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "IndexManagementClient" })
@doc("CognitiveSearch Resource Provider management API.")
namespace Microsoft.CognitiveSearch;

@armResourceOperations
interface OperationExtensions {
  @autoRoute
  @armResourceAction(TResource)
  @post
  @doc("List resource")
  ArmResourceActionNoRequestBodySync<
    TResource extends Azure.ResourceManager.Foundations.Resource,
    TResponse extends {}
  >(
    ...ResourceInstanceParameters<
      TResource,
      Azure.ResourceManager.Foundations.BaseParameters<TResource>
    >,
  ): ArmResponse<TResponse> | ErrorResponse;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface IndexOperations {
  listByResourceGroup is ArmResourceListByParent<Index>;

  listBySubscription is ArmListBySubscription<Index>;

  get is ArmResourceRead<Index>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<Index>;

  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    Index,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Index,
      IndexProperties
    >
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "legacy"
  #suppress "deprecated" "legacy"
  delete is ArmResourceDeleteAsync<Index>;

  @doc("List ApiKeys used to access the dataplane.")
  listKeys is OperationExtensions.ArmResourceActionNoRequestBodySync<
    Index,
    IndexKeys
  >;

  @doc("Regenerates an ApiKey.")
  regenerateKey is ArmResourceActionSync<
    Index,
    RegenerateKeyParameters,
    IndexKeys
  >;
}

@doc("An index resource")
model Index is TrackedResource<IndexProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "legacy"
  @path
  @key("name")
  @segment("indexes")
  @visibility(Lifecycle.Read)
  @doc("The name of the index resource.")
  name: string;
}

@doc("The properties of the index.")
model IndexProperties {
  @visibility(Lifecycle.Read)
  @doc("The current provisioning state of the index.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The endpoint at which the index can be accessed.")
  endpoint?: string;

  @doc("The capacity allocated to the index for querying.")
  queryCapacity: Capacity;

  @doc("The capacity allocated to the index for indexing documents.")
  indexingCapacity: Capacity;

  @doc("Authentication option to be used when accessing the dataplane")
  authOption?: AuthOption;
}

@doc("The capacity will autoscale between the minimum and maximum number of vCores based on the usage of your index.")
model Capacity {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Name is in camel case."
  @doc("The minimum number of vCores that the index will consume. Represented with discrete values: 1, 2, 3, … to 16.")
  minVCores: float32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Name is in camel case."
  @doc("The maximum number of vCores that the index can consume. Represented with discrete values: 1, 2, 3, … to 16.")
  maxVCores: float32;

  @doc("Pausing strategy for the index")
  autoPause: Pause;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "legacy"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Legacy"
@discriminator("type")
@doc("Pausing strategy for the index")
model Pause {}

@doc("When the pause strategy is set to 'Delay', the index will enter a paused state after not being used for a fixed amount of time.")
model DelayPause extends Pause {
  @doc("Specifies the type of pausing strategy as 'Delay'.")
  type: "Delay";

  @doc("The interval after which an index is paused if not in use.")
  duration: duration;
}

@doc("When the pause strategy is set to 'None', the index will remain always active.")
model NonePause extends Pause {
  @doc("Specifies the type of pausing strategy as 'None'.")
  type: "None";
}

@doc("The list of all ApiKeys used to access the dataplane.")
model IndexKeys {
  @doc("Primary read-write ApiKey.")
  @secret
  primaryReadWriteKey: string;

  @doc("Secondary read-write ApiKey.")
  @secret
  secondaryReadWriteKey: string;

  @doc("Primary read-only ApiKey.")
  @secret
  primaryReadOnlyKey: string;

  @doc("Secondary read-only ApiKey.")
  @secret
  secondaryReadOnlyKey: string;
}

@doc("Regenerates a specific kind of ApiKey.")
model RegenerateKeyParameters {
  @doc("The kind of ApiKey to regenerate.")
  keyKind: KeyKind;
}

@lroStatus
@doc("Provisioning state of the index resource.")
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Index is provisioning.")
  Provisioning: "Provisioning",

  @doc("Index is deleting.")
  Deleting: "Deleting",

  @doc("Index is accepted.")
  Accepted: "Accepted",
}

@doc("Authentication options for accessing the dataplane.")
union AuthOption {
  string,

  @doc("Azure Active Directory authentication option.")
  AadOnly: "AadOnly",

  @doc("Azure Active Directory and ApiKeys authentication option.")
  AadAndApiKeys: "AadAndApiKeys",
}

@doc("ApiKeys used to access the dataplane.")
union KeyKind {
  string,

  @doc("Primary read-write ApiKey.")
  PrimaryReadWriteKey: "PrimaryReadWriteKey",

  @doc("Secondary read-write ApiKey.")
  SecondaryReadWriteKey: "SecondaryReadWriteKey",

  @doc("Primary read-only ApiKey.")
  PrimaryReadOnlyKey: "PrimaryReadOnlyKey",

  @doc("Secondary read-only ApiKey.")
  SecondaryReadOnlyKey: "SecondaryReadOnlyKey",
}
