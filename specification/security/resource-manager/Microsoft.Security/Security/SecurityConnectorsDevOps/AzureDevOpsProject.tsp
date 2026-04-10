import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureDevOpsOrg.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace SecurityConnectorsDevOpsAPI;
/**
 * Azure DevOps Project resource.
 */
@parentResource(AzureDevOpsOrg)
model AzureDevOpsProject
  is Azure.ResourceManager.ProxyResource<AzureDevOpsProjectProperties> {
  ...ResourceNameParameter<
    Resource = AzureDevOpsProject,
    KeyName = "projectName",
    SegmentName = "projects",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
alias AzureDevOpsProjectOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    @path
    @segment("azureDevOpsOrgs")
    @key
    orgName: string;
  },
  {
    @path
    @segment("projects")
    @key
    projectName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface AzureDevOpsProjects {
  /**
   * Returns a monitored Azure DevOps project resource.
   */
  @summary("Returns a monitored Azure DevOps project resource.")
  @tag("DevOps")
  get is AzureDevOpsProjectOps.Read<AzureDevOpsProject>;

  /**
   * Creates or updates a monitored Azure DevOps project resource.
   */
  @summary("Creates or updates a monitored Azure DevOps project resource.")
  @tag("DevOps")
  createOrUpdate is AzureDevOpsProjectOps.CreateOrUpdateAsync<AzureDevOpsProject>;

  /**
   * Updates a monitored Azure DevOps project resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates a monitored Azure DevOps project resource.")
  @tag("DevOps")
  @patch(#{ implicitOptionality: false })
  update is AzureDevOpsProjectOps.CustomPatchAsync<
    AzureDevOpsProject,
    PatchModel = AzureDevOpsProject,
    Response = ArmResponse<AzureDevOpsProject> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = AzureDevOpsProject> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AzureDevOpsProject;
    })
  >;

  /**
   * Returns a list of Azure DevOps projects onboarded to the connector.
   */
  @summary("Returns a list of Azure DevOps projects onboarded to the connector.")
  @tag("DevOps")
  list is AzureDevOpsProjectOps.List<
    AzureDevOpsProject,
    Response = ArmResponse<AzureDevOpsProjectListResponse>
  >;
}

@@doc(AzureDevOpsProject.name, "The project name.");
@@doc(AzureDevOpsProject.properties, "Azure DevOps Project properties.");
@@doc(AzureDevOpsProjects.createOrUpdate::parameters.resource,
  "The Azure DevOps project resource payload."
);
@@doc(AzureDevOpsProjects.update::parameters.properties,
  "The Azure DevOps project resource payload."
);

