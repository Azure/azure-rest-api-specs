// import "../HealthInsights.TrialMatcher/route.trialmatcher.tsp";
// import "../HealthInsights.OncoPhenotype/route.oncophenotype.tsp";
// import "../HealthInsights.PatientTimeline/route.patienttimeline.tsp";
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./service.tsp";

import "../HealthInsights.RadiologyInsights/route.radiologyinsights.tsp";

// FIXME: This is a workaround. Tracking issue: https://github.com/microsoft/typespec/issues/2826
alias _ForceOrderOfReslutionExtension_ = Fhir.R4.Extension;
alias _ForceOrderOfReslutionCodeableConcept_ = Fhir.R4.CodeableConcept;
