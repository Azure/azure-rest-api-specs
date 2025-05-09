import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ContainerStorage;

@armResourceOperations
interface Volumes {
  get is ArmResourceRead<Volume>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DOT NOT COPY - migrate to LRO apis"
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "location" }
  )
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Volume,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Volume>;
  update is ArmCustomPatchAsync<
    Volume,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Volume,
      VolumeProperties
    >
  >;
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
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The status of the resource.")
  @visibility(Lifecycle.Read)
  status?: ResourceOperationalStatus;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("String KV pairs indicating labels")
  labels: Record<string>;

  @doc("Requested capacity in GiB")
  @maxValue(65536)
  @minValue(1)
  capacityGiB: int64;

  @visibility(Lifecycle.Read)
  @doc("Properties of the volume")
  volumeType?: VolumeType;
}

@doc("Properties of the volume")
model VolumeType {
  @visibility(Lifecycle.Read)
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
