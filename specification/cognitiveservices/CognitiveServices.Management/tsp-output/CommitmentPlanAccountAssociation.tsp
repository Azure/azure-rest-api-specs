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

namespace Microsoft.CognitiveServices;
@doc("The commitment plan association.")
model CommitmentPlanAccountAssociation
  is ProxyResource<CommitmentPlanAccountAssociationProperties> {
  @doc("The name of the commitment plan association with the Cognitive Services Account")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("commitmentPlanAssociationName")
  @segment("accountAssociations")
  name: string;

  @doc("Resource Etag.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface CommitmentPlanAccountAssociations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the association of the Cognitive Services commitment plan.")
  @operationId("CommitmentPlans_GetAssociation")
  getAssociation is ArmResourceRead<CommitmentPlanAccountAssociation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the association of the Cognitive Services commitment plan.")
  @operationId("CommitmentPlans_CreateOrUpdateAssociation")
  createOrUpdateAssociation is ArmResourceCreateOrUpdateAsync<
    CommitmentPlanAccountAssociation,
    BaseParameters<CommitmentPlanAccountAssociation>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the association of the Cognitive Services commitment plan.")
  @operationId("CommitmentPlans_DeleteAssociation")
  deleteAssociation is ArmResourceDeleteAsync<
    CommitmentPlanAccountAssociation,
    BaseParameters<CommitmentPlanAccountAssociation>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the associations of the Cognitive Services commitment plan.")
  @operationId("CommitmentPlans_ListAssociations")
  listAssociations is ArmResourceListByParent<CommitmentPlanAccountAssociation>;
}

@@projectedName(CommitmentPlanAccountAssociations.createOrUpdateAssociation::parameters.resource,
  "json",
  "association"
);
@@extension(CommitmentPlanAccountAssociations.createOrUpdateAssociation::parameters.resource,
  "x-ms-client-name",
  "association"
);
@@doc(CommitmentPlanAccountAssociations.createOrUpdateAssociation::parameters.resource,
  "The commitmentPlan properties."
);
