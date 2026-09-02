import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
@doc("The Fleet resource.")
model Fleet is TrackedResource<FleetProperties> {
  @doc("The name of the Fleet resource.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("fleetName")
  @segment("fleets")
  name: string;

  @doc("If eTag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")
  @visibility("read")
  eTag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface Fleets {
  @doc("Gets a Fleet.")
  get is ArmResourceRead<Fleet>;
  @doc("Creates or updates a Fleet.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Fleet,
    {
      ...BaseParameters<Fleet>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;

      @doc("The request should only proceed if no entity matches this string.")
      @header
      ifNoneMatch?: string;
    }
  >;
  @doc("Update a Fleet")
  update is ArmTagsPatchAsync<
    Fleet,
    {
      ...BaseParameters<Fleet>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    }
  >;
  @doc("Delete a Fleet")
  delete is ArmResourceDeleteAsync<
    Fleet,
    {
      ...BaseParameters<Fleet>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    }
  >;
  @doc("Lists fleets in the specified subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<Fleet>;
  @doc("Lists fleets in the specified subscription.")
  listBySubscription is ArmListBySubscription<Fleet>;
  @doc("Lists the user credentials of a Fleet.")
  listCredentials is ArmResourceActionSync<Fleet, {}, FleetCredentialResults>;
}
