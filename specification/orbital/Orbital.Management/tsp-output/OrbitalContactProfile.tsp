import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Orbital;
@doc("Customer creates a Contact Profile Resource, which will contain all of the configurations required for scheduling a contact.")
model OrbitalContactProfile is TrackedResource<ContactProfileProperties> {
  @doc("Contact Profile name.")
  @path
  @key("contactProfileName")
  @segment("contactProfiles")
  name: string;
}

@armResourceOperations
interface OrbitalContactProfiles {
  @doc("Gets the specified contact Profile in a specified resource group.")
  get is ArmResourceRead<OrbitalContactProfile>;
  @doc("Creates or updates a contact profile.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OrbitalContactProfile>;
  @doc("Updates the specified contact profile tags.")
  updateTags is ArmTagsPatchAsync<OrbitalContactProfile>;
  @doc("Deletes a specified contact profile resource.")
  delete is ArmResourceDeleteAsync<OrbitalContactProfile>;
  @doc("Returns list of contact profiles by Resource Group.")
  list is ArmResourceListByParent<
    OrbitalContactProfile,
    {
      ...BaseParameters<OrbitalContactProfile>;

      @doc("An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
  @doc("Returns list of contact profiles by Subscription.")
  listBySubscription is ArmListBySubscription<OrbitalContactProfile>;
}
