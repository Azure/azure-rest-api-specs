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

  /**
   * Kind of resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface DomainOwnershipIdentifiers {
  /**
   * Description for Get ownership identifier for domain
   */
  @summary("Get ownership identifier for domain")
  getOwnershipIdentifier is ArmResourceRead<
    DomainOwnershipIdentifier,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates an ownership identifier for a domain or updates identifier details for an existing identifier")
  createOrUpdateOwnershipIdentifier is ArmResourceCreateOrReplaceSync<
    DomainOwnershipIdentifier,
    Response = ArmResourceUpdatedResponse<DomainOwnershipIdentifier>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier
   */
  @patch(#{ implicitOptionality: false })
  @summary("Creates an ownership identifier for a domain or updates identifier details for an existing identifier")
  updateOwnershipIdentifier is ArmCustomPatchSync<
    DomainOwnershipIdentifier,
    PatchModel = DomainOwnershipIdentifier,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Delete ownership identifier for domain
   */
  @summary("Delete ownership identifier for domain")
  deleteOwnershipIdentifier is ArmResourceDeleteSync<
    DomainOwnershipIdentifier,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Lists domain ownership identifiers.
   */
  @summary("Lists domain ownership identifiers.")
  listOwnershipIdentifiers is ArmResourceListByParent<
    DomainOwnershipIdentifier,
    Response = ArmResponse<DomainOwnershipIdentifierCollection>,
    Error = DefaultErrorResponse
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
