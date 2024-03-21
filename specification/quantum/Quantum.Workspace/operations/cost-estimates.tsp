// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

/** The job cost billed by the provider. The final cost on your bill might be slightly different due to added taxes and currency conversion rates. */
model CostEstimate {
  /** The currency code. */
  currencyCode: string;

  /** List of usage events. */
  events?: UsageEvent[];

  /** The estimated total. */
  estimatedTotal: float32;
}

/** Usage event details. */
model UsageEvent {
  /** The dimension id. */
  dimensionId: string;

  /** The dimension name. */
  dimensionName: string;

  /** The unit of measure. */
  measureUnit: string;

  /** The amount billed. */
  amountBilled: float32;

  /** The amount consumed. */
  amountConsumed: float32;

  /** The unit price. */
  unitPrice: float32;
}
