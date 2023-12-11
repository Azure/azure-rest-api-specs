import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./OrbitalSpacecraft.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Orbital;
@doc("Customer creates a contact resource for a spacecraft resource.")
@parentResource(OrbitalSpacecraft)
model OrbitalContact is ProxyResource<ContactsProperties> {
  @doc("Contact name.")
  @path
  @key("contactName")
  @segment("contacts")
  name: string;
}

@armResourceOperations
interface OrbitalContacts {
  @doc("Gets the specified contact in a specified resource group.")
  get is ArmResourceRead<OrbitalContact>;
  @doc("Creates a contact.")
  create is ArmResourceCreateOrUpdateAsync<OrbitalContact>;
  @doc("Deletes a specified contact.")
  delete is ArmResourceDeleteAsync<OrbitalContact>;
  @doc("Returns list of contacts by spacecraftName.")
  list is ArmResourceListByParent<
    OrbitalContact,
    {
      ...BaseParameters<OrbitalContact>;

      @doc("An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}
