using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * A DB2 job configurations associated with SAP monitor.
 */
@parentResource(Monitor)
model Db2JobConfiguration
  is Azure.ResourceManager.ProxyResource<Db2JobConfigurationsProperties> {
  ...ResourceNameParameter<
    Resource = Db2JobConfiguration,
    KeyName = "jobConfigurationName",
    SegmentName = "db2JobConfigurations",
    NamePattern = "^[a-zA-Z0-9-_]+$"
  >;
}

@armResourceOperations
interface Db2JobConfigurations {
  /**
   * Gets db2 job configuration for the specified subscription, resource group, SAP monitor name and job configurations name.
   */
  get is ArmResourceRead<Db2JobConfiguration>;

  /**
   * Create db2 job configuration for the specified subscription, resource group, SAP monitor name and job configurations Name
   */
  create is ArmResourceCreateOrReplaceAsync<Db2JobConfiguration>;

  /**
   * Delete db2 job configuration for the specified subscription, resource group, SAP monitor name, and job configurations Name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Db2JobConfiguration>;

  /**
   * Gets a list of DB2 job configurations in the specified SAP monitor. The operations returns various properties of each DB2 job configurations.
   */
  list is ArmResourceListByParent<Db2JobConfiguration>;
}

@@doc(Db2JobConfiguration.name, "Name of the job configuration.");
@@doc(Db2JobConfiguration.properties, "DB2 job configurations properties");
@@doc(Db2JobConfigurations.create::parameters.resource,
  "Request body representing a DB2 job configurations"
);
