import "@typespec/rest";
import "../../VDI.Registration/models/registration.tsp";

using TypeSpec.Rest;

namespace VdiVideoAnalysis;

@doc("Video Analysis Task definition to be used with the Registration Service")
model VideoAnalysisRegistration is VdiRegistration.AiTaskConfiguration {
    @doc("Video Analysis Task definition to be used with the Registration Service")
    videoAnalysis: Record<VideoAnalysisTaskRegistrationDefinition>;
}

@doc("Video Analysis Task definition to be used with the Registration Service")
model VideoAnalysisTaskRegistrationDefinition {}
