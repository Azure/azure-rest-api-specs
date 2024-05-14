import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DocumentDB;

interface Operations extends Azure.ResourceManager.Operations {
  /**
   * A long-running resource CreateOrUpdate (PUT)
   * @template Resource the resource being patched
   * @template BaseParameters Optional. Allows overriding the operation parameters
   * @template LroHeaders Optional.  Allows overriding the lro headers returned on resource create
   * @template Parameters Optional. Additional parameters after the path parameters
   * @template Response Optional. The success response for the createOrUpdate operation
   * @template Error Optional. The error response, if non-standard.
   */
  @autoRoute
  @doc("Create a {name}", Resource)
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @armResourceCreateOrUpdate(Resource)
  @put
  ArmResourceCreateOrUpdateWithAcceptedAsync<
    Resource extends ArmResource,
    BaseParameters = DefaultBaseParameters<Resource>,
    LroHeaders extends TypeSpec.Reflection.Model = {},
    Parameters extends {} = {},
    Response extends {} = ArmAcceptedLroResponse<"Resource operation accepted."> | ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<
      Resource,
      LroHeaders
    >,
    Error extends {} = ErrorResponse
  > is ArmCreateOperation<
    ResourceInstanceParameters<Resource, BaseParameters> & Parameters,
    Resource,
    Response,
    Error
  >;
}

@lroStatus
@doc("The provisioning state of the last accepted operation.")
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("An operation is in-progress on the resource.")
  "InProgress",

  @doc("An update operation is in-progress on the resource.")
  "Updating",

  @doc("A drop operation is in-progress on the resource.")
  "Dropping",
}
