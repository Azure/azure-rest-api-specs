using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Oracle.Database;

@doc("DbSystemShape resource definition")
@parentResource(SubscriptionLocationResource)
model DbSystemShape is ProxyResource<DbSystemShapeProperties> {
  @doc("DbSystemShape name")
  @key("dbsystemshapename")
  @path
  @segment("dbSystemShapes")
  @pattern(".*")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@doc("DbSystemShape resource model")
model DbSystemShapeProperties {
  @doc("The family of the shape used for the DB system.")
  @minLength(1)
  @maxLength(255)
  shapeFamily?: string;

  @doc("The maximum number of CPU cores that can be enabled on the DB system for this shape.")
  availableCoreCount: int32;

  @doc("The minimum number of CPU cores that can be enabled on the DB system for this shape.")
  minimumCoreCount?: int32;

  @doc("The runtime minimum number of CPU cores that can be enabled on the DB system for this shape.")
  runtimeMinimumCoreCount?: int32;

  @doc("The discrete number by which the CPU core count for this shape can be increased or decreased.")
  coreCountIncrement?: int32;

  @doc("The minimum number of Exadata storage servers available for the Exadata infrastructure.")
  minStorageCount?: int32;

  @doc("The maximum number of Exadata storage servers available for the Exadata infrastructure.")
  maxStorageCount?: int32;

  @doc("The maximum data storage available per storage server for this shape. Only applicable to ExaCC Elastic shapes.")
  availableDataStoragePerServerInTbs?: float64;

  @doc("The maximum memory available per database node for this shape. Only applicable to ExaCC Elastic shapes.")
  availableMemoryPerNodeInGbs?: int32;

  @doc("The maximum Db Node storage available per database node for this shape. Only applicable to ExaCC Elastic shapes.")
  availableDbNodePerNodeInGbs?: int32;

  @doc("The minimum number of CPU cores that can be enabled per node for this shape.")
  minCoreCountPerNode?: int32;

  @doc("The maximum memory that can be enabled for this shape.")
  availableMemoryInGbs?: int32;

  @doc("The minimum memory that need be allocated per node for this shape.")
  minMemoryPerNodeInGbs?: int32;

  @doc("The maximum Db Node storage that can be enabled for this shape.")
  availableDbNodeStorageInGbs?: int32;

  @doc("The minimum Db Node storage that need be allocated per node for this shape.")
  minDbNodeStoragePerNodeInGbs?: int32;

  @doc("The maximum DATA storage that can be enabled for this shape.")
  availableDataStorageInTbs?: int32;

  @doc("The minimum data storage that need be allocated for this shape.")
  minDataStorageInTbs?: int32;

  @doc("The minimum number of database nodes available for this shape.")
  minimumNodeCount?: int32;

  @doc("The maximum number of database nodes available for this shape.")
  maximumNodeCount?: int32;

  @doc("The maximum number of CPU cores per database node that can be enabled for this shape. Only applicable to the flex Exadata shape and ExaCC Elastic shapes.")
  availableCoreCountPerNode?: int32;
}
