// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";
import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Rest.Resource;
using OpenAPI;

@doc("Provider availability.")
enum ProviderAvailability {
  @doc("Provider is available.")
  Available,

  @doc("Provider is available with degrated experience.")
  Degraded,

  @doc("Provider is unavailable.")
  Unavailable,
}

@doc("Target availability.")
enum TargetAvailability {
  @doc("Target is available.")
  Available,

  @doc("Target is available with degrated experience.")
  Degraded,

  @doc("Target is unavailable.")
  Unavailable,
}

@doc("Provider")
model Provider {
  @visibility("read")
  @doc("Provider id.")
  id: string;
}

@doc("Provider status.")
model ProviderStatus {
  @visibility("read")
  @doc("Provider id.")
  id: string;

  @visibility("read")
  @doc("Current provider availability.")
  currentAvailability: ProviderAvailability;

  @visibility("read")
  @doc("Current target statuses.")
  targets: TargetStatus[];
}

@doc("Target status.")
model TargetStatus {
  @visibility("read")
  @doc("Target id.")
  id: string;

  @visibility("read")
  @doc("Current target availability.")
  currentAvailability: TargetAvailability;

  @visibility("read")
  @doc("Average queue time in seconds.")
  averageQueueTime: int64;

  @visibility("read")
  @doc("A page with detailed status of the provider.")
  statusPage?: string;
}

@doc("List of provider and target statuses.")
model ProviderStatusList {
  ...CollectionWithNextLink<ProviderStatus>;
}

interface ProviderOperations {
  @doc("Get provider status.")
  @get
  @listsResource(ProviderStatus)
  @segment("providerStatus")
  getStatus is ListOperation<ProviderStatusList>;
}
