import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * A domain specific resource identifier.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Site)
@includeInapplicableMetadataInPayload(false)
model Identifier extends ProxyOnlyResource {
  /**
   * Name of domain ownership identifier.
   */
  @path
  @key("domainOwnershipIdentifierName")
  @segment("domainOwnershipIdentifiers")
  @visibility("read")
  name: string;

  /**
   * Identifier resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: IdentifierProperties;
}

@armResourceOperations
interface Identifiers {
  /**
   * Description for Get domain ownership identifier for web app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetDomainOwnershipIdentifier")
  getDomainOwnershipIdentifier is ArmResourceRead<Identifier>;

  /**
   * Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateDomainOwnershipIdentifier")
  createOrUpdateDomainOwnershipIdentifier is ArmResourceCreateOrReplaceSync<Identifier>;

  /**
   * Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WebApps_UpdateDomainOwnershipIdentifier")
  updateDomainOwnershipIdentifier is ArmCustomPatchSync<Identifier, Identifier>;

  /**
   * Description for Deletes a domain ownership identifier for a web app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DeleteDomainOwnershipIdentifier")
  deleteDomainOwnershipIdentifier is ArmResourceDeleteSync<Identifier>;

  /**
   * Description for Lists ownership identifiers for domain associated with web app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListDomainOwnershipIdentifiers")
  listDomainOwnershipIdentifiers is ArmResourceListByParent<Identifier>;
}

@@projectedName(Identifiers.createOrUpdateDomainOwnershipIdentifier::parameters.resource,
  "json",
  "domainOwnershipIdentifier"
);
@@extension(Identifiers.createOrUpdateDomainOwnershipIdentifier::parameters.resource,
  "x-ms-client-name",
  "domainOwnershipIdentifier"
);
@@doc(Identifiers.createOrUpdateDomainOwnershipIdentifier::parameters.resource,
  "A JSON representation of the domain ownership properties."
);
@@projectedName(Identifiers.updateDomainOwnershipIdentifier::parameters.properties,
  "json",
  "domainOwnershipIdentifier"
);
@@extension(Identifiers.updateDomainOwnershipIdentifier::parameters.properties,
  "x-ms-client-name",
  "domainOwnershipIdentifier"
);
@@doc(Identifiers.updateDomainOwnershipIdentifier::parameters.properties,
  "A JSON representation of the domain ownership properties."
);
