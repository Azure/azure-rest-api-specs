import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureDevOpsProject.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityDevOps;
/**
 * Azure DevOps Repo Proxy Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AzureDevOpsProject)
@Azure.ResourceManager.Private.armResourceInternal(AzureDevOpsRepoProperties)
@includeInapplicableMetadataInPayload(false)
model AzureDevOpsRepo extends ProxyResourceBase {
  /**
   * Name of the AzureDevOps Repo.
   */
  @path
  @key("azureDevOpsRepoName")
  @segment("repos")
  name: string;

  /**
   * AzureDevOps Repo properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureDevOpsRepoProperties;
}

@armResourceOperations
interface AzureDevOpsRepos {
  /**
   * Returns a monitored AzureDevOps Project resource for a given ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsRepo_Get")
  get is ArmResourceRead<AzureDevOpsRepo>;

  /**
   * Updates an Azure DevOps Repo.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsRepo_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AzureDevOpsRepo,
    BaseParameters<AzureDevOpsRepo>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update monitored AzureDevOps Project details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("AzureDevOpsRepo_Update")
  update is ArmCustomPatchAsync<AzureDevOpsRepo, AzureDevOpsRepo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsRepo_List")
  list is ArmResourceListByParent<AzureDevOpsRepo>;
}

@@projectedName(AzureDevOpsRepos.createOrUpdate::parameters.resource,
  "json",
  "azureDevOpsRepo"
);
@@extension(AzureDevOpsRepos.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "azureDevOpsRepo"
);
@@doc(AzureDevOpsRepos.createOrUpdate::parameters.resource,
  "Azure DevOps Repo resource payload."
);
@@projectedName(AzureDevOpsRepos.update::parameters.properties,
  "json",
  "azureDevOpsRepo"
);
@@extension(AzureDevOpsRepos.update::parameters.properties,
  "x-ms-client-name",
  "azureDevOpsRepo"
);
@@doc(AzureDevOpsRepos.update::parameters.properties,
  "Azure DevOps Org resource payload."
);
