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
 * Namespace resource.
 */
model Namespace is Azure.ResourceManager.TrackedResource<NamespaceProperties> {
  ...ResourceNameParameter<
    Resource = Namespace,
    KeyName = "namespaceName",
    SegmentName = "namespaces",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * Represents available Sku pricing tiers.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: NamespaceSku;

  /**
   * Identity information for the Namespace resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityInfo;
}

@armResourceOperations
interface Namespaces {
  /**
   * Get properties of a namespace.
   */
  @summary("Get a namespace.")
  get is ArmResourceRead<Namespace>;

  /**
   * Asynchronously creates or updates a new namespace with the specified parameters.
   */
  @summary("Create or update a namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Namespace>;

  /**
   * Asynchronously updates a namespace with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @summary("Update a namespace.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Namespace,
    PatchModel = NamespaceUpdateParameters,
    Response = ArmResponse<Namespace> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Namespace> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Namespace;
    })
  >;

  /**
   * Delete existing namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a namespace.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Namespace,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the namespaces under a resource group.
   */
  @summary("List namespaces under a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Namespace,
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
    Response = ArmResponse<NamespacesListResult>
  >;

  /**
   * List all the namespaces under an Azure subscription.
   */
  @summary("List namespaces under an Azure subscription.")
  listBySubscription is ArmListBySubscription<
    Namespace,
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
    Response = ArmResponse<NamespacesListResult>
  >;

  /**
   * List the two keys used to publish to a namespace.
   */
  @summary("List keys for a namespace.")
  @action("listKeys")
  listSharedAccessKeys is ArmResourceActionSync<
    Namespace,
    void,
    ArmResponse<NamespaceSharedAccessKeys>
  >;

  /**
   * Regenerate a shared access key for a namespace.
   */
  @summary("Regenerate key for a namespace.")
  regenerateKey is ArmResourceActionAsync<
    Namespace,
    NamespaceRegenerateKeyRequest,
    NamespaceSharedAccessKeys
  >;

  /**
   * Performs ownership validation via checking TXT records for all custom domains in a namespace.
   */
  @summary("Validate ownership for all custom domains in a namespace.")
  validateCustomDomainOwnership is ArmResourceActionAsync<
    Namespace,
    void,
    CustomDomainOwnershipValidationResult
  >;
}

@@maxLength(Namespace.name, 50);
@@minLength(Namespace.name, 3);
@@doc(Namespace.name, "Name of the namespace.");
@@doc(Namespace.properties, "Properties of the Namespace resource.");
@@doc(Namespaces.createOrUpdate::parameters.resource, "Namespace information.");
@@doc(Namespaces.update::parameters.properties,
  "Namespace update information."
);
@@doc(Namespaces.regenerateKey::parameters.body,
  "Request body to regenerate key."
);
