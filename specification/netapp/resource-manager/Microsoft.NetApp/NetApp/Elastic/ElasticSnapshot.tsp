import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./../models.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;

/**
 * NetApp Elastic Snapshot under an Elastic Volume
 */
@added(Versions.v2025_09_01_preview)
@parentResource(ElasticVolume)
model ElasticSnapshot is ProxyResource<ElasticSnapshotProperties> {
  ...ResourceNameParameter<
    Resource = ElasticSnapshot,
    KeyName = "snapshotName",
    SegmentName = "elasticSnapshots",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$"
  >;
}

/**
 * Elastic Snapshot properties
 */
@added(Versions.v2025_09_01_preview)
model ElasticSnapshotProperties {
  /** Azure lifecycle management. */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;
}

@armResourceOperations
interface ElasticSnapshots {
  @added(Versions.v2025_09_01_preview)
  get is ArmResourceRead<ElasticSnapshot>;
  @added(Versions.v2025_09_01_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticSnapshot>;
  @added(Versions.v2025_09_01_preview)
  delete is ArmResourceDeleteWithoutOkAsync<ElasticSnapshot>;
  @added(Versions.v2025_09_01_preview)
  listByElasticVolume is ArmResourceListByParent<ElasticSnapshot>;
}

@@maxLength(ElasticSnapshot.name, 64);
@@minLength(ElasticSnapshot.name, 1);

@@clientName(ElasticSnapshots.createOrUpdate::parameters.resource, "body");
