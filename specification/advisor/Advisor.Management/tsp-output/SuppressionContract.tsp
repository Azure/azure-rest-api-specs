import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ResourceRecommendationBase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Advisor;
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
  @doc("Obtains the details of a suppression.")
  get is ArmResourceRead<SuppressionContract>;
  @doc("Enables the snoozed or dismissed attribute of a recommendation. The snoozed or dismissed attribute is referred to as a suppression. Use this API to create or update the snoozed or dismissed status of a recommendation.")
  create is ArmResourceCreateOrReplaceSync<SuppressionContract>;
  @doc("Enables the activation of a snoozed or dismissed recommendation. The snoozed or dismissed attribute of a recommendation is referred to as a suppression.")
  delete is ArmResourceDeleteSync<SuppressionContract>;
  @doc("Retrieves the list of snoozed or dismissed suppressions for a subscription. The snoozed or dismissed attribute of a recommendation is referred to as a suppression.")
  list is ArmListBySubscription<SuppressionContract>;
}
