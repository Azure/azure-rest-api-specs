import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
@doc("Friendly Secret name mapping to the any Secret or secret related information.")
@parentResource(Profile)
model FrontDoorSecret is ProxyResource<SecretDetails> {
  @doc("Name of the Secret under the profile.")
  @path
  @key("secretName")
  @segment("secrets")
  name: string;
}

@armResourceOperations
interface FrontDoorSecrets {
  @doc("Gets an existing Secret within a profile.")
  get is ArmResourceRead<FrontDoorSecret>;

  @doc("Creates a new Secret within the specified profile.")
  create is ArmResourceCreateOrUpdateAsync<
    FrontDoorSecret,
    BaseParameters<FrontDoorSecret>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes an existing Secret within profile.")
  delete is ArmResourceDeleteAsync<
    FrontDoorSecret,
    BaseParameters<FrontDoorSecret>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists existing AzureFrontDoor secrets.")
  listByProfile is ArmResourceListByParent<FrontDoorSecret>;
}

@@projectedName(FrontDoorSecrets.create::parameters.resource, "json", "secret");
@@extension(FrontDoorSecrets.create::parameters.resource,
  "x-ms-client-name",
  "secret"
);
@@doc(FrontDoorSecrets.create::parameters.resource, "The Secret properties.");
