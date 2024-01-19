import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Spacecraft.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Orbital;
@doc("Customer creates a contact resource for a spacecraft resource.")
@parentResource(Spacecraft)
model Contact is ProxyResource<ContactsProperties> {
  @doc("Contact name.")
  @path
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
  create is ArmResourceCreateOrUpdateAsync<
    Contact,
    BaseParameters<Contact>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a specified contact.")
  delete is ArmResourceDeleteAsync<
    Contact,
    BaseParameters<Contact>,
    ArmLroLocationHeader
  >;

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

@@projectedName(Contacts.create::parameters.resource, "json", "parameters");
@@extension(Contacts.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Contacts.create::parameters.resource,
  "The parameters to provide for the created contact."
);
