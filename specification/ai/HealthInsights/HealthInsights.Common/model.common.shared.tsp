using TypeSpec.Rest;

namespace AzureHealthInsights;

@doc("""
A piece of clinical information, expressed as a code in a clinical coding system.
""")
model ClinicalCodedElement {
  @doc("The clinical coding system, e.g. ICD-10, SNOMED-CT, UMLS.")
  system: string;

  @doc("The code within the given clinical coding system.")
  code: string;

  @doc("The name of this coded concept in the coding system.")
  name?: string;

  @doc("A value associated with the code within the given clinical coding system.")
  value?: string;
}

@doc("""
A location given as a combination of city, state and country/region. It could specify a city, a state or a country/region.
In case a city is specified, either state +country/region or country/region (for countries/regions where there are no states) should be added.
In case a state is specified (without a city), country/region should be added.
""")
model GeographicLocation {
  @doc("City name.")
  city?: string;

  @doc("State name.")
  state?: string;

  @doc("Country/region name.")
  countryOrRegion: string;
}
