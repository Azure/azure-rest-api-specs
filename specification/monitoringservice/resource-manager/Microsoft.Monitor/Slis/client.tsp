import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Monitor;

// Hide SloView (sliSignalPreview) operations from public SDK generation.
// The SloView interface and its exclusively-used models (SignalPreviewSliProperties,
// PreviewType, KqlmQueryResult, etc.) will be marked as internal.
// Shared models (EvaluationType, BaselineProperties, Signal, etc.) remain public
// because they are also used by the public Slis interface.
@@access(SloView.sliSignalPreview, Access.internal);
