import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Batch;
@doc("Contains information about an application in a Batch account.")
@parentResource(BatchAccount)
model BatchApplication is ProxyResource<ApplicationProperties> {
  @doc("The name of the application. This must be unique within the account.")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_-]+$")
  @path
  @key("applicationName")
  @segment("applications")
  name: string;
}

@armResourceOperations
interface BatchApplications {
  @doc("Gets information about the specified application.")
  get is ArmResourceRead<BatchApplication>;
  @doc("Adds an application to the specified Batch account.")
  create is ArmResourceCreateOrReplaceSync<BatchApplication>;
  @doc("Updates settings for the specified application.")
  update is ArmResourcePatchSync<BatchApplication, ApplicationProperties>;
  @doc("Deletes an application.")
  delete is ArmResourceDeleteSync<BatchApplication>;
  @doc("Lists all of the applications in the specified account.")
  list is ArmResourceListByParent<
    BatchApplication,
    {
      ...BaseParameters<BatchApplication>;

      @doc("The maximum number of items to return in the response.")
      @query("maxresults")
      maxresults?: int32;
    }
  >;
}
