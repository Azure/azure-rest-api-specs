import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Target.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Chaos;
@doc("Model that represents a Capability resource.")
@parentResource(Target)
model Capability is ProxyResource<CapabilityProperties> {
  @doc("String that represents a Capability resource name.")
  @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
  @path
  @key("capabilityName")
  @segment("capabilities")
  name: string;
}

alias CapabilityParentResourceParameters = BaseParameters<Capability> & ParentResourceParameters;

@armResourceOperations
interface Capabilities {
  @doc("Get a Capability resource that extends a Target resource.")
  get is ArmResourceRead<Capability, CapabilityParentResourceParameters>;

  @doc("Create or update a Capability resource that extends a Target resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Capability, CapabilityParentResourceParameters>;

  @doc("Delete a Capability that extends a Target resource.")
  delete is ArmResourceDeleteSync<Capability, CapabilityParentResourceParameters>;

  @doc("Get a list of Capability resources that extend a Target resource..")
  list is ArmResourceListByParent<
    Capability,
    {
      ...CapabilityParentResourceParameters;

      @doc("String that sets the continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
