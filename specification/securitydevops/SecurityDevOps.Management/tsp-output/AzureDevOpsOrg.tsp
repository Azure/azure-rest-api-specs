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
/**
 * Azure DevOps Org Proxy Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AzureDevOpsConnector)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AzureDevOpsOrgProperties)
model AzureDevOpsOrg extends ProxyResourceBase {
  /**
   * Name of the AzureDevOps Org.
   */
  @path
  @key("azureDevOpsOrgName")
  @segment("orgs")
  @visibility("read")
  name: string;

  /**
   * AzureDevOps Org properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AzureDevOpsOrgProperties;
}

@armResourceOperations
interface AzureDevOpsOrgs {
  /**
   * Returns a monitored AzureDevOps Org resource for a given ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsOrg_Get")
  get is ArmResourceRead<AzureDevOpsOrg>;

  /**
   * Creates or updates an Azure DevOps Org.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AzureDevOpsOrg_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AzureDevOpsOrg,
    BaseParameters<AzureDevOpsOrg>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update monitored AzureDevOps Org details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
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
