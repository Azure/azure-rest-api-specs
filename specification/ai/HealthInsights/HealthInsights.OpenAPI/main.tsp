import "../HealthInsights.TrialMatcher/route.trialmatcher.tsp";
import "../HealthInsights.OncoPhenotype/route.oncophenotype.tsp";
import "../HealthInsights.RadiologyInsights/route.radiologyinsights.tsp";
import "../HealthInsights.PatientTimeline/route.patienttimeline.tsp";
import "@typespec/rest";
import "@typespec/http";
import "./service.tsp";

// FIXME: This is a workaround. Tracking issue: https://github.com/microsoft/typespec/issues/2826
alias _ForceOrderOfResolutionExtension_ = Fhir.R4.Extension;
alias _ForceOrderOfResolutionCodeableConcept_ = Fhir.R4.CodeableConcept;