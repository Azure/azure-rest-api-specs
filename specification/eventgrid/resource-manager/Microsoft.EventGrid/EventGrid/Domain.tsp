import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * EventGrid Domain.
 */
model Domain is Azure.ResourceManager.TrackedResource<DomainProperties> {
  ...ResourceNameParameter<
    Resource = Domain,
    KeyName = "domainName",
    SegmentName = "domains",
    NamePattern = ""
  >;

  /**
   * The Sku pricing tier for the Event Grid Domain resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;

  /**
   * Identity information for the Event Grid Domain resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityInfo;
}

@armResourceOperations
interface Domains {
  /**
   * Get properties of a domain.
   */
  @summary("Get a domain.")
  get is ArmResourceRead<Domain>;

  /**
   * Asynchronously creates or updates a new domain with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update a domain.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Domain,
    Response = ArmResourceCreatedResponse<
      Domain,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Asynchronously updates a domain with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update a domain.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Domain,
    PatchModel = DomainUpdateParameters,
    Response = {
      @body body: void;
    } | ArmResourceCreatedResponse<
      Domain,
      LroHeaders = ArmLroLocationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Delete existing domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a domain.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Domain,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the domains under a resource group.
   */
  @summary("List domains under a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Domain,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<DomainsListResult>
  >;

  /**
   * List all the domains under an Azure subscription.
   */
  @summary("List domains under an Azure subscription.")
  listBySubscription is ArmListBySubscription<
    Domain,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<DomainsListResult>
  >;

  /**
   * List the two keys used to publish to a domain.
   */
  @summary("List keys for a domain.")
  @action("listKeys")
  listSharedAccessKeys is ArmResourceActionSync<
    Domain,
    void,
    ArmResponse<DomainSharedAccessKeys>
  >;

  /**
   * Regenerate a shared access key for a domain.
   */
  @summary("Regenerate key for a domain.")
  regenerateKey is ArmResourceActionSync<
    Domain,
    DomainRegenerateKeyRequest,
    ArmResponse<DomainSharedAccessKeys>
  >;
}

@@doc(Domain.name, "Name of the domain.");
@@doc(Domain.properties, "Properties of the Event Grid Domain resource.");
@@doc(Domains.createOrUpdate::parameters.resource, "Domain information.");
@@doc(Domains.update::parameters.properties, "Domain update information.");
@@doc(Domains.regenerateKey::parameters.body,
  "Request body to regenerate key."
);
