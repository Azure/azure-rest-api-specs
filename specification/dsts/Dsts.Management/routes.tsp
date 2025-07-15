import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Dsts;

@armResourceOperations
@added(Versions.v2025_05_23_preview)
interface Applications {
  @summary("Retrieves the specified Application resource.")
  get is ArmResourceRead<Application>;

  @summary("Lists the specified Application resources.")
  list is ArmResourceListByParent<Application>;
}

@armResourceOperations
@added(Versions.v2025_06_10_preview)
interface Endpoints {
  @summary("Retrieves the specified Endpoint resource.")
  get is ArmResourceRead<Endpoint>;

  @summary("Lists the specified Endpoint resources.")
  list is ArmResourceListByParent<Endpoint>;
}
