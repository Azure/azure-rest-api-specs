import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using Autorest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ElasticSan;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "No Resource operation"
interface Template {
  @autoRoute
  @doc("Create a {name}", TResource)
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @armResourceCreateOrUpdate(TResource)
  @put
  ArmResourceCreateOrUpdateAsync<
    TResource extends ArmResource,
    TBaseParameters = BaseParameters<TResource>,
    LroHeaders extends TypeSpec.Reflection.Model = {}
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>,

    @doc("Resource create parameters.")
    @body
    parameters: TResource,
  ): ArmResourceUpdatedResponse<TResource> | ArmResourceCreatedResponse<
    TResource,
    LroHeaders
  > | ErrorResponse;
}
