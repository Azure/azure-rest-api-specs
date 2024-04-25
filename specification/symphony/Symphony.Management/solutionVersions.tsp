import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Symphony;

@doc("The properties of the SolutionVersion.")
model SolutionVersionProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A list of components")
  @OpenAPI.extension("x-ms-identifiers", [])
  components?: ComponentProperties[];

  @doc("Displayname of solution version")
  displayName?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("Metadata of solution version")
  metadata?: Record<string>;
}

@doc("The service entity.")
@resource("versions")
@parentResource(Solution)
model SolutionVersion is ProxyResource<SolutionVersionProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;
  
  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface SolutionVersions {
  @doc("Returns details of the service.")
  get is Azure.ResourceManager.ArmResourceRead<SolutionVersion>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceSync<SolutionVersion>;
  @doc("Updates existing service.")
  update is ArmResourcePatchSync<SolutionVersion, SolutionVersionProperties>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<SolutionVersion>;

  listByParent is ArmResourceListByParent<SolutionVersion>;
}