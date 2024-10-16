using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Oracle.Database;

//https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/autonomous-character-set-selection.html

@doc("AutonomousDatabaseNationalCharacterSets resource definition")
@parentResource(SubscriptionLocationResource)
model AutonomousDatabaseNationalCharacterSet
  is ProxyResource<AutonomousDatabaseNationalCharacterSetProperties> {
  @doc("AutonomousDatabaseNationalCharacterSets name")
  @key("adbsncharsetname")
  @path
  @segment("autonomousDatabaseNationalCharacterSets")
  @pattern(".*")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@doc("AutonomousDatabaseNationalCharacterSet resource model")
model AutonomousDatabaseNationalCharacterSetProperties {
  @doc("The Oracle Autonomous Database supported national character sets.")
  @minLength(1)
  @maxLength(255)
  characterSet: string;
}
