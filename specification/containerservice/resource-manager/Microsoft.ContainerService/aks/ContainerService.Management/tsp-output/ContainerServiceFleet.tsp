import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerService;
@doc("The Fleet resource which contains multiple Kubernetes clusters as its members.")
model ContainerServiceFleet is TrackedResource<FleetProperties> {
  @doc("The name of the Fleet resource.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("fleetName")
  @segment("fleets")
  name: string;
}

@armResourceOperations
interface ContainerServiceFleets {
  @doc("Gets a Fleet.")
  get is ArmResourceRead<ContainerServiceFleet>;
  @doc("Creates or updates a Fleet.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ContainerServiceFleet,
    {
      ...BaseParameters<ContainerServiceFleet>;

      @doc("Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new resource to be created and prevent updating an existing resource. Other values will result in a 412 Pre-condition Failed response.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Patches a fleet resource.")
  update is ArmTagsPatchSync<
    ContainerServiceFleet,
    {
      ...BaseParameters<ContainerServiceFleet>;

      @doc("Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes a Fleet.")
  delete is ArmResourceDeleteAsync<
    ContainerServiceFleet,
    {
      ...BaseParameters<ContainerServiceFleet>;

      @doc("Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Lists fleets in the specified subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<ContainerServiceFleet>;
  @doc("Lists fleets in the specified subscription.")
  list is ArmListBySubscription<ContainerServiceFleet>;
  @doc("Lists the user credentials of a Fleet.")
  listCredentials is ArmResourceActionSync<
    ContainerServiceFleet,
    void,
    FleetCredentialResults
  >;
}
