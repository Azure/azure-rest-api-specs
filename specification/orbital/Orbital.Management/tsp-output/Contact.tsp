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
/**
 * Customer creates a contact resource for a spacecraft resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Spacecraft)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ContactsProperties)
model Contact extends ProxyResourceBase {
  /**
   * Contact name.
   */
  @path
  @key("contactName")
  @segment("contacts")
  @visibility("read")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;

  /**
   * Properties of the Contact Resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ContactsProperties;
}

@armResourceOperations
interface Contacts {
  /**
   * Gets the specified contact in a specified resource group.
   */
  get is ArmResourceRead<Contact>;

  /**
   * Creates a contact.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Contact,
    BaseParameters<Contact>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a specified contact.
   */
  delete is ArmResourceDeleteAsync<
    Contact,
    BaseParameters<Contact>,
    ArmLroLocationHeader
  >;

  /**
   * Returns list of contacts by spacecraftName.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Contacts_List")
  list is ArmResourceListByParent<
    Contact,
    {
      ...BaseParameters<Contact>;

      /**
       * An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
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
