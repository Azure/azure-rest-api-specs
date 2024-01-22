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
/**
 * A Kubernetes cluster specialized for web workloads by Azure App Service
 */
model KubeEnvironment is TrackedResource<KubeEnvironmentProperties> {
  /**
   * Name of the Kubernetes Environment.
   */
  @path
  @key("name")
  @segment("kubeEnvironments")
  name: string;

  /**
   * Extended Location.
   */
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface KubeEnvironments {
  /**
   * Description for Get the properties of a Kubernetes Environment.
   */
  get is ArmResourceRead<KubeEnvironment>;

  /**
   * Description for Creates or updates a Kubernetes Environment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<KubeEnvironment>;

  /**
   * Description for Creates or updates a Kubernetes Environment.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<KubeEnvironment, KubeEnvironmentPatchResource>;

  /**
   * Description for Delete a Kubernetes Environment.
   */
  delete is ArmResourceDeleteAsync<KubeEnvironment>;

  /**
   * Description for Get all the Kubernetes Environments in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("KubeEnvironments_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<KubeEnvironment>;

  /**
   * Description for Get all Kubernetes Environments for a subscription.
   */
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
