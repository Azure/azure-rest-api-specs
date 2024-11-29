// -----------------------------------------------------------------------
// <copyright file="standbyContainerGroupPool.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
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
  elasticityProfile: StandbyContainerGroupPoolElasticityProfile;

  @doc("Specifies container group properties of standby container group pools.")
  containerGroupProperties: ContainerGroupProperties;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Specifies the elasticity profile of the standby container group pools.")
model StandbyContainerGroupPoolElasticityProfile {
  @doc("Specifies maximum number of standby container groups in the standby pool.")
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
  id: armResourceIdentifier<[
    {
      type: "Microsoft.ContainerInstance/containerGroupProfiles";
    }
  ]>;

  @doc("Specifies revision of container group profile.")
  revision?: int64;
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Refill policy of standby pool")
union RefillPolicy {
  string,

  @doc("A refill policy that standby pool is automatically refilled to maintain maxReadyCapacity.")
  always: "always",
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Subnet of container group")
model Subnet {
  @doc("Specifies ARM resource id of the subnet.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@armResourceOperations
interface StandbyContainerGroupPools {
  get is ArmResourceRead<StandbyContainerGroupPoolResource>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    StandbyContainerGroupPoolResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<StandbyContainerGroupPoolResource>;
  @parameterVisibility
  update is ArmCustomPatchSync<
    StandbyContainerGroupPoolResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      StandbyContainerGroupPoolResource,
      StandbyContainerGroupPoolResourceProperties
    >
  >;
  listByResourceGroup is ArmResourceListByParent<StandbyContainerGroupPoolResource>;
  listBySubscription is ArmListBySubscription<StandbyContainerGroupPoolResource>;
}
