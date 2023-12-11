import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Fleet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
@doc("Defines a multi-stage process to perform update operations across members of a Fleet.")
@parentResource(Fleet)
model FleetUpdateStrategy is ProxyResource<FleetUpdateStrategyProperties> {
  @doc("The name of the UpdateStrategy resource.")
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("updateStrategyName")
  @segment("updateStrategies")
  name: string;

  @doc("If eTag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")
  @visibility("read")
  eTag?: string;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface FleetUpdateStrategies {
  @doc("Get a FleetUpdateStrategy")
  get is ArmResourceRead<FleetUpdateStrategy>;
  @doc("Create a FleetUpdateStrategy")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FleetUpdateStrategy,
    {
      ...BaseParameters<FleetUpdateStrategy>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;

      @doc("The request should only proceed if no entity matches this string.")
      @header
      ifNoneMatch?: string;
    }
  >;
  @doc("Delete a FleetUpdateStrategy")
  delete is ArmResourceDeleteAsync<
    FleetUpdateStrategy,
    {
      ...BaseParameters<FleetUpdateStrategy>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    }
  >;
  @doc("List FleetUpdateStrategy resources by Fleet")
  listByFleet is ArmResourceListByParent<FleetUpdateStrategy>;
}
