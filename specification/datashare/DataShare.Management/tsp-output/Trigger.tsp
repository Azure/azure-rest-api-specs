import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ShareSubscription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
// FIXME: Trigger has no properties property
@doc("A Trigger data transfer object.")
@parentResource(ShareSubscription)
model Trigger is ProxyResource<{}> {
  @doc("The name of the trigger.")
  @path
  @key("triggerName")
  @segment("triggers")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Triggers {
  @doc("Get a Trigger in a shareSubscription")
  get is ArmResourceRead<Trigger>;

  @doc("Create a Trigger ")
  create is ArmResourceCreateOrUpdateAsync<Trigger>;

  @doc("Delete a Trigger in a shareSubscription")
  delete is ArmResourceDeleteAsync<Trigger>;

  @doc("List Triggers in a share subscription")
  listByShareSubscription is ArmResourceListByParent<
    Trigger,
    {
      ...BaseParameters<Trigger>;

      @doc("Continuation token")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@projectedName(Triggers.create::parameters.resource, "json", "trigger");
@@extension(Triggers.create::parameters.resource,
  "x-ms-client-name",
  "trigger"
);
@@doc(Triggers.create::parameters.resource, "Trigger details.");
