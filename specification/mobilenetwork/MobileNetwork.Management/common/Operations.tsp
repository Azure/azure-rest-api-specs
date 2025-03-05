import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

using Azure.Core;
using Azure.ResourceManager;
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
  #{ `final-state-via`: "azure-async-operation" }
)
@armResourceCreateOrUpdate(Resource)
@put
op ArmResourceCreateOrUpdateAsyncWithNoBody<Resource extends Azure.ResourceManager.Foundations.Resource>(
  ...ResourceInstanceParameters<
    Resource,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>
  >,
): ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<Resource> | ErrorResponse;
