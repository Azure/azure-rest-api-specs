import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;
@doc("Class representing a Kusto sandbox custom image.")
@parentResource(Cluster)
model SandboxCustomImage is ProxyResource<SandboxCustomImageProperties> {
  @doc("The name of the sandbox custom image.")
  @pattern("^.*$")
  @path
  @key("sandboxCustomImageName")
  @segment("sandboxCustomImages")
  name: string;
}

@armResourceOperations
interface SandboxCustomImages {
  @doc("Returns a sandbox custom image")
  get is ArmResourceRead<SandboxCustomImage>;
  @doc("Creates or updates a sandbox custom image.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SandboxCustomImage>;
  @doc("Updates a sandbox custom image.")
  update is ArmResourcePatchAsync<
    SandboxCustomImage,
    SandboxCustomImageProperties
  >;
  @doc("Deletes a sandbox custom image.")
  delete is ArmResourceDeleteAsync<SandboxCustomImage>;
  @doc("Returns the list of the existing sandbox custom images of the given Kusto cluster.")
  listByCluster is ArmResourceListByParent<SandboxCustomImage>;
}
