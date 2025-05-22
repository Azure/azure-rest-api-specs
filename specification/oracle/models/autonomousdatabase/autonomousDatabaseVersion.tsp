import "../common.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Oracle.Database;

//https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDbVersionSummary

@doc("AutonomousDbVersion resource definition")
@parentResource(SubscriptionLocationResource)
model AutonomousDbVersion is ProxyResource<AutonomousDbVersionProperties> {
  @doc("AutonomousDbVersion name")
  @key("autonomousdbversionsname")
  @path
  @segment("autonomousDbVersions")
  @pattern(".*")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@doc("AutonomousDbVersion resource model")
model AutonomousDbVersionProperties {
  @doc("Supported Autonomous Db versions.")
  @visibility("read")
  @minLength(1)
  @maxLength(255)
  version?: string;

  @doc("The Autonomous Database workload type")
  @visibility("read")
  dbWorkload?: WorkloadType;

  @doc("True if this version of the Oracle Database software's default is free.")
  @visibility("read")
  isDefaultForFree?: boolean;

  @doc("True if this version of the Oracle Database software's default is paid.")
  @visibility("read")
  isDefaultForPaid?: boolean;

  @doc("True if this version of the Oracle Database software can be used for Always-Free Autonomous Databases.")
  @visibility("read")
  isFreeTierEnabled?: boolean;

  @doc("True if this version of the Oracle Database software has payments enabled.")
  @visibility("read")
  isPaidEnabled?: boolean;
}
