import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ResourceRecommendationBase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Advisor;
/**
 * The details of the snoozed or dismissed rule; for example, the duration, name, and GUID associated with the rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ResourceRecommendationBase)
@Azure.ResourceManager.Private.armResourceInternal(SuppressionProperties)
@includeInapplicableMetadataInPayload(false)
model SuppressionContract extends TrackedResourceBase {
  /**
   * The name of the suppression.
   */
  @path
  @key("name")
  @segment("suppressions")
  name: string;

  /**
   * The properties of the suppression.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SuppressionProperties;
}

@armResourceOperations
interface SuppressionContracts {
  /**
   * Obtains the details of a suppression.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Suppressions_Get")
  get is ArmResourceRead<SuppressionContract>;

  /**
   * Enables the snoozed or dismissed attribute of a recommendation. The snoozed or dismissed attribute is referred to as a suppression. Use this API to create or update the snoozed or dismissed status of a recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Suppressions_Create")
  create is ArmResourceCreateOrReplaceSync<SuppressionContract>;

  /**
   * Enables the activation of a snoozed or dismissed recommendation. The snoozed or dismissed attribute of a recommendation is referred to as a suppression.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Suppressions_Delete")
  delete is ArmResourceDeleteSync<SuppressionContract>;

  /**
   * Retrieves the list of snoozed or dismissed suppressions for a subscription. The snoozed or dismissed attribute of a recommendation is referred to as a suppression.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Suppressions_List")
  list is ArmListBySubscription<SuppressionContract>;
}

@@projectedName(SuppressionContracts.create::parameters.resource,
  "json",
  "suppressionContract"
);
@@extension(SuppressionContracts.create::parameters.resource,
  "x-ms-client-name",
  "suppressionContract"
);
@@doc(SuppressionContracts.create::parameters.resource,
  "The snoozed or dismissed attribute; for example, the snooze duration."
);
