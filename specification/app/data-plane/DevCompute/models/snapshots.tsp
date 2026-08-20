using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

model SandboxSourceSnapshotView {
  id: SnapshotId;
}

scalar SnapshotId;

model SnapshotPodContainerView {
  name: PodContainerName;
  diskImageId: DiskImageId;
}

model SnapshotRequest {
  labels?: null | Record<string>;
}

model SnapshotResourcesView {
  @oneOf cpu?: null | CpuQuantity;
  @oneOf memory?: null | MemoryQuantity;
  @oneOf disk?: null | StorageQuantity;

  @removed(Versions.v2026_09_01)
  @oneOf
  gpu?: null | SnapshotGpuView;
}

model SnapshotResponseView {
  id: string;
  labels?: Record<string>;
  @oneOf sandboxId?: null | SandboxId;

  @removed(Versions.v2026_09_01)
  @oneOf
  vmmType?: null | VmmType;

  createdAtUtc: utcDateTime;
  @oneOf resources?: null | SnapshotResourcesView;
  sourcePodContainers?: null | SnapshotPodContainerView[];
  @oneOf sizeInMB?: null | MegaBytes;
}

@removed(Versions.v2026_09_01)
model SnapshotGpuView {
  sku?: null | string;
  quantity?: null | string;
}
