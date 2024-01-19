import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
@doc("Network slice resource. Must be created in the same location as its parent mobile network.")
@parentResource(MobileNetwork)
model Slice is TrackedResource<SlicePropertiesFormat> {
  @doc("The name of the network slice.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("sliceName")
  @segment("slices")
  name: string;
}

@armResourceOperations
interface Slices {
  @doc("Gets information about the specified network slice.")
  get is ArmResourceRead<Slice>;

  @doc("Creates or updates a network slice. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Slice,
    BaseParameters<Slice>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates slice tags.")
  updateTags is ArmCustomPatchSync<Slice, TagsObject>;

  @doc("Deletes the specified network slice.")
  delete is ArmResourceDeleteAsync<
    Slice,
    BaseParameters<Slice>,
    ArmLroLocationHeader
  >;

  @doc("Lists all slices in the mobile network.")
  listByMobileNetwork is ArmResourceListByParent<Slice>;
}

@@projectedName(Slices.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Slices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Slices.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network slice operation."
);
@@projectedName(Slices.updateTags::parameters.properties, "json", "parameters");
@@extension(Slices.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Slices.updateTags::parameters.properties,
  "Parameters supplied to update network slice tags."
);
