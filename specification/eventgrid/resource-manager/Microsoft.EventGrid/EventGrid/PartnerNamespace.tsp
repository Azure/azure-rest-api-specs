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
 * EventGrid Partner Namespace.
 */
model PartnerNamespace
  is Azure.ResourceManager.TrackedResource<PartnerNamespaceProperties> {
  ...ResourceNameParameter<
    Resource = PartnerNamespace,
    KeyName = "partnerNamespaceName",
    SegmentName = "partnerNamespaces",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PartnerNamespaces {
  /**
   * Get properties of a partner namespace.
   */
  @summary("Get a partner namespace.")
  get is ArmResourceRead<PartnerNamespace>;

  /**
   * Asynchronously creates a new partner namespace with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create a partner namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PartnerNamespace,
    Response = ArmResourceCreatedResponse<
      PartnerNamespace,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Asynchronously updates a partner namespace with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update a partner namespace.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PartnerNamespace,
    PatchModel = PartnerNamespaceUpdateParameters,
    Response = OkResponse | ArmResourceCreatedResponse<
      PartnerNamespace,
      LroHeaders = ArmLroLocationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Delete existing partner namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a partner namespace.")
  delete is ArmResourceDeleteWithoutOkAsync<
    PartnerNamespace,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the partner namespaces under a resource group.
   */
  @summary("List partner namespaces under a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    PartnerNamespace,
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
    Response = ArmResponse<PartnerNamespacesListResult>
  >;

  /**
   * List all the partner namespaces under an Azure subscription.
   */
  @summary("List partner namespaces under an Azure subscription.")
  listBySubscription is ArmListBySubscription<
    PartnerNamespace,
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
    Response = ArmResponse<PartnerNamespacesListResult>
  >;

  /**
   * List the two keys used to publish to a partner namespace.
   */
  @summary("List keys for a partner namespace.")
  @action("listKeys")
  listSharedAccessKeys is ArmResourceActionSync<
    PartnerNamespace,
    void,
    ArmResponse<PartnerNamespaceSharedAccessKeys>
  >;

  /**
   * Regenerate a shared access key for a partner namespace.
   */
  @summary("Regenerate key for a partner namespace.")
  regenerateKey is ArmResourceActionSync<
    PartnerNamespace,
    PartnerNamespaceRegenerateKeyRequest,
    ArmResponse<PartnerNamespaceSharedAccessKeys>
  >;
}

@@doc(PartnerNamespace.name, "Name of the partner namespace.");
@@doc(PartnerNamespace.properties, "Properties of the Partner Namespace.");
@@doc(PartnerNamespaces.createOrUpdate::parameters.resource,
  "PartnerNamespace information."
);
@@doc(PartnerNamespaces.update::parameters.properties,
  "Partner namespace update information."
);
@@doc(PartnerNamespaces.regenerateKey::parameters.body,
  "Request body to regenerate key."
);
