import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The integration account agreement.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(IntegrationAccount)
@Azure.ResourceManager.Private.armResourceInternal(
  IntegrationAccountAgreementProperties
)
@includeInapplicableMetadataInPayload(false)
model IntegrationAccountAgreement extends Resource {
  /**
   * The integration account agreement name.
   */
  @path
  @key("agreementName")
  @segment("agreements")
  name: string;

  /**
   * The integration account agreement properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: IntegrationAccountAgreementProperties;
}

@armResourceOperations
interface IntegrationAccountAgreements {
  /**
   * Gets an integration account agreement.
   */
  get is ArmResourceRead<IntegrationAccountAgreement>;

  /**
   * Creates or updates an integration account agreement.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountAgreement>;

  /**
   * Deletes an integration account agreement.
   */
  delete is ArmResourceDeleteSync<IntegrationAccountAgreement>;

  /**
   * Gets a list of integration account agreements.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountAgreements_List")
  list is ArmResourceListByParent<
    IntegrationAccountAgreement,
    {
      ...BaseParameters<IntegrationAccountAgreement>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. Options for filters include: AgreementType.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Get the content callback url.
   */
  listContentCallbackUrl is ArmResourceActionSync<
    IntegrationAccountAgreement,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl
  >;
}

@@projectedName(IntegrationAccountAgreements.createOrUpdate::parameters.resource,
  "json",
  "agreement"
);
@@extension(IntegrationAccountAgreements.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "agreement"
);
@@doc(IntegrationAccountAgreements.createOrUpdate::parameters.resource,
  "The integration account agreement."
);
@@projectedName(IntegrationAccountAgreements.listContentCallbackUrl::parameters.body,
  "json",
  "listContentCallbackUrl"
);
@@extension(IntegrationAccountAgreements.listContentCallbackUrl::parameters.body,
  "x-ms-client-name",
  "listContentCallbackUrl"
);
@@doc(IntegrationAccountAgreements.listContentCallbackUrl::parameters.body, "");
