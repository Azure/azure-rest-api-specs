import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureDevOpsConnector.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityDevOps;
@doc("Azure DevOps Org Proxy Resource.")
@parentResource(AzureDevOpsConnector)
model AzureDevOpsOrg is ProxyResource<AzureDevOpsOrgProperties> {
  @doc("Name of the AzureDevOps Org.")
  @path
  @key("azureDevOpsOrgName")
  @segment("orgs")
  name: string;
}

@armResourceOperations
interface AzureDevOpsOrgs {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a monitored AzureDevOps Org resource for a given ID.")
  @operationId("AzureDevOpsOrg_Get")
  get is ArmResourceRead<AzureDevOpsOrg>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates an Azure DevOps Org.")
  @operationId("AzureDevOpsOrg_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AzureDevOpsOrg,
    BaseParameters<AzureDevOpsOrg>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update monitored AzureDevOps Org details.")
  @operationId("AzureDevOpsOrg_Update")
  update is ArmCustomPatchAsync<AzureDevOpsOrg, AzureDevOpsOrg>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsOrg_List")
  list is ArmResourceListByParent<AzureDevOpsOrg>;
}

@@projectedName(AzureDevOpsOrgs.createOrUpdate::parameters.resource,
  "json",
  "azureDevOpsOrg"
);
@@extension(AzureDevOpsOrgs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "azureDevOpsOrg"
);
@@doc(AzureDevOpsOrgs.createOrUpdate::parameters.resource,
  "Azure DevOps Org resource payload."
);
@@projectedName(AzureDevOpsOrgs.update::parameters.properties,
  "json",
  "azureDevOpsOrg"
);
@@extension(AzureDevOpsOrgs.update::parameters.properties,
  "x-ms-client-name",
  "azureDevOpsOrg"
);
@@doc(AzureDevOpsOrgs.update::parameters.properties,
  "Azure DevOps Org resource payload."
);
