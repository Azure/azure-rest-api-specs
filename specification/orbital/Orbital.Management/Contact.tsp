import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Spacecraft.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Orbital;
/**
 * Customer creates a contact resource for a spacecraft resource.
 */
@parentResource(Spacecraft)
model Contact
  is Azure.ResourceManager.ProxyResource<ContactsProperties, false> {
  ...ResourceNameParameter<
    Resource = Contact,
    KeyName = "contactName",
    SegmentName = "contacts",
    NamePattern = ""
  >;
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
  create is ArmResourceCreateOrReplaceAsync<Contact>;

  /**
   * Deletes a specified contact.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Contact,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns list of contacts by spacecraftName.
   */
  list is ArmResourceListByParent<
    Contact,
    Parameters = {
      /**
       * An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

@@doc(Contact.name, "Contact name.");
@@doc(Contact.properties, "Properties of the Contact Resource.");
@@doc(Contacts.create::parameters.resource,
  "The parameters to provide for the created contact."
);
