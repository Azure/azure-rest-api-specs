import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevOpsConfiguration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Azure DevOps Organization resource.
 */
@parentResource(DevOpsConfiguration)
model AzureDevOpsOrg
  is Azure.ResourceManager.ProxyResource<AzureDevOpsOrgProperties> {
  ...ResourceNameParameter<
    Resource = AzureDevOpsOrg,
    KeyName = "orgName",
    SegmentName = "azureDevOpsOrgs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AzureDevOpsOrgs {
  /**
   * Returns a monitored Azure DevOps organization resource.
   */
  get is ArmResourceRead<AzureDevOpsOrg>;

  /**
   * Creates or updates monitored Azure DevOps organization details.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AzureDevOpsOrg>;

  /**
   * Updates monitored Azure DevOps organization details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AzureDevOpsOrg,
    PatchModel = AzureDevOpsOrg,
    Response = ArmResponse<AzureDevOpsOrg> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = AzureDevOpsOrg> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AzureDevOpsOrg;
    })
  >;

  /**
   * Returns a list of Azure DevOps organizations onboarded to the connector.
   */
  list is ArmResourceListByParent<
    AzureDevOpsOrg,
    Response = ArmResponse<AzureDevOpsOrgListResponse>
  >;
}

@@doc(AzureDevOpsOrg.name, "The Azure DevOps organization name.");
@@doc(AzureDevOpsOrg.properties, "Azure DevOps Organization properties.");
@@doc(AzureDevOpsOrgs.createOrUpdate::parameters.resource,
  "The Azure DevOps organization resource payload."
);
@@doc(AzureDevOpsOrgs.update::parameters.properties,
  "The Azure DevOps organization resource payload."
);
