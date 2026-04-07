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
