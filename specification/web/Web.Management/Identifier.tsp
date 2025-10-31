import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * A domain specific resource identifier.
 */
@parentResource(Site)
model Identifier is Azure.ResourceManager.ProxyResource<IdentifierProperties> {
  ...ResourceNameParameter<
    Resource = Identifier,
    KeyName = "domainOwnershipIdentifierName",
    SegmentName = "domainOwnershipIdentifiers",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface IdentifierOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Name of domain ownership identifier. */
        @path
        @segment("domainOwnershipIdentifiers")
        @key
        domainOwnershipIdentifierName: string,
      }
    > {}

@armResourceOperations
interface Identifiers {
  /**
   * Description for Get domain ownership identifier for web app.
   */
  @summary("Get domain ownership identifier for web app.")
  getDomainOwnershipIdentifier is IdentifierOps.Read<
    Identifier,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  createOrUpdateDomainOwnershipIdentifier is IdentifierOps.CreateOrUpdateSync<
    Identifier,
    Response = ArmResourceUpdatedResponse<Identifier>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.
   */
  @summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @patch(#{ implicitOptionality: false })
  updateDomainOwnershipIdentifier is IdentifierOps.CustomPatchSync<
    Identifier,
    PatchModel = Identifier,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a domain ownership identifier for a web app.
   */
  @summary("Deletes a domain ownership identifier for a web app.")
  deleteDomainOwnershipIdentifier is IdentifierOps.DeleteSync<
    Identifier,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Lists ownership identifiers for domain associated with web app.
   */
  @summary("Lists ownership identifiers for domain associated with web app.")
  listDomainOwnershipIdentifiers is IdentifierOps.List<
    Identifier,
    Response = ArmResponse<IdentifierCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface IdentifierOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will delete the binding for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Name of domain ownership identifier. */
        @path
        @segment("domainOwnershipIdentifiers")
        @key
        domainOwnershipIdentifierName: string,
      }
    > {}

@armResourceOperations
interface IdentifierOperationGroup {
  /**
   * Description for Get domain ownership identifier for web app.
   */
  @summary("Get domain ownership identifier for web app.")
  getDomainOwnershipIdentifierSlot is IdentifierOperationGroupOps.Read<
    Identifier,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  createOrUpdateDomainOwnershipIdentifierSlot is IdentifierOperationGroupOps.CreateOrUpdateSync<
    Identifier,
    Response = ArmResourceUpdatedResponse<Identifier>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.
   */
  @summary("Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @patch(#{ implicitOptionality: false })
  updateDomainOwnershipIdentifierSlot is IdentifierOperationGroupOps.CustomPatchSync<
    Identifier,
    PatchModel = Identifier,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a domain ownership identifier for a web app.
   */
  @summary("Deletes a domain ownership identifier for a web app.")
  deleteDomainOwnershipIdentifierSlot is IdentifierOperationGroupOps.DeleteSync<
    Identifier,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Lists ownership identifiers for domain associated with web app.
   */
  @summary("Lists ownership identifiers for domain associated with web app.")
  listDomainOwnershipIdentifiersSlot is IdentifierOperationGroupOps.List<
    Identifier,
    Response = ArmResponse<IdentifierCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(Identifier.name, "Name of domain ownership identifier.");
@@doc(Identifier.properties, "Identifier resource specific properties");
@@doc(Identifiers.createOrUpdateDomainOwnershipIdentifier::parameters.resource,
  "A JSON representation of the domain ownership properties."
);
@@doc(Identifiers.updateDomainOwnershipIdentifier::parameters.properties,
  "A JSON representation of the domain ownership properties."
);
@@doc(IdentifierOperationGroup.createOrUpdateDomainOwnershipIdentifierSlot::parameters.resource,
  "A JSON representation of the domain ownership properties."
);
@@doc(IdentifierOperationGroup.updateDomainOwnershipIdentifierSlot::parameters.properties,
  "A JSON representation of the domain ownership properties."
);
