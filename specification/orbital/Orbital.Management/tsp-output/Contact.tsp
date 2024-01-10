import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Spacecraft.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Orbital;
@doc("Customer creates a contact resource for a spacecraft resource.")
@parentResource(Spacecraft)
model Contact is ProxyResource<ContactsProperties> {
  @doc("Contact name.")
  @key("contactName")
  @segment("contacts")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface Contacts {
  @doc("Gets the specified contact in a specified resource group.")
  get is ArmResourceRead<Contact>;

  @doc("Creates a contact.")
  create is ArmResourceCreateOrUpdateAsync<Contact>;

  @doc("Deletes a specified contact.")
  delete is ArmResourceDeleteAsync<Contact>;

  @doc("Returns list of contacts by spacecraftName.")
  list is ArmResourceListByParent<
    Contact,
    {
      ...BaseParameters<Contact>;

      @doc("An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}
