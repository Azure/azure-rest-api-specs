import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Target.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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

@armResourceOperations
interface Capabilities {
  @doc("Get a Capability resource that extends a Target resource.")
  get is ArmResourceRead<Capability>;

  @doc("Create or update a Capability resource that extends a Target resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Capability>;

  @doc("Delete a Capability that extends a Target resource.")
  delete is ArmResourceDeleteSync<Capability>;

  @doc("Get a list of Capability resources that extend a Target resource..")
  list is ArmResourceListByParent<
    Capability,
    {
      ...BaseParameters<Capability>;

      @doc("String that sets the continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}

@@projectedName(Capabilities.createOrUpdate::parameters.resource,
  "json",
  "capability"
);
@@extension(Capabilities.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "capability"
);
@@doc(Capabilities.createOrUpdate::parameters.resource,
  "Capability resource to be created or updated."
);
