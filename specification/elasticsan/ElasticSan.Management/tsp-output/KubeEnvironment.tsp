import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("A Kubernetes cluster specialized for web workloads by Azure App Service")
model KubeEnvironment is TrackedResource<KubeEnvironmentProperties> {
  @doc("Name of the Kubernetes Environment.")
  @path
  @key("name")
  @segment("kubeEnvironments")
  name: string;

  @doc("Extended Location.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface KubeEnvironments {
  @doc("Description for Get the properties of a Kubernetes Environment.")
  get is ArmResourceRead<KubeEnvironment>;

  @doc("Description for Creates or updates a Kubernetes Environment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KubeEnvironment>;

  @doc("Description for Creates or updates a Kubernetes Environment.")
  update is ArmCustomPatchSync<KubeEnvironment, KubeEnvironmentPatchResource>;

  @doc("Description for Delete a Kubernetes Environment.")
  delete is ArmResourceDeleteAsync<KubeEnvironment>;

  @doc("Description for Get all the Kubernetes Environments in a resource group.")
  listByResourceGroup is ArmResourceListByParent<KubeEnvironment>;

  @doc("Description for Get all Kubernetes Environments for a subscription.")
  listBySubscription is ArmListBySubscription<KubeEnvironment>;
}

@@projectedName(KubeEnvironments.createOrUpdate::parameters.resource,
  "json",
  "kubeEnvironmentEnvelope"
);
@@extension(KubeEnvironments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "kubeEnvironmentEnvelope"
);
@@doc(KubeEnvironments.createOrUpdate::parameters.resource,
  "Configuration details of the Kubernetes Environment."
);
@@projectedName(KubeEnvironments.update::parameters.properties,
  "json",
  "kubeEnvironmentEnvelope"
);
@@extension(KubeEnvironments.update::parameters.properties,
  "x-ms-client-name",
  "kubeEnvironmentEnvelope"
);
@@doc(KubeEnvironments.update::parameters.properties,
  "Configuration details of the Kubernetes Environment."
);
