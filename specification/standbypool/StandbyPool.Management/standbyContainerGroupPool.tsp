// -----------------------------------------------------------------------
// <copyright file="standbyContainerGroupPool.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./service.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.StandbyPool;

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("A StandbyContainerGroupPoolResource.")
model StandbyContainerGroupPoolResource
  is TrackedResource<StandbyContainerGroupPoolResourceProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("standbyContainerGroupPoolName")
  @segment("standbyContainerGroupPools")
  @visibility("read")
  @doc("Name of the standby container group pool")
  @path
  name: string;
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Details of the StandbyContainerGroupPool.")
model StandbyContainerGroupPoolResourceProperties {
  @doc("Specifies elasticity profile of standby container group pools.")
  elasticityProfile: ElasticityProfile;

  @doc("Specifies container group properties of standby container group pools.")
  containerGroupProperties: ContainerGroupProperties;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Details of the ElasticityProfile.")
model ElasticityProfile {
  @doc("Specifies maximum number of standby container groups.")
  @maxValue(2000)
  @minValue(0)
  maxReadyCapacity: int64;

  @doc("Specifies refill policy of the pool.")
  refillPolicy?: RefillPolicy;
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Details of the ContainerGroupProperties.")
model ContainerGroupProperties {
  @doc("Specifies container group profile of standby container groups.")
  containerGroupProfile: ContainerGroupProfile;

  @doc("Specifies subnet Ids for container group.")
  subnetIds?: Subnet[];
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Details of the ContainerGroupProfile.")
model ContainerGroupProfile {
  @doc("Specifies container group profile id of standby container groups.")
  id: string;

  @doc("Specifies revision of container group profile.")
  revision?: int64;
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Refill policy of standby pool")
enum RefillPolicy {
  @doc("A refill policy that standby pool is automatically refilled to maintain maxReadyCapacity.")
  always,
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Subnet of container group")
model Subnet {
  @doc("Specifies ARM resource id of the subnet.")
  id: string;
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@armResourceOperations
interface StandbyContainerGroupPools {
  get is ArmResourceRead<StandbyContainerGroupPoolResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StandbyContainerGroupPoolResource>;
  delete is ArmResourceDeleteWithoutOkAsync<StandbyContainerGroupPoolResource>;
  update is ArmResourcePatchSync<
    StandbyContainerGroupPoolResource,
    StandbyContainerGroupPoolResourceProperties
  >;
  listByResourceGroup is ArmResourceListByParent<StandbyContainerGroupPoolResource>;
  listBySubscription is ArmListBySubscription<StandbyContainerGroupPoolResource>;
}
