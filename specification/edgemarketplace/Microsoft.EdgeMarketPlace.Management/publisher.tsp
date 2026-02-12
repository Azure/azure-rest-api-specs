import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.EdgeMarketplace;
@doc("A publisher who provides offers.")
model Publisher is ExtensionResource<PublisherProperties> {
  ...ResourceNameParameter<Publisher, NamePattern = "^.*$">;
}
@@doc(Publisher.name, "Name of the publisher");

#suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" "backcompat, ARM reviewed"
@armResourceOperations
interface Publishers {
  @doc("Get a Publisher")
  get is ArmResourceRead<Publisher>;
  @doc("List Publisher resources by parent")
  list is ArmResourceListByParent<
    Publisher,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<Publisher>;

      @doc("The number of result items to return.")
      @query("$top")
      top?: int32;

      @doc("The number of result items to skip.")
      @query("skip")
      skip?: int32;

      @doc("The maximum number of result items per page.")
      @query("maxpagesize")
      maxpagesize?: int32;

      @doc("Filter the result list using the given expression.")
      @query("$filter")
      filter?: string;

      @doc("Skip over when retrieving results.")
      @query("$skipToken")
      skipToken?: string;
    }
  >;
  listBySubscription is ArmListBySubscription<Publisher>;
}
