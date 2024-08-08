using TypeSpec.Rest;
namespace Fhir.R4;

alias markdown = string;

@pattern("([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)(-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1]))?)?")
scalar fhirDate extends string;

@pattern("([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)(-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\\.[0-9]{1,9})?)?)?(Z|(\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)?)?)?")
scalar fhirDateTime extends string;

@pattern("([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\\.[0-9]{1,9})?(Z|(\\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))")
scalar fhirInstant extends string;

scalar fhirUri extends string;

alias value_x = {
  @doc("Value as Quantity")
  valueQuantity?: Quantity;

  @doc("Value as CodeableConcept")
  valueCodeableConcept?: CodeableConcept;

  @doc("Value as string")
  valueString?: string;

  @doc("Value as boolean")
  valueBoolean?: boolean;

  @doc("Value as integer")
  valueInteger?: int32;

  @doc("Value as Range.")
  valueRange?: Range;

  @doc("Value as Ratio.")
  valueRatio?: Ratio;

  @doc("Value as SampledData.")
  valueSampledData?: SampledData;

  @doc("Value as time (hh:mm:ss)")
  valueTime?: plainTime;

  @doc("Value as dateTime.")
  valueDateTime?: fhirDateTime;

  @doc("Value as Period.")
  valuePeriod?: Period;

  @doc("Value as reference.")
  valueReference?: Reference;
};

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
Base for all elements
Based on [FHIR Element](https://www.hl7.org/fhir/datatypes.html#Element)
""")
model Extension extends Element {
  @doc("Source of the definition for the extension code - a logical name or a URL.")
  url: fhirUri;

  ...value_x;
}

@doc("FHIR extendible element")
model Extendible {
  @doc("Additional Content defined by implementations")
  extension?: Extension[];
}

@doc("""
The base definition for all elements contained inside a resource.
Based on [FHIR Element](https://www.hl7.org/fhir/R4/element.html)
""")
model Element {
  @doc("Unique id for inter-element referencing")
  id?: string;

  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" "must keep the name 'extension' for compatibility with FHIR"
  @doc("Additional Content defined by implementations")
  extension?: Extension[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
A Coding is a representation of a defined concept using a symbol from a defined "code system".
Based on [FHIR Coding](https://www.hl7.org/fhir/R4/datatypes.html#Coding)
""")
model Coding extends Element {
  @doc("Identity of the terminology system")
  system?: fhirUri;

  @doc("Version of the system - if relevant")
  version?: string;

  @doc("Symbol in syntax defined by the system")
  code?: string;

  @doc("Representation defined by the system")
  display?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
Concept - reference to a terminology or just text
Based on [FHIR CodeableConcept](https://www.hl7.org/fhir/R4/datatypes.html#CodeableConcept)
""")
model CodeableConcept extends Element {
  @doc("Code defined by a terminology system")
  coding?: Array<Coding>;

  @doc("Plain text representation of the concept")
  text?: string;
}

alias canonical = fhirUri;

@doc("""
Metadata about a resource
Based on [FHIR Meta](https://www.hl7.org/fhir/R4/resource.html#Meta)
""")
model Meta {
  @doc("The version specific identifier, as it appears in the version portion of the URL. This value changes when the resource is created, updated, or deleted.")
  versionId?: string;

  @doc("When the resource last changed - e.g. when the version changed.")
  lastUpdated?: fhirInstant;

  @doc("A uri that identifies the source system of the resource. This provides a minimal amount of Provenance information that can be used to track or differentiate the source of information in the resource. The source may identify another FHIR server, document, message, database, etc.")
  source?: fhirUri;

  @doc("A list of profiles (references to [StructureDefinition](https://www.hl7.org/fhir/structuredefinition.html) resources) that this resource claims to conform to. The URL is a reference to [StructureDefinition.url](https://www.hl7.org/fhir/structuredefinition-definitions.html#StructureDefinition.url).")
  profile?: Array<canonical>;

  @doc("Security labels applied to this resource. These tags connect specific resources to the overall security policy and infrastructure.")
  security?: Array<Coding>;

  @doc("Tags applied to this resource. Tags are intended to be used to identify and relate resources to process and workflow, and applications are not required to consider the tags when interpreting the meaning of a resource.")
  tag?: Array<Coding>;
}

alias xhtml = string;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
Any resource that is a [DomainResource](https://www.hl7.org/fhir/domainresource.html) may include a human-readable narrative that contains a summary of the resource and may be used to represent the content of the resource to a human.
Based on [FHIR Narrative](https://www.hl7.org/fhir/R4/narrative.html#Narrative)
""")
model Narrative extends Element {
  @doc("generated, extensions, additional, empty")
  status: string;

  @doc("xhtml")
  div: xhtml;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
A reference from one resource to another
Based on [FHIR Reference](https://www.hl7.org/fhir/R4/references.html)
""")
model Reference extends Element {
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" "must keep the name 'reference' for compatibility with FHIR"
  @doc("Literal reference, Relative, internal or absolute URL")
  reference?: string;

  @doc("Type the reference refers to (e.g. \"Patient\")")
  type?: fhirUri;

  @doc("Logical reference, when literal reference is not known")
  identifier?: Identifier;

  @doc("Text alternative for the resource")
  display?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
An identifier intended for computation
Based on [FHIR Identifier](https://www.hl7.org/fhir/R4/identifier.html)
""")
model Identifier extends Element {
  @doc("usual | official | temp | secondary | old (If known)")
  use?: string;

  @doc("Description of identifier")
  type?: CodeableConcept;

  @doc("The namespace for the identifier value")
  system?: fhirUri;

  @doc("The value that is unique")
  value?: string;

  @doc("Time period when id is/was valid for use")
  period?: Period;

  @doc("Organization that issued id (may be just text)")
  assigner?: Reference;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
A time period defined by a start and end date and optionally time
Based on [FHIR Period](https://www.hl7.org/fhir/R4/datatypes.html#Period)
""")
model Period extends Element {
  @doc("Starting time with inclusive boundary")
  start?: fhirDateTime;

  @doc("End time with inclusive boundary, if not ongoing")
  end?: fhirDateTime;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
A measured or measurable amount
Based on [FHIR Quantity](https://www.hl7.org/fhir/R4/datatypes.html#Quantity)
""")
model Quantity extends Element {
  @doc("Numerical value (with implicit precision)")
  value?: float64;

  @doc("< | <= | >= | > - how to understand the value")
  comparator?: string;

  @doc("Unit representation")
  unit?: string;

  @doc("System that defines coded unit form")
  system?: fhirUri;

  @doc("Coded form of the unit")
  code?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
A set of ordered Quantities defined by a low and high limit
Based on [FHIR Range](https://www.hl7.org/fhir/R4/datatypes.html#Range)
""")
model Range extends Element {
  @doc("Low limit")
  low?: Quantity;

  @doc("High limit")
  high?: Quantity;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
A ratio of two Quantity values - a numerator and a denominator
Based on [FHIR Ratio](https://www.hl7.org/fhir/R4/datatypes.html#Ratio)
""")
model Ratio extends Element {
  @doc("Numerator value")
  numerator?: Quantity;

  @doc("Denominator value")
  denominator?: Quantity;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
A text note which also  contains information about who made the statement and when
Based on [FHIR Annotation](https://www.hl7.org/fhir/R4/datatypes.html#Annotation)
""")
model Annotation extends Element {
  @doc("Individual responsible for the annotation")
  authorString?: string;

  @doc("When the annotation was made")
  time?: fhirDateTime;

  @doc("The annotation - text content (as markdown)")
  text: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
A series of measurements taken by a device
Based on [FHIR SampledData](https://www.hl7.org/fhir/R4/datatypes.html#SampledData)
""")
model SampledData extends Element {
  @doc("Zero value and units")
  origin: Quantity;

  @doc("Number of milliseconds between samples")
  period: float64;

  @doc("Multiply data by this before adding to origin")
  factor?: float64;

  @doc("Lower limit of detection")
  lowerLimit?: float64;

  @doc("Upper limit of detection")
  upperLimit?: float64;

  @doc("Number of sample points at each time point")
  @minValue(1)
  dimensions: int32;

  @doc("Decimal values with spaces, or \"E\" | \"U\" | \"L\"")
  data?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
Contact details (See: https://www.hl7.org/fhir/R4/metadatatypes.html#ContactDetail)
""")
model ContactDetail extends Element {
  @doc("Name of an individual to contact")
  name?: string;

  @doc("Contact details for individual or organization")
  telecom?: Array<ContactPoint>;
}

@doc("""
Details for all kinds of technology mediated contact points for a person or organization, including telephone, email, etc.
See https://www.hl7.org/fhir/R4/datatypes.html#ContactPoint
""")
model ContactPoint {
  @doc("phone | fax | email | pager | url | sms | other")
  system?: ContactPointSystem;

  @doc("The actual contact point details")
  value?: string;

  @doc("home | work | temp | old | mobile - purpose of this contact point")
  use?: ContactPointUse;

  @doc("Specify preferred order of use (1 = highest)")
  rank?: int32;

  @doc("Time period when the contact point was/is in use")
  period?: Period;
}

@doc("""
Contact Point System
see https://www.hl7.org/fhir/R4/valueset-contact-point-system.html
""")
union ContactPointSystem {
  string,

  @doc("Phone")
  Phone: "phone",

  @doc("Fax")
  Fax: "fax",

  @doc("Email")
  Email: "email",

  @doc("Pager")
  Pager: "pager",

  @doc("Url")
  Url: "url",

  @doc("Sms")
  Sms: "sms",

  @doc("Other")
  Other: "other",
}

@doc("""
Contact Point Use
See: 	http://hl7.org/fhir/ValueSet/contact-point-use
""")
union ContactPointUse {
  string,

  @doc("Home")
  Home: "home",

  @doc("Work")
  Work: "work",

  @doc("Temp")
  Temp: "temp",

  @doc("Old")
  Old: "old",

  @doc("Mobile")
  Mobile: "mobile",
}
