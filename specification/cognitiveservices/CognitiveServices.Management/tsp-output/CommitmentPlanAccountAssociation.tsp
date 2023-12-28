import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CognitiveServices;
@doc("The commitment plan association.")
model CommitmentPlanAccountAssociation
  is ProxyResource<CommitmentPlanAccountAssociationProperties> {
  @doc("The name of the commitment plan association with the Cognitive Services Account")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @key("commitmentPlanAssociationName")
  @segment("accountAssociations")
  name: string;

  @doc("Resource Etag.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface CommitmentPlans {
  @doc("Gets the association of the Cognitive Services commitment plan.")
  getAssociation is ArmResourceRead<CommitmentPlanAccountAssociation>;
  @doc("Create or update the association of the Cognitive Services commitment plan.")
  createOrUpdateAssociation is ArmResourceCreateOrUpdateAsync<CommitmentPlanAccountAssociation>;
  @doc("Deletes the association of the Cognitive Services commitment plan.")
  deleteAssociation is ArmResourceDeleteAsync<CommitmentPlanAccountAssociation>;
  @doc("Gets the associations of the Cognitive Services commitment plan.")
  listAssociations is ArmResourceListByParent<CommitmentPlanAccountAssociation>;
}
