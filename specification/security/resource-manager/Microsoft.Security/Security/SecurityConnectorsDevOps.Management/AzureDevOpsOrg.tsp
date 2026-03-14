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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
alias AzureDevOpsOrgOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";

    /** The security connector name. */
    @path
    @segment("securityConnectors")
    @key
    securityConnectorName: string;

    @path
    @segment("devops")
    @key
    devop: "default";
  },
  {
    @path
    @segment("azureDevOpsOrgs")
    @key
    orgName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface AzureDevOpsOrgs {
  /**
   * Returns a monitored Azure DevOps organization resource.
   */
  @summary("Returns a monitored Azure DevOps organization resource.")
  @tag("DevOps")
  get is AzureDevOpsOrgOps.Read<AzureDevOpsOrg>;

  /**
   * Creates or updates monitored Azure DevOps organization details.
   */
  @summary("Creates or updates monitored Azure DevOps organization details.")
  @tag("DevOps")
  createOrUpdate is AzureDevOpsOrgOps.CreateOrUpdateAsync<AzureDevOpsOrg>;

  /**
   * Updates monitored Azure DevOps organization details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates monitored Azure DevOps organization details.")
  @tag("DevOps")
  @patch(#{ implicitOptionality: false })
  update is AzureDevOpsOrgOps.CustomPatchAsync<
    AzureDevOpsOrg,
    PatchModel = AzureDevOpsOrg,
    Response = ArmResponse<AzureDevOpsOrg> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AzureDevOpsOrg> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AzureDevOpsOrg;
    })
  >;

  /**
   * Returns a list of Azure DevOps organizations onboarded to the connector.
   */
  @summary("Returns a list of Azure DevOps organizations onboarded to the connector.")
  @tag("DevOps")
  list is AzureDevOpsOrgOps.List<
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
