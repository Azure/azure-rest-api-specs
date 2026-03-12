import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Namespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * The CA Certificate resource.
 */
@parentResource(Namespace)
model CaCertificate
  is Azure.ResourceManager.ProxyResource<CaCertificateProperties> {
  ...ResourceNameParameter<
    Resource = CaCertificate,
    KeyName = "caCertificateName",
    SegmentName = "caCertificates",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface CaCertificates {
  /**
   * Get properties of a CA certificate.
   */
  @summary("Get a CA certificate.")
  get is ArmResourceRead<CaCertificate>;

  /**
   * Create or update a CA certificate with the specified parameters.
   */
  @summary("Create or update a CA certificate.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CaCertificate>;

  /**
   * Delete an existing CA certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a CA certificate.")
  delete is ArmResourceDeleteWithoutOkAsync<
    CaCertificate,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the CA certificates under a namespace.
   */
  @summary("List all CA certificates under a namespace.")
  listByNamespace is ArmResourceListByParent<
    CaCertificate,
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
    Response = ArmResponse<CaCertificatesListResult>
  >;
}

@@maxLength(CaCertificate.name, 50);
@@minLength(CaCertificate.name, 3);
@@doc(CaCertificate.name, "Name of the CA certificate.");
@@doc(CaCertificate.properties, "The properties of CA certificate.");
@@doc(CaCertificates.createOrUpdate::parameters.resource,
  "CA certificate information."
);
