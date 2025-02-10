using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Oracle.Database;

//https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabaseCharacterSets

@doc("AutonomousDatabaseCharacterSets resource definition")
@parentResource(SubscriptionLocationResource)
model AutonomousDatabaseCharacterSet
  is ProxyResource<AutonomousDatabaseCharacterSetProperties> {
  @doc("AutonomousDatabaseCharacterSet name")
  @key("adbscharsetname")
  @path
  @segment("autonomousDatabaseCharacterSets")
  @pattern(".*")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@doc("AutonomousDatabaseCharacterSet resource model")
model AutonomousDatabaseCharacterSetProperties {
  @doc("The Oracle Autonomous Database supported character sets.")
  @minLength(1)
  @maxLength(255)
  characterSet: string;
}
