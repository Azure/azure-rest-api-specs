import "./Alerts/main.tsp";
import "./AlertsSuppressionRules/main.tsp";
import "./ApiCollections/main.tsp";
import "./Applications/main.tsp";
import "./Assessment/main.tsp";
import "./ATPSettings/main.tsp";
import "./Automations/main.tsp";
import "./ComplianceResults/main.tsp";
import "./DefenderForStorage/main.tsp";
import "./Governance/main.tsp";
import "./HealthReports/main.tsp";
import "./IoTSecurity/main.tsp";
import "./LegacySettings/main.tsp";
import "./Locations/main.tsp";
import "./MdeOnboarding/main.tsp";
import "./Operations/main.tsp";
import "./Pricings/main.tsp";
import "./PrivateLinks/main.tsp";
import "./RegulatoryCompliance/main.tsp";
import "./SecureScore/main.tsp";
import "./SecurityConnectors/main.tsp";
import "./SecurityConnectorsDevOps/main.tsp";
import "./SecurityOperators/main.tsp";
import "./SecuritySolutions/main.tsp";
import "./SecurityStandards/main.tsp";
import "./SensitivitySettings/main.tsp";
import "./ServerVulnerabilityAssessmentsSettings/main.tsp";
import "./Settings/main.tsp";
import "./SqlVulnerabilityAssessments/main.tsp";
import "./Standards/main.tsp";
import "./SubAssessments/main.tsp";
import "./Tasks/main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using Microsoft.Security;

@client({
  name: "SecurityManagementClient",
  service: [Microsoft.Security],
  autoMergeService: true,
})
namespace SecurityManagementClient;

model `private-link-parameters` {
  /**
   * The name of the private link resource.
   */
  @path
  @minLength(3)
  @maxLength(63)
  @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  privateLinkName: string;
}

op privateLinksGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
): ArmResponse<Microsoft.Security.PrivateLinkResource> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResources.get,
  privateLinksGetCustomization
);

op privateLinksCreateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
  resource: Microsoft.Security.PrivateLinkResource,
): ArmResourceUpdatedResponse<Microsoft.Security.PrivateLinkResource> | ArmResourceCreatedResponse<
  Microsoft.Security.PrivateLinkResource,
  ArmAsyncOperationHeader<FinalResult = Microsoft.Security.PrivateLinkResource> &
    Azure.Core.Foundations.RetryAfterHeader
> | ErrorResponse;

@@clientName(privateLinksCreateCustomization::parameters.resource,
  "privateLink"
);
@@Azure.ClientGenerator.Core.override(PrivateLinkResources.create,
  privateLinksCreateCustomization
);

op privateLinksUpdateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
  properties: Microsoft.Security.PrivateLinkUpdate,
): ArmResponse<Microsoft.Security.PrivateLinkResource> | ErrorResponse;

@@clientName(privateLinksUpdateCustomization::parameters.properties,
  "privateLink"
);
@@Azure.ClientGenerator.Core.override(PrivateLinkResources.update,
  privateLinksUpdateCustomization
);

op privateLinksDeleteCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
): ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
  Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResources.delete,
  privateLinksDeleteCustomization
);

op privateLinksHeadCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
): OkResponse | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResources.head,
  privateLinksHeadCustomization
);

op privateEndpointConnectionsListCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
): ArmResponse<ResourceListResult<Microsoft.Security.PrivateEndpointConnection>> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.list,
  privateEndpointConnectionsListCustomization
);

op privateEndpointConnectionsGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
  privateEndpointConnectionName: string,
): ArmResponse<Azure.ResourceManager.PrivateEndpointConnection> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.get,
  privateEndpointConnectionsGetCustomization
);

op privateEndpointConnectionsCreateOrUpdateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
  privateEndpointConnectionName: string,
  resource: Azure.ResourceManager.PrivateEndpointConnection,
): ArmResourceUpdatedResponse<Microsoft.Security.PrivateLinkResource> | ArmResourceCreatedResponse<
  Microsoft.Security.PrivateLinkResource,
  ArmAsyncOperationHeader<FinalResult = Microsoft.Security.PrivateLinkResource> &
    Azure.Core.Foundations.RetryAfterHeader
> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.createOrUpdate,
  privateEndpointConnectionsCreateOrUpdateCustomization
);
@@clientName(privateEndpointConnectionsCreateOrUpdateCustomization::parameters.resource,
  "privateEndpointConnection"
);

op privateEndpointConnectionsDeleteCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
  privateEndpointConnectionName: string,
): ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
  Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.delete,
  privateEndpointConnectionsDeleteCustomization
);

op privateLinkResourcesListCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
): ArmResponse<ResourceListResult<Microsoft.Security.PrivateLinkResourceAutoGenerated>> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResourceAutoGenerateds.list,
  privateLinkResourcesListCustomization
);

op privateLinkResourcesGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
  groupId: string,
): ArmResponse<Microsoft.Security.PrivateLinkResourceAutoGenerated> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResourceAutoGenerateds.get,
  privateLinkResourcesGetCustomization
);
