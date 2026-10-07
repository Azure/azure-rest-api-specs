import "@typespec/http";
import "@azure-tools/typespec-azure-core";

import "./scalars.tsp";
import "./pagination.tsp";
import "./errors.tsp";
import "./foundations.tsp";
import "./jobs.tsp";

/** Shared definitions for Azure AI Foundry. */
namespace Microsoft.Foundry.Core;
