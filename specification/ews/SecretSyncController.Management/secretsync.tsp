import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.SecretSyncController")
namespace Microsoft.SecretSyncController;

@doc("The SecretSync resource.")
model SecretSync is TrackedResource<SecretSyncProperties> {
  ...ResourceNameParameter<
    SecretSync,
    NamePattern = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
  >;
  ...ExtendedLocationProperty;
}

@@maxLength(SecretSync.name, 253);

@doc("The properties of the SecretSync instance.")
model SecretSyncProperties {
  @doc("SecretProviderClassName specifies the name of the SecretProviderClass resource, which contains the information needed to access the cloud provider secret store.")
  @minLength(1)
  @maxLength(253)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  secretProviderClassName: string;

  @doc("ServiceAccountName specifies the name of the service account used to access the cloud provider secret store. The audience field in the service account token must be passed as parameter in the controller configuration. The audience is used when requesting a token from the API server for the service account; the supported audiences are defined by each provider.")
  @minLength(1)
  @maxLength(253)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  serviceAccountName: string;

  @doc("Type specifies the type of the Kubernetes secret object, e.g. \"Opaque\" or\"kubernetes.io/tls\". The controller must have permission to create secrets of the specified type.")
  kubernetesSecretType: KubernetesSecretType;

  @doc("ForceSynchronization can be used to force the secret synchronization. The secret synchronization is triggered by changing the value in this field. This field is not used to resolve synchronization conflicts.")
  @pattern("^[A-Za-z0-9]([-A-Za-z0-9]+([-._a-zA-Z0-9]?[A-Za-z0-9])*)?")
  @maxLength(253)
  forceSynchronization?: string;

  @doc("An array of SecretObjectData that maps secret data from the external secret provider to the Kubernetes secret. Each entry specifies the source secret in the external provider and the corresponding key in the Kubernetes secret.")
  @minItems(1)
  @identifiers(#[])
  objectSecretMapping: KubernetesSecretObjectMapping[];

  @visibility(Lifecycle.Read)
  @doc("SecretSyncStatus defines the observed state of the secret synchronization process.")
  status?: SecretSyncStatus;

  @doc("Provisioning state of the SecretSync instance.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties defining the mapping between a cloud secret store object and a Kubernetes Secret.")
model KubernetesSecretObjectMapping {
  @doc("SourcePath is the identifier for the secret data as defined by the external secret provider. This is the key or path to the secret in the provider's system, which gets mounted to a specific path in the pod. The value should match the name of the secret as specified in the SecretProviderClass's objects array.")
  @minLength(1)
  @maxLength(253)
  @pattern("^[A-Za-z0-9.]([-A-Za-z0-9]+([-._a-zA-Z0-9]?[A-Za-z0-9])*)?(\\/([0-9]+))*$")
  sourcePath: string;

  @doc("TargetKey is the key in the Kubernetes secret's data field where the secret value will be stored. This key is used to reference the secret data within Kubernetes, and it should be unique within the secret.")
  @minLength(1)
  @maxLength(253)
  @pattern("^[A-Za-z0-9.]([-A-Za-z0-9]+([-._a-zA-Z0-9]?[A-Za-z0-9])*)?(\\/([0-9]+))*$")
  targetKey: string;
}

// https://kubernetes.io/docs/concepts/configuration/secret/#secret-types
// Defined as an extensible union rather than an enum for compliance with rule https://azure.github.io/typespec-azure/docs/next/libraries/azure-core/rules/no-enum
@doc("Supported Kubernetes secret types.")
union KubernetesSecretType {
  // https://kubernetes.io/docs/concepts/configuration/secret/#opaque-secrets
  @doc("Opaque is the default secret type.")
  Opaque: "Opaque",

  // https://kubernetes.io/docs/concepts/configuration/secret/#tls-secrets
  @doc("The kubernetes.io/tls secret type is for storing a certificate and its associated key that are typically used for TLS.")
  Tls: "kubernetes.io/tls",

  // extensible union
  string,
}

@doc("Status conditions types")
union StatusConditionType {
  @doc("The status is true")
  True: "True",

  @doc("The status is false")
  False: "False",

  @doc("The status is unknown")
  Unknown: "Unknown",

  string,
}

@doc("SecretSyncStatus defines the observed state of the secret synchronization process.")
model SecretSyncStatus {
  @doc("LastSuccessfulSyncTime represents the last time the secret was retrieved from the Provider and updated.")
  @visibility(Lifecycle.Read)
  lastSuccessfulSyncTime?: utcDateTime;

  @identifiers(#[])
  @doc("Conditions represent the status of the secret create and update processes. The status can be True, False, or Unknown with various reasons and messages explaining the state. Examples of reasons include CreateSucceeded, ProviderError, InvalidClusterSecretLabelError, InvalidClusterSecretAnnotationError, UnknownError, ValidatingAdmissionPolicyCheckFailed, UserInputValidationFailed, ControllerSpcError, ControllerInternalError, NoValueChange, and ValueChangeOrForceUpdateDetected.")
  @visibility(Lifecycle.Read)
  conditions?: SecretSyncCondition[];

  // Not including syncHash at the moment for security concerns TODO #28507544 https://msazure.visualstudio.com/One/_workitems/edit/28507544
}

@doc("A condition represents the status of the secret create and update processes.")
model SecretSyncCondition {
  @doc("LastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed. If that is not known, then using the time when the API field changed is acceptable.")
  @visibility(Lifecycle.Read)
  lastTransitionTime?: utcDateTime;

  @doc("Message is a human readable message indicating details about the transition. This may be an empty string.")
  @visibility(Lifecycle.Read)
  message: string;

  @doc("ObservedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance.")
  @visibility(Lifecycle.Read)
  observedGeneration?: int64;

  @doc("Reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty.")
  @visibility(Lifecycle.Read)
  @minLength(1)
  @maxLength(1024)
  @pattern("^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$")
  reason: string;

  @doc("Status of the condition, one of True, False, Unknown.")
  @visibility(Lifecycle.Read)
  status: StatusConditionType;

  @doc("Type of condition in CamelCase or in foo.example.com/CamelCase. Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to de-conflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)")
  @visibility(Lifecycle.Read)
  @maxLength(316)
  @pattern("^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$")
  type: string;
}

@armResourceOperations
interface SecretSyncs {
  @doc("Gets the properties of a SecretSync instance.")
  get is ArmResourceRead<SecretSync>;

  @doc("Creates new or updates a SecretSync instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SecretSync>;

  @doc("Updates a SecretSync instance.")
  update is ArmCustomPatchAsync<
    SecretSync,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      SecretSync,
      SecretSyncProperties
    >
  >;

  @doc("Deletes a SecretSync instance.")
  delete is ArmResourceDeleteWithoutOkAsync<SecretSync>;

  @doc("Lists the SecretSync instances within a resource group.")
  listByResourceGroup is ArmResourceListByParent<SecretSync>;

  @doc("Lists the SecretSync instances within an Azure subscription.")
  listBySubscription is ArmListBySubscription<SecretSync>;
}
