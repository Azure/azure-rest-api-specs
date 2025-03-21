import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/organization.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureDevOpsPlatform;

@doc("Azure DevOps Organization")
model Organization is ProxyResource<OrganizationProperties> {
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("organizationName")
  @segment("organizations")
  @doc("Unique name of the organization")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@armResourceOperations
interface Organizations {
  get is ArmLocResources.ArmLocResourceRead<Organization>;
  list is ArmLocResources.ArmLocResourceListByParent<Organization>;
}
