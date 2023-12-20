import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerServiceFleet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerService;
@doc("A member of the Fleet. It contains a reference to an existing Kubernetes cluster on Azure.")
@parentResource(ContainerServiceFleet)
model ContainerServiceFleetMember is ProxyResource<FleetMemberProperties> {
  @doc("The name of the Fleet member resource.")
  @maxLength(50)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("fleetMemberName")
  @segment("members")
  name: string;
}

@armResourceOperations
interface ContainerServiceFleetMembers {
  @doc("Gets a Fleet member.")
  get is ArmResourceRead<ContainerServiceFleetMember>;
  @doc("A member contains a reference to an existing Kubernetes cluster. Creating a member makes the referenced cluster join the Fleet.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ContainerServiceFleetMember,
    {
      ...BaseParameters<ContainerServiceFleetMember>;

      @doc("Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new resource to be created and prevent updating an existing resource. Other values will result in a 412 Pre-condition Failed response.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Deleting a Fleet member results in the member cluster leaving fleet. The Member azure resource is deleted upon success. The underlying cluster is not deleted.")
  delete is ArmResourceDeleteAsync<
    ContainerServiceFleetMember,
    {
      ...BaseParameters<ContainerServiceFleetMember>;

      @doc("Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Lists the members of a fleet.")
  listByFleet is ArmResourceListByParent<ContainerServiceFleetMember>;
}
