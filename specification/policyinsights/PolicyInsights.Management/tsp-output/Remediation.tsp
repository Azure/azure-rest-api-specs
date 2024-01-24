import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PolicyInsights;
/**
 * The remediation definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(RemediationProperties)
@includeInapplicableMetadataInPayload(false)
model Remediation extends ExtensionResourceBase {
  /**
   * The name of the remediation.
   */
  @path
  @key("remediationName")
  @segment("remediations")
  name: string;

  /**
   * Properties for the remediation.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RemediationProperties;
}

@armResourceOperations
interface Remediations {
  /**
   * Gets an existing remediation at resource scope.
   */
  getAtResource is ArmResourceRead<Remediation>;

  /**
   * Creates or updates a remediation at resource scope.
   */
  createOrUpdateAtResource is ArmResourceCreateOrReplaceSync<Remediation>;

  /**
   * Deletes an existing remediation at individual resource scope.
   */
  deleteAtResource is ArmResourceDeleteSync<Remediation>;

  /**
   * Gets all remediations for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Remediations_ListForResource")
  listForResource is ArmResourceListByParent<
    Remediation,
    {
      ...BaseParameters<Remediation>;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    }
  >;

  /**
   * Gets all deployments for a remediation at resource scope.
   */
  listDeploymentsAtResource is ArmResourceActionSync<
    Remediation,
    void,
    RemediationDeploymentsListResult,
    {
      ...BaseParameters<Remediation>;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;
    }
  >;

  /**
   * Cancel a remediation at resource scope.
   */
  cancelAtResource is ArmResourceActionSync<Remediation, void, Remediation>;
}

@@projectedName(Remediations.createOrUpdateAtResource::parameters.resource,
  "json",
  "parameters"
);
@@extension(Remediations.createOrUpdateAtResource::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Remediations.createOrUpdateAtResource::parameters.resource,
  "The remediation parameters."
);
