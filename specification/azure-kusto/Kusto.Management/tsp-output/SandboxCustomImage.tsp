import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
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
  update is ArmCustomPatchAsync<SandboxCustomImage, SandboxCustomImage>;

  @doc("Deletes a sandbox custom image.")
  delete is ArmResourceDeleteAsync<SandboxCustomImage>;

  @doc("Returns the list of the existing sandbox custom images of the given Kusto cluster.")
  listByCluster is ArmResourceListByParent<SandboxCustomImage>;
}

@@projectedName(SandboxCustomImages.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SandboxCustomImages.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SandboxCustomImages.createOrUpdate::parameters.resource,
  "The sandbox custom image parameters."
);
@@projectedName(SandboxCustomImages.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(SandboxCustomImages.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SandboxCustomImages.update::parameters.properties,
  "The sandbox custom image parameters."
);
