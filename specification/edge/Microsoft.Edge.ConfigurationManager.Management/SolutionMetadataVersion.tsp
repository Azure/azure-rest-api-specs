import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./SolutionMetadata.tsp";
import "./ProvisioningState.tsp";
import "./AvailableSolutionTemplateVersion.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@added(Versions.v2025_08_01)
@doc("Solution Metadata Version Properties")
model SolutionMetadataVersionProperties {
  @doc("Solution template version Id")
  @visibility(Lifecycle.Read)
  solutionTemplateVersionId: string;

  @doc("Dynamic Schema Id for the solution template version")
  @visibility(Lifecycle.Read)
  dynamicSchemaId?: string;

  @doc("Dynamic Configuration Id for the solution template version")
  @visibility(Lifecycle.Read)
  dynamicConfigurationId?: string;

  @doc("Configuration status of the solution template version")
  @visibility(Lifecycle.Read)
  configurationStatus?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_08_01)
@doc("Solution Metadata Version Resource")
@parentResource(SolutionMetadata)
@resource("versions")
model SolutionMetadataVersion
  is Azure.ResourceManager.ProxyResource<SolutionMetadataVersionProperties> {
  @doc("Name of the solution metadata version")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("solutionMetadataVersionName")
  @segment("SolutionMetadataVersions")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

@added(Versions.v2025_08_01)
@armResourceOperations
interface SolutionMetadataVersions {
  @doc("Get a Solution resource")
  get is ArmResourceRead<SolutionMetadataVersion>;

  @doc("Create or update a Solution Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SolutionMetadataVersion>;

  @doc("Update a Solution Resource")
  update is ArmResourcePatchAsync<SolutionMetadataVersion, SolutionMetadataVersionProperties>;

  @doc("Delete a Solution Resource")
  delete is ArmResourceDeleteWithoutOkAsync<SolutionMetadataVersion>;

  @doc("List Solution resources")
  listByTarget is ArmResourceListByParent<SolutionMetadataVersion>;
}
