import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a valid template"
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
op ArmResourceCreateOrUpdateAsyncWithNoBody<Resource extends ArmResource>(
  ...ResourceInstanceParameters<Resource, DefaultBaseParameters<Resource>>,
): ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<Resource> | ErrorResponse;

/** Compliant create or update template */
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a valid template"
@autoRoute
@doc("Create a {name}", TResource)
@OpenAPI.extension("x-ms-long-running-operation", true)
@OpenAPI.extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdate2Async<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

@doc("ARM resource update successful")
model ArmUpdatedResponse<TResource extends ArmResource>
  is ArmResponse<TResource>;
