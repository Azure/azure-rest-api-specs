import "../common.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Oracle.Database;

@added(Versions.v20250701_preview)
scalar DbSystemResourceId
  extends armResourceIdentifier<[
    {
      type: "Oracle.Database/dbSystems",
    }
  ]>;

//https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/DbVersionSummary/
@added(Versions.v20250701_preview)
@doc("Oracle Database DbVersion resource definition")
@parentResource(SubscriptionLocationResource)
model DbVersion is ProxyResource<DbVersionProperties> {
  @doc("DbVersion name")
  @key("dbversionsname")
  @path
  @segment("dbSystemDbVersions")
  @pattern(".*")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@added(Versions.v20250701_preview)
@doc("DbVersion resource model")
model DbVersionProperties {
  @doc("A valid Oracle Database version.")
  @minLength(1)
  @maxLength(255)
  version: string;

  @doc("True if this version of the Oracle Database software is the latest version for a release.")
  isLatestForMajorVersion?: boolean;

  @doc("True if this version of the Oracle Database software is the preview version.")
  isPreviewDbVersion?: boolean;

  @doc("True if this version of the Oracle Database software is supported for Upgrade.")
  isUpgradeSupported?: boolean;

  @doc("True if this version of the Oracle Database software supports pluggable databases.")
  supportsPdb?: boolean;
}

@added(Versions.v20250701_preview)
@doc("Provides DbVersion query parameter for list operations.")
model DbVersionFilter {
  @query
  @doc("If provided, filters the results to the set of database versions which are supported for the given shape. e.g., VM.Standard.E5.Flex")
  @minLength(1)
  @maxLength(255)
  dbSystemShape?: BaseDbSystemShapes;

  @query
  @doc("The DB system AzureId. If provided, filters the results to the set of database versions which are supported for the DB system.")
  dbSystemId?: DbSystemResourceId;

  @query
  @doc("The DB system storage management option. Used to list database versions available for that storage manager. Valid values are ASM and LVM.")
  storageManagement?: StorageManagementType;

  @query
  @doc("If true, filters the results to the set of database versions which are supported for Upgrade.")
  isUpgradeSupported?: boolean;

  @query
  @doc("If true, filters the results to the set of Oracle Database versions that are supported for the database software images.")
  isDatabaseSoftwareImageSupported?: boolean;

  @query
  @doc("If provided, filters the results to the set of database versions which are supported for the given shape family.")
  shapeFamily?: ShapeFamilyType;
}
