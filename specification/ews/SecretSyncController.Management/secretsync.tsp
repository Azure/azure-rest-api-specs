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
  ...ResourceNameParameter<SecretSync>;
  ...ExtendedLocationProperty;
}

@doc("The properties of the SecretSync instance.")
model SecretSyncProperties {
  // Add patterns TODO 28520548 https://msazure.visualstudio.com/One/_workitems/edit/28520548
  @doc("The name of the matching secret provider class instance.")
  @minLength(1)
  @maxLength(253)
  secretProviderClassName: string;

  @doc("The name of the Kubernetes service account used to access the cloud secret store.")
  @minLength(1)
  @maxLength(253)
  serviceAccountName: string;

  @doc("The type of Kubernetes secret to store the cloud secret store data as.")
  kubernetesSecretType: KubernetesSecretType;

  @doc("The ForceSynchronization field can be used to force a secret to synchronize. By changing the value in this field, a synchronization operation is triggered for this SecretSync instance.")
  @pattern("^[A-Za-z0-9]([-A-Za-z0-9]+([-._a-zA-Z0-9]?[A-Za-z0-9])*)?")
  @maxLength(253)
  forceSynchronization?: string;

  @doc("List of mappings between objects in the cloud secret store and corresponding Kubernetes secrets.")
  @OpenAPI.extension("x-ms-identifiers", [])
  objectSecretMapping: KubernetesSecretObjectMapping[];

  @visibility("read")
  @doc("The status object contains the state of the secret synchronization process for this SecretSync instance.")
  status?: SecretSyncStatus;

  @doc("Provisioning state of the SecretSync instance.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Properties defining the mapping between a cloud secret store object and a Kubernetes Secret.")
model KubernetesSecretObjectMapping {
  // Doc needs work + add patterns - TODO #28520313 https://msazure.visualstudio.com/One/_workitems/edit/28520313
  @doc("sourcePath is the data source value of the secret defined in the Secret Provider Class. This matches the path of a file in the MountResponse returned from the provider.")
  @minLength(1)
  @maxLength(253)
  sourcePath: string;

  @doc("targetPath is the key in the Kubernetes secret's data field as described in the Kubernetes API reference: https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/secret-v1/")
  @minLength(1)
  @maxLength(253)
  targetPath: string;
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

@doc("SecretSyncStatus defines the observed state of the secret synchronization process.")
model SecretSyncStatus {
  // Needs better doc TODO #28507605 https://msazure.visualstudio.com/One/_workitems/edit/28507605
  @doc("LastSuccessfulSyncTime represents the last time the secret was retrieved from the Provider and updated.")
  lastSuccessfulSyncTime?: utcDateTime;

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("Condition contains details for one aspect of the current state of this API Resource")
  conditions?: SecretSyncCondition[];

  // Not including syncHash at the moment for security concerns TODO #28507544 https://msazure.visualstudio.com/One/_workitems/edit/28507544
}

// Needs better doc (and for fields) TODO #28507605 https://msazure.visualstudio.com/One/_workitems/edit/28507605
@doc("Condition contains details for one aspect of the current state of this SecretSync object.")
model SecretSyncCondition {
  @doc("lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed. If that is not known, then using the time when the API field changed is acceptable.")
  lastTransitionTime?: utcDateTime;

  @doc("message is a human readable message indicating details about the transition. This may be an empty string.")
  message: string;

  @doc("observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance.")
  observedGeneration?: int32;

  @doc("reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty.")
  reason: string;

  @doc("status of the condition, one of True, False, Unknown.")
  status: string;

  @doc("type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to de-conflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)")
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
