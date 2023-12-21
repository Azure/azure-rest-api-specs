import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ArcScVmm;
@doc("The AvailabilitySets resource definition.")
model AvailabilitySet is TrackedResource<AvailabilitySetProperties> {
  @doc("Name of the AvailabilitySet.")
  @path
  @key("availabilitySetName")
  @segment("availabilitySets")
  name: string;

  @doc("The extended location.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface AvailabilitySets {
  @doc("Implements AvailabilitySet GET method.")
  get is ArmResourceRead<AvailabilitySet>;
  @doc("Onboards the ScVmm availability set as an Azure resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AvailabilitySet>;
  @doc("Updates the AvailabilitySets resource.")
  update is ArmTagsPatchAsync<AvailabilitySet>;
  @doc("Deregisters the ScVmm availability set from Azure.")
  delete is ArmResourceDeleteAsync<
    AvailabilitySet,
    {
      ...BaseParameters<AvailabilitySet>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of AvailabilitySets in a resource group.")
  listByResourceGroup is ArmResourceListByParent<AvailabilitySet>;
  @doc("List of AvailabilitySets in a subscription.")
  listBySubscription is ArmListBySubscription<AvailabilitySet>;
}
