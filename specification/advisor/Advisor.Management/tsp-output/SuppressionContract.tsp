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
@doc("The details of the snoozed or dismissed rule; for example, the duration, name, and GUID associated with the rule.")
@parentResource(ResourceRecommendationBase)
model SuppressionContract is ProxyResource<SuppressionProperties> {
  @doc("The name of the suppression.")
  @path
  @key("name")
  @segment("suppressions")
  name: string;
}

@armResourceOperations
interface SuppressionContracts {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Obtains the details of a suppression.")
  @operationId("Suppressions_Get")
  get is ArmResourceRead<SuppressionContract>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Enables the snoozed or dismissed attribute of a recommendation. The snoozed or dismissed attribute is referred to as a suppression. Use this API to create or update the snoozed or dismissed status of a recommendation.")
  @operationId("Suppressions_Create")
  create is ArmResourceCreateOrReplaceSync<SuppressionContract>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Enables the activation of a snoozed or dismissed recommendation. The snoozed or dismissed attribute of a recommendation is referred to as a suppression.")
  @operationId("Suppressions_Delete")
  delete is ArmResourceDeleteSync<SuppressionContract>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the list of snoozed or dismissed suppressions for a subscription. The snoozed or dismissed attribute of a recommendation is referred to as a suppression.")
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
