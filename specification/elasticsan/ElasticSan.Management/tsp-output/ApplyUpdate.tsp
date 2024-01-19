import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maintenance;
@doc("Apply Update request")
model ApplyUpdate is ProxyResource<ApplyUpdateProperties> {
  @doc("applyUpdate Id")
  @path
  @key("applyUpdateName")
  @segment("applyUpdates")
  name: string;
}

@armResourceOperations
interface ApplyUpdates {
  @doc("Track maintenance updates to resource")
  get is ArmResourceRead<ApplyUpdate>;

  @doc("Apply maintenance updates to resource")
  createOrUpdateOrCancel is ArmResourceCreateOrReplaceSync<ApplyUpdate>;

  @doc("Get Configuration records within a subscription")
  list is ArmListBySubscription<ApplyUpdate>;
}

@@projectedName(ApplyUpdates.createOrUpdateOrCancel::parameters.resource,
  "json",
  "applyUpdate"
);
@@extension(ApplyUpdates.createOrUpdateOrCancel::parameters.resource,
  "x-ms-client-name",
  "applyUpdate"
);
@@doc(ApplyUpdates.createOrUpdateOrCancel::parameters.resource,
  "The ApplyUpdate"
);
