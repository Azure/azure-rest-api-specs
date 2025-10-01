import "../Normalized Contract/StandardizedContracts/AssessmentProperties.tsp";
import "../Normalized Contract/StandardizedContracts/Scope.tsp";
import "../Normalized Contract/ArmModels/AssessmentProjectV2.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("SQL Assessment REST resource.")
@parentResource(AssessmentProject)
model SqlAssessmentV3 is ProxyResource<SqlAssessmentV3Properties> {
  @doc("SQL Assessment arm name.")
  @key("assessmentName")
  @segment("sqlAssessments")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

@doc("SQL assessment properties class.")
model SqlAssessmentV3Properties
  is AssessmentProperties<Scope, SqlAssessmentSettings, AssessmentDetails> {
  @doc("Gets or sets the machine assessment ARM ID for VM fallback.")
  fallbackMachineAssessmentArmId?: string;
}

@doc("SQL assessment settings class.")
model SqlAssessmentSettings is AssessmentSettings {
  @doc("Gets or sets user configurable setting to display the azure hybrid use benefit.")
  osLicense?: OsLicense;

  @doc("""
    Gets or sets the duration for which the entity (SQL, VMs) are up in the
    on-premises environment.
    """)
  entityUptime?: EntityUptime;

  @doc("Gets or sets SQL the preferred azure targets.")
  preferredTargets?: AzureTarget[];

  @doc("Gets or sets user configurable SQL managed instance settings.")
  azureSqlManagedInstanceSettings?: SqlMiSettingsV3;

  @doc("Gets or sets user configurable SQL database settings.")
  azureSqlDatabaseSettings?: SqlDbSettingsV3;

  @doc("Gets or sets user configurable SQL VM settings.")
  azureSqlVmSettings?: SqlVmSettings;

  @doc("Gets or sets user preference indicating intent of multi-subnet configuration.")
  multiSubnetIntent?: MultiSubnetIntent;

  @doc("Gets or sets user preference indicating intent of async commit mode.")
  asyncCommitModeIntent?: AsyncCommitModeIntent;

  @doc("Gets or sets a value indicating whether internet access is available.")
  isInternetAccessAvailable?: boolean;

  @doc("""
    Gets or sets the Azure Location or Azure region where to which the machines
    will be migrated.
    """)
  disasterRecoveryLocation?: AzureLocation;

  @doc("Gets or sets a value indicating whether HADR assessments needs to be created.")
  enableHadrAssessment?: boolean;

  @doc("Gets or sets a value indicating azure security offering type.")
  azureSecurityOfferingType?: AzureSecurityOfferingType;

  @doc("SQL server license.")
  sqlServerLicense?: SqlServerLicense;
}
