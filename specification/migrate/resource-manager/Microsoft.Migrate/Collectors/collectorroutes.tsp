import "./WebModels/HyperVCollector.tsp";
import "./WebModels/VmwareCollector.tsp";
import "./WebModels/ServerCollector.tsp";
import "./WebModels/ImportCollector.tsp";
import "./WebModels/SqlCollector.tsp";
import "./WebModels/ImportSqlCollector.tsp";
import "./WebModels/WebAppCollector.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface HypervCollectorsOperations {
  @added(CollectorApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<HypervCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<HypervCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<HypervCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<HypervCollector>;
}

@armResourceOperations
interface VmwareCollectorsOperations {
  @added(CollectorApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<VmwareCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<VmwareCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<VmwareCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<VmwareCollector>;
}

@armResourceOperations
interface ServerCollectorsOperations {
  @added(CollectorApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<ServerCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<ServerCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<ServerCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<ServerCollector>;
}

@armResourceOperations
interface ImportCollectorsOperations {
  @added(CollectorApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<ImportCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<ImportCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<ImportCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<ImportCollector>;
}

@armResourceOperations
interface SqlCollectorOperations {
  @added(CollectorApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<SqlCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<SqlCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<SqlCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<SqlCollector>;
}

@armResourceOperations
interface ImportSqlCollectorOperations {
  @added(CollectorApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<ImportSqlCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<ImportSqlCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<ImportSqlCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<ImportSqlCollector>;
}

@armResourceOperations
interface WebAppCollectorOperations {
  @added(CollectorApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<WebAppCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<WebAppCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<WebAppCollector>;

  @added(CollectorApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<WebAppCollector>;
}
