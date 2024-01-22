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
 * The integration account partner.
 */
@parentResource(IntegrationAccount)
model IntegrationAccountPartner
  is TrackedResource<IntegrationAccountPartnerProperties> {
  /**
   * The integration account partner name.
   */
  @path
  @key("partnerName")
  @segment("partners")
  name: string;
}

@armResourceOperations
interface IntegrationAccountPartners {
  /**
   * Gets an integration account partner.
   */
  get is ArmResourceRead<IntegrationAccountPartner>;

  /**
   * Creates or updates an integration account partner.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountPartner>;

  /**
   * Deletes an integration account partner.
   */
  delete is ArmResourceDeleteSync<IntegrationAccountPartner>;

  /**
   * Gets a list of integration account partners.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountPartners_List")
  list is ArmResourceListByParent<
    IntegrationAccountPartner,
    {
      ...BaseParameters<IntegrationAccountPartner>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. Options for filters include: PartnerType.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Get the content callback url.
   */
  listContentCallbackUrl is ArmResourceActionSync<
    IntegrationAccountPartner,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl
  >;
}

@@projectedName(IntegrationAccountPartners.createOrUpdate::parameters.resource,
  "json",
  "partner"
);
@@extension(IntegrationAccountPartners.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "partner"
);
@@doc(IntegrationAccountPartners.createOrUpdate::parameters.resource,
  "The integration account partner."
);
@@projectedName(IntegrationAccountPartners.listContentCallbackUrl::parameters.body,
  "json",
  "listContentCallbackUrl"
);
@@extension(IntegrationAccountPartners.listContentCallbackUrl::parameters.body,
  "x-ms-client-name",
  "listContentCallbackUrl"
);
@@doc(IntegrationAccountPartners.listContentCallbackUrl::parameters.body, "");
