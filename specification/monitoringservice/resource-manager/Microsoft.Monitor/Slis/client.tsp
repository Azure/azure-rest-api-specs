import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API was moved to its own service."
namespace Microsoft.Monitor;

// Hide sliSignalPreview from all SDK generations.
// @@access targets operations, so we mark the single operation inside SloView
// as internal. The Slis interface remains public.
@@access(SloView.sliSignalPreview, Access.internal);
