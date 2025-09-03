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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Domains_GetOwnershipIdentifier")
  getOwnershipIdentifier is ArmResourceRead<
    DomainOwnershipIdentifier,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Domains_CreateOrUpdateOwnershipIdentifier")
  createOrUpdateOwnershipIdentifier is ArmResourceCreateOrReplaceSync<
    DomainOwnershipIdentifier,
    Response = ArmResourceUpdatedResponse<DomainOwnershipIdentifier>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Domains_UpdateOwnershipIdentifier")
  @patch(#{ implicitOptionality: false })
  updateOwnershipIdentifier is ArmCustomPatchSync<
    DomainOwnershipIdentifier,
    PatchModel = DomainOwnershipIdentifier,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Delete ownership identifier for domain
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Domains_DeleteOwnershipIdentifier")
  deleteOwnershipIdentifier is ArmResourceDeleteSync<
    DomainOwnershipIdentifier,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Lists domain ownership identifiers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Domains_ListOwnershipIdentifiers")
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
