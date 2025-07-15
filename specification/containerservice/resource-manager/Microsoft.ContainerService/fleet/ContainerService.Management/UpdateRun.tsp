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
@doc("A multi-stage process to perform update operations across members of a Fleet.")
@parentResource(Fleet)
model UpdateRun is ProxyResource<UpdateRunProperties> {
  @doc("The name of the UpdateRun resource.")
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("updateRunName")
  @segment("updateRuns")
  name: string;

  @doc("If eTag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")
  @visibility("read")
  eTag?: string;

  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface UpdateRuns {
  @doc("Get a UpdateRun")
  get is ArmResourceRead<UpdateRun>;
  @doc("Create a UpdateRun")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    UpdateRun,
    {
      ...BaseParameters<UpdateRun>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;

      @doc("The request should only proceed if no entity matches this string.")
      @header
      ifNoneMatch?: string;
    }
  >;
  @doc("Delete a UpdateRun")
  delete is ArmResourceDeleteAsync<
    UpdateRun,
    {
      ...BaseParameters<UpdateRun>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    }
  >;
  @doc("List UpdateRun resources by Fleet")
  listByFleet is ArmResourceListByParent<UpdateRun>;
  @doc("Starts an UpdateRun.")
  start is ArmResourceActionAsync<
    UpdateRun,
    {},
    UpdateRun,
    {
      ...BaseParameters<UpdateRun>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    }
  >;
  @doc("Stops an UpdateRun.")
  stop is ArmResourceActionAsync<
    UpdateRun,
    {},
    UpdateRun,
    {
      ...BaseParameters<UpdateRun>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    }
  >;
}
