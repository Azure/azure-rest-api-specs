import "@typespec/rest";
import "../../VDI.BatchRegistration/models/registration.tsp";

using TypeSpec.Rest;
using VdiBatchRegistration;

namespace VdiVideoAnalysis;

@doc("Video Analysis Task definition to be used with the Registration Service")
model VideoAnalysisRegistration is AiTaskConfiguration {
    @doc("Video Analysis Task definition to be used with the Registration Service")
    videoAnalysis: Record<VideoAnalysisTaskRegistrationDefinition>;
}

@doc("Video Analysis Task definition to be used with the Registration Service")
model VideoAnalysisTaskRegistrationDefinition {}
