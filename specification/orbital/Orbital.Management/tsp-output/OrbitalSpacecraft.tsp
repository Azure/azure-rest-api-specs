import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Orbital;
@doc("Customer creates a spacecraft resource to schedule a contact.")
model OrbitalSpacecraft is TrackedResource<SpacecraftsProperties> {
  @doc("Spacecraft ID.")
  @path
  @key("spacecraftName")
  @segment("spacecrafts")
  name: string;
}

@armResourceOperations
interface OrbitalSpacecrafts {
  @doc("Gets the specified spacecraft in a specified resource group.")
  get is ArmResourceRead<OrbitalSpacecraft>;
  @doc("Creates or updates a spacecraft resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OrbitalSpacecraft>;
  @doc("Updates the specified spacecraft tags.")
  updateTags is ArmTagsPatchAsync<OrbitalSpacecraft>;
  @doc("Deletes a specified spacecraft resource.")
  delete is ArmResourceDeleteAsync<OrbitalSpacecraft>;
  @doc("Returns list of spacecrafts by resource group.")
  list is ArmResourceListByParent<
    OrbitalSpacecraft,
    {
      ...BaseParameters<OrbitalSpacecraft>;

      @doc("An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
  @doc("Returns list of spacecrafts by subscription.")
  listBySubscription is ArmListBySubscription<OrbitalSpacecraft>;
  @doc("Returns list of available contacts. A contact is available if the spacecraft is visible from the ground station for more than the minimum viable contact duration provided in the contact profile.")
  listAvailableContacts is ArmResourceActionAsync<
    OrbitalSpacecraft,
    ContactParameters,
    AvailableContactsListResult
  >;
}
