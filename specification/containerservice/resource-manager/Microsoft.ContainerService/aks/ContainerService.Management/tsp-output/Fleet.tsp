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

namespace Microsoft.ContainerService;
@doc("The Fleet resource which contains multiple Kubernetes clusters as its members.")
model Fleet is TrackedResource<FleetProperties> {
  @doc("The name of the Fleet resource.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("fleetName")
  @segment("fleets")
  name: string;

  @doc("Resource Etag.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface Fleets {
  @doc("Gets a Fleet.")
  get is ArmResourceRead<Fleet>;

  @doc("Creates or updates a Fleet.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Fleet,
    {
      ...BaseParameters<Fleet>;

      @doc("Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new resource to be created and prevent updating an existing resource. Other values will result in a 412 Pre-condition Failed response.")
      @header
      IfNoneMatch?: string;
    },
    ArmAsyncOperationHeader
  >;

  @doc("Patches a fleet resource.")
  update is ArmCustomPatchSync<
    Fleet,
    FleetPatch,
    {
      ...BaseParameters<Fleet>;

      @doc("Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;

  @doc("Deletes a Fleet.")
  delete is ArmResourceDeleteAsync<
    Fleet,
    {
      ...BaseParameters<Fleet>;

      @doc("Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    },
    ArmLroLocationHeader
  >;

  @doc("Lists fleets in the specified subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<Fleet>;

  @doc("Lists fleets in the specified subscription.")
  list is ArmListBySubscription<Fleet>;

  @doc("Lists the user credentials of a Fleet.")
  listCredentials is ArmResourceActionSync<Fleet, void, FleetCredentialResults>;
}

@@projectedName(Fleets.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Fleets.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Fleets.createOrUpdate::parameters.resource,
  "The Fleet to create or update."
);
@@projectedName(Fleets.update::parameters.properties, "json", "parameters");
@@extension(Fleets.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Fleets.update::parameters.properties,
  "The properties of a Fleet to update."
);
