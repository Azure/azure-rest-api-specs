import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./namespace.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.Cosmic;

#suppress "@azure-tools/typespec-azure-core/friendly-name" "Using @friendlyName to avoid System.Environment naming conflict in generated C#"
@doc("An Environment resource representing a per-ring deployment environment within a namespace.")
@friendlyName("CosmicEnvironment")
@parentResource(Namespace)
model Environment is TrackedResource<EnvironmentProperties> {
  @doc("The name of the environment.")
  @key("environmentName")
  @segment("environments")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(3)
  @maxLength(63)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/friendly-name" "Using @friendlyName to avoid System.Environment naming conflict in generated C#"
@doc("Properties of an Environment resource.")
@friendlyName("CosmicEnvironmentProperties")
model EnvironmentProperties {
  @doc("Platform ring classification (e.g. test, sdf, msit, prod).")
  platformRing?: CosmicRing;

  @doc("Topology configuration including per-location networking and partition declarations.")
  topology?: Topology;

  @doc("Capacity configuration for the environment.")
  capacity: CapacityPolicy;

  @doc("Resource policy configuration for the environment.")
  resourcePolicy?: ResourcePolicy;

  @doc("The status of the environment.")
  @visibility(Lifecycle.Read)
  status?: EnvironmentStatus;

  @doc("The provisioning state of the environment resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: CosmicProvisioningState;
}

@armResourceOperations
interface Environments {
  get is ArmResourceRead<Environment>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Environment>;
  update is ArmCustomPatchSync<
    Environment,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Environment,
      EnvironmentProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Environment>;
  listByNamespace is ArmResourceListByParent<Environment>;
}
