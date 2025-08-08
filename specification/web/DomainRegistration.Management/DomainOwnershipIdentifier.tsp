import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Domain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DomainRegistration;
/**
 * Domain ownership Identifier.
 */
@parentResource(Domain)
model DomainOwnershipIdentifier
  is Azure.ResourceManager.ProxyResource<DomainOwnershipIdentifierProperties> {
  ...ResourceNameParameter<
    Resource = DomainOwnershipIdentifier,
    KeyName = "name",
    SegmentName = "domainOwnershipIdentifiers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DomainOwnershipIdentifiers {
  /**
   * Description for Get ownership identifier for domain
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Domains_GetOwnershipIdentifier")
  getOwnershipIdentifier is ArmResourceRead<DomainOwnershipIdentifier>;

  /**
   * Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Domains_CreateOrUpdateOwnershipIdentifier")
  createOrUpdateOwnershipIdentifier is ArmResourceCreateOrReplaceSync<
    DomainOwnershipIdentifier,
    Response = ArmResourceUpdatedResponse<DomainOwnershipIdentifier>
  >;

  /**
   * Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Domains_UpdateOwnershipIdentifier")
  @patch(#{ implicitOptionality: false })
  updateOwnershipIdentifier is ArmCustomPatchSync<
    DomainOwnershipIdentifier,
    PatchModel = DomainOwnershipIdentifier
  >;

  /**
   * Description for Delete ownership identifier for domain
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Domains_DeleteOwnershipIdentifier")
  deleteOwnershipIdentifier is ArmResourceDeleteSync<DomainOwnershipIdentifier>;

  /**
   * Description for Lists domain ownership identifiers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Domains_ListOwnershipIdentifiers")
  listOwnershipIdentifiers is ArmResourceListByParent<
    DomainOwnershipIdentifier,
    Response = ArmResponse<DomainOwnershipIdentifierCollection>
  >;
}

@@doc(DomainOwnershipIdentifier.name, "Name of identifier.");
@@doc(DomainOwnershipIdentifier.properties,
  "DomainOwnershipIdentifier resource specific properties"
);
@@doc(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "A JSON representation of the domain ownership properties."
);
@@doc(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "A JSON representation of the domain ownership properties."
);
