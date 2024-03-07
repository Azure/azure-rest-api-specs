// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("The job cost billed by the provider. The final cost on your bill might be slightly different due to added taxes and currency conversion rates.")
model CostEstimate {
  @doc("The currency code.")
  currencyCode: string;

  @doc("List of usage events.")
  events?: UsageEvent[];

  @doc("The estimated total.")
  estimatedTotal: float32;
}

@doc("Usage event details.")
model UsageEvent {
  @doc("The dimension id.")
  dimensionId: string;

  @doc("The dimension name.")
  dimensionName: string;

  @doc("The unit of measure.")
  measureUnit: string;

  @doc("The amount billed.")
  amountBilled: float32;

  @doc("The amount consumed.")
  amountConsumed: float32;

  @doc("The unit price.")
  unitPrice: float32;
}
