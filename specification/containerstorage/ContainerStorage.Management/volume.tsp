import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerStorage;

@armResourceOperations
interface Volumes {
  get is ArmResourceRead<Volume>;
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Volume>;
  delete is ArmResourceDeleteWithoutOkAsync<Volume>;
  update is ArmResourcePatchAsync<Volume, VolumeProperties>;
  listByPool is ArmResourceListByParent<Volume>;
}

@parentResource(Pool)
model Volume is ProxyResource<VolumeProperties> {
  @doc("Volume Resource")
  @minLength(3)
  @maxLength(253)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @key("volumeName")
  @path
  @segment("volumes")
  name: string;
}

@doc("Volume Properties")
model VolumeProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The status of the resource.")
  @visibility("read")
  status?: ResourceOperationalStatus;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("String KV pairs indicating labels")
  labels: Record<string>;

  @doc("Requested capacity in GiB")
  @maxValue(65536)
  @minValue(1)
  capacityGiB: int64;

  @visibility("read")
  @doc("Properties of the volume")
  volumeType?: VolumeType;
}

@doc("Properties of the volume")
model VolumeType {
  @visibility("read")
  @doc("Properties of the ElasticSAN iSCSI target")
  elasticSan?: ElasticSanVolumeProperties;
}

@doc("Properties of the ElasticSAN iSCSI target")
model ElasticSanVolumeProperties {
  @doc("iSCSI Target IQN (iSCSI Qualified Name); example: \"iqn.2005-03.org.iscsi:server\"")
  targetIqn: string;

  @doc("iSCSI Target Portal Host Name")
  targetPortalHostname: string;

  @doc("iSCSI Target Portal Port")
  targetPortalPort: int32;
}
