import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API was moved to its own service."
namespace Microsoft.Monitor;

// Mark SloView preview operations and their exclusively-used models as internal.
// Shared models (EvaluationType, BaselineProperties, Signal, etc.) remain public
// because they are also used by the public Slis interface.
@@access(Access.internal, SloView.sliSignalPreview);
@@access(Access.internal, SignalPreviewSliProperties);
@@access(Access.internal, PreviewType);
@@access(Access.internal, KqlmQueryResult);
