import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

import "./ApiVersions.tsp";
import "./WebModels/Waves/MigrationWaves.tsp";
import "./WebModels/MigrationEntity/MigrationEntity.tsp";
import "./WebModels/MigrationEntityGroup/MigrationEntityGroups.tsp";
import "./WebModels/Steps/MigrationSteps.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface Waves {
  @added(ApiVersions.v2025_03_30_preview)
  create is ArmResourceCreateOrUpdateAsync<Wave>;

  @added(ApiVersions.v2025_03_30_preview)
  get is ArmResourceRead<Wave>;

  @added(ApiVersions.v2025_03_30_preview)
  listByParent is ArmResourceListByParent<
    Wave,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      @doc("Skip Token Header.")
      @header
      skipToken?: string;

      @doc("Page Size Query Parameter.")
      @query
      $top?: int32;

      @doc("Filter Query Parameter.")
      @query
      $filter?: string;

      @doc("Total Record Count Query Parameter.")
      @query
      totalRecordCount?: int32;
    }
  >;

  @added(ApiVersions.v2025_03_30_preview)
  delete is ArmResourceDeleteWithoutOkAsync<Wave>;
}

@armResourceOperations
interface MigrationEntities {
  @added(ApiVersions.v2025_03_30_preview)
  create is ArmResourceCreateOrUpdateAsync<MigrationEntity>;

  @added(ApiVersions.v2025_03_30_preview)
  get is ArmResourceRead<MigrationEntity>;

  @added(ApiVersions.v2025_03_30_preview)
  listByParent is ArmResourceListByParent<
    MigrationEntity,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      @doc("Skip Token Header.")
      @header
      skipToken?: string;

      @doc("Page Size Query Parameter.")
      @query
      $top?: int32;

      @doc("Filter Query Parameter.")
      @query
      $filter?: string;

      @doc("Total Record Count Query Parameter.")
      @query
      totalRecordCount?: int32;
    }
  >;

  @added(ApiVersions.v2025_03_30_preview)
  delete is ArmResourceDeleteWithoutOkAsync<MigrationEntity>;
}

@armResourceOperations
interface MigrationEntityGroups {
  @added(ApiVersions.v2025_03_30_preview)
  create is ArmResourceCreateOrUpdateAsync<MigrationEntityGroup>;

  @added(ApiVersions.v2025_03_30_preview)
  get is ArmResourceRead<MigrationEntityGroup>;

  @added(ApiVersions.v2025_03_30_preview)
  listByParent is ArmResourceListByParent<
    MigrationEntityGroup,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      @doc("Skip Token Header.")
      @header
      skipToken?: string;

      @doc("Page Size Query Parameter.")
      @query
      $top?: int32;

      @doc("Filter Query Parameter.")
      @query
      $filter?: string;

      @doc("Total Record Count Query Parameter.")
      @query
      totalRecordCount?: int32;
    }
  >;

  @added(ApiVersions.v2025_03_30_preview)
  delete is ArmResourceDeleteWithoutOkAsync<MigrationEntityGroup>;
}

@armResourceOperations
interface MigrationSteps {
  @added(ApiVersions.v2025_03_30_preview)
  create is ArmResourceCreateOrUpdateAsync<MigrationStep>;

  @added(ApiVersions.v2025_03_30_preview)
  get is ArmResourceRead<MigrationStep>;

  @added(ApiVersions.v2025_03_30_preview)
  listByParent is ArmResourceListByParent<
    MigrationStep,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      @doc("Skip Token Header.")
      @header
      skipToken?: string;

      @doc("Page Size Query Parameter.")
      @query
      $top?: int32;

      @doc("Filter Query Parameter.")
      @query
      $filter?: string;

      @doc("Total Record Count Query Parameter.")
      @query
      totalRecordCount?: int32;
    }
  >;

  @added(ApiVersions.v2025_03_30_preview)
  delete is ArmResourceDeleteWithoutOkAsync<MigrationStep>;
}
