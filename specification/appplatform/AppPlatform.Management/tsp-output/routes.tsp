import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.AppPlatform;

interface RuntimeVersionsOperations {
  @doc("Lists all of the available runtime versions supported by Microsoft.AppPlatform provider.")
  @route("/providers/Microsoft.AppPlatform/runtimeVersions")
  @get
  listRuntimeVersions is Azure.Core.Foundations.Operation<
    {},
    AvailableRuntimeVersions
  >;
}

interface SkusOperations {
  @doc("Lists all of the available skus of the Microsoft.AppPlatform provider.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AppPlatform/skus")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription ID which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    ResourceSkuCollection
  >;
}
