/**
 * PLACEHOLDER
 * Add readme and sample
 */
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Customizations;

// Avoid a C# property-name collision with the enclosing `Schedule` model.
// JSON wire format keeps the original `schedule` name (matches UX clients).
@@clientName(PurviewDataEstateHealth.Schedule.schedule, "recurrence", "csharp");
