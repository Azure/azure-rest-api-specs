import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "./othermodels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace Microsoft.SustainabilityServices;

@resource("factor-libraries")
@doc("Represents collection of emission and estimation factors.")
model FactorLibrary {
  @key("factorLibraryId")
  @doc("Factor library id.")
  @visibility(Lifecycle.Read)
  factorLibraryId: uuid;

  @doc("Factor library name.")
  name: string;

  @doc("Type of factor library: estimation or emission.")
  libraryType: string;

  @doc("Appropriate acknowledgment to the original content creator when utilizing or distributing their work within the application.")
  attribution?: string;

  @doc("Factor library version.")
  version?: string;

  @doc("Description of the library.")
  description?: string;

  @doc("Date published.")
  datePublished?: string;

  @doc("Documentation reference.")
  documentationReference?: string;
}

@doc("Estimation factors are used to convert proxy data into activity data that can be used with an emission factor. Typical examples are square footage of real estate to convert to energy or refrigerants, and the number of nights of a hotel stay")
@resource("estimation-factors")
@parentResource(FactorLibrary)
model EstimationFactor {
  @doc("Entity name.")
  entityName: string;

  @doc("ID.")
  id: uuid;

  @doc("Document reference.")
  documentationReference?: string;

  @doc("Estimation factor ID.")
  @key
  @visibility(Lifecycle.Read)
  estimationFactorId: uuid;

  @doc("Factor library which the estimation factor belongs to.")
  factorLibrary: LookupField;

  @doc("Estimation factor value.")
  factorValue: float64;

  @doc("Unit for factor value.")
  factorValueUnit: LookupField;

  @doc("Estimation factor name.")
  name: string;

  @doc("Subtype.")
  subtype?: string;

  @doc("Type.")
  type?: string;

  @doc("Unit.")
  unit: LookupField;
}

@doc("Conversion factor to convert quantities in activity data into greenhouse gas emissions.")
@resource("emission-factors")
@parentResource(FactorLibrary)
model EmissionFactor {
  @doc("Entity name.")
  entityName: string;

  @doc("Factor library to which the emission factor belongs to.")
  factorLibrary: LookupField;

  @doc("CH4 factor value.")
  ch4?: float64;

  @doc("Unit for CH4 factor value.")
  ch4Unit?: LookupField;

  @doc("CO2 factor value.")
  co2?: float64;

  @doc("Unit for CO2 factor value.")
  co2Unit?: LookupField;

  @doc("CO2e factor value.")
  co2e?: float64;

  @doc("Unit for CO2e factor value.")
  co2eUnit?: LookupField;

  @doc("Documentation reference.")
  documentationReference?: string;

  @doc("Emission factor ID.")
  @key("emissionFactorId")
  @visibility(Lifecycle.Read)
  emissionFactorId: uuid;

  @doc("ID.")
  id: uuid;

  @doc("HFCs factor value.")
  hfcs?: float64;

  @doc("Unit for HFCs factor value.")
  hfcsUnit?: LookupField;

  @doc("Is biofuel.")
  isBiofuel?: boolean;

  @doc("Emission factor name.")
  name: string;

  @doc("NF3 factor value.")
  nf3?: float64;

  @doc("Unit for NF3 factor value.")
  nf3Unit?: LookupField;

  @doc("NO2 factor value.")
  n2o?: float64;

  @doc("Unit for N2O factor value.")
  n2oUnit?: LookupField;

  @doc("Other GHG factor value.")
  otherGhgs?: float64;

  @doc("Unit for other GHGs factor value.")
  otherGhgsUnit?: LookupField;

  @doc("PFCs factor value.")
  pfcs?: float64;

  @doc("Unit for PFCs factor value.")
  pfcsUnit?: LookupField;

  @doc("SF6 factor value.")
  sf6?: float64;

  @doc("Unit for SF6 factor value.")
  sf6Unit?: LookupField;

  @doc("Subtype.")
  subtype?: string;

  @doc("Type.")
  type?: string;

  @doc("Unit.")
  unit?: LookupField;
}

@doc("Factor mapping.")
@resource("factor-mappings")
@parentResource(FactorLibrary)
model FactorMapping {
  @key("factorMappingId")
  @visibility(Lifecycle.Read)
  @doc("Factor mapping id.")
  factorMappingId: uuid;

  @doc("Factor library which this mapping belongs to.")
  factorLibrary: LookupField;

  @doc("Name.")
  name: string;

  @doc("Factor associated with the factor mapping.")
  factor: LookupField;

  @doc("Reference data 1")
  referenceData1: LookupField;

  @doc("Reference data 2")
  referenceData2?: LookupField;

  @doc("Reference data 3")
  referenceData3?: LookupField;

  @doc("Reference data 4")
  referenceData4?: LookupField;
}
