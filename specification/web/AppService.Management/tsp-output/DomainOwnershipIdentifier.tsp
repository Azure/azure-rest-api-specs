import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Domain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Domain ownership Identifier.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Domain)
@Azure.ResourceManager.Private.armResourceInternal(
  DomainOwnershipIdentifierProperties
)
@includeInapplicableMetadataInPayload(false)
model DomainOwnershipIdentifier extends ProxyOnlyResource {
  /**
   * Name of identifier.
   */
  @path
  @key("name")
  @segment("domainOwnershipIdentifiers")
  name: string;

  /**
   * DomainOwnershipIdentifier resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: DomainOwnershipIdentifierProperties;
}

@armResourceOperations
interface DomainOwnershipIdentifiers {
  /**
   * Description for Get ownership identifier for domain
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Domains_GetOwnershipIdentifier")
  getOwnershipIdentifier is ArmResourceRead<DomainOwnershipIdentifier>;

  /**
   * Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Domains_CreateOrUpdateOwnershipIdentifier")
  createOrUpdateOwnershipIdentifier is ArmResourceCreateOrReplaceSync<DomainOwnershipIdentifier>;

  /**
   * Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Domains_UpdateOwnershipIdentifier")
  updateOwnershipIdentifier is ArmCustomPatchSync<
    DomainOwnershipIdentifier,
    DomainOwnershipIdentifier
  >;

  /**
   * Description for Delete ownership identifier for domain
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Domains_DeleteOwnershipIdentifier")
  deleteOwnershipIdentifier is ArmResourceDeleteSync<DomainOwnershipIdentifier>;

  /**
   * Description for Lists domain ownership identifiers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Domains_ListOwnershipIdentifiers")
  listOwnershipIdentifiers is ArmResourceListByParent<DomainOwnershipIdentifier>;
}

@@projectedName(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "json",
  "domainOwnershipIdentifier"
);
@@extension(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "x-ms-client-name",
  "domainOwnershipIdentifier"
);
@@doc(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "A JSON representation of the domain ownership properties."
);
@@projectedName(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "json",
  "domainOwnershipIdentifier"
);
@@extension(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "x-ms-client-name",
  "domainOwnershipIdentifier"
);
@@doc(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "A JSON representation of the domain ownership properties."
);
