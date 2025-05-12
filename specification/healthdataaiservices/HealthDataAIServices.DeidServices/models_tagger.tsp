using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI Casing style to match OpenAI"
namespace HealthDataAIServices.DeidServices;

@doc("Result of the \"Tag\" operation.")
model PhiTaggerResult {
  @doc("List of entities detected in the input.")
  entities: Array<PhiEntity>;
}

@doc("PHI Entity tag in the input.")
model PhiEntity {
  @doc("PHI Category of the entity.")
  category: PhiCategory;

  @doc("Starting index of the location from within the input text.")
  offset: StringIndex;

  @doc("Length of the input text.")
  length: StringIndex;

  @doc("Text of the entity.")
  text?: string;

  @doc("Confidence score of the category match.")
  confidenceScore?: float64;
}

@doc("String index encoding model.")
model StringIndex {
  @doc("The offset or length of the substring in UTF-8 encoding")
  utf8: int32;

  @doc("""
    The offset or length of the substring in UTF-16 encoding.
    
    Primary encoding used by .NET, Java, and JavaScript.
    """)
  utf16: int32;

  @doc("""
    The offset or length of the substring in CodePoint encoding.
    
    Primary encoding used by Python.
    """)
  codePoint: int32;
}

@doc("List of PHI Entities.")
union PhiCategory {
  @doc("Unknown PHI Type.")
  Unknown: "Unknown",

  @doc("Account Number.")
  Account: "Account",

  @doc("Age.")
  Age: "Age",

  @doc("Biological Identifier, such as a fingerprint or retinal scan.")
  BioID: "BioID",

  @doc("City.")
  City: "City",

  @doc("Country or Region.")
  CountryOrRegion: "CountryOrRegion",

  @doc("Date.")
  Date: "Date",

  @doc("Device ID or serial numbers.")
  Device: "Device",

  @doc("Doctor's Name.")
  Doctor: "Doctor",

  @doc("Email Addresses.")
  Email: "Email",

  @doc("Fax Number.")
  Fax: "Fax",

  @doc("Health Plan ID Numbers.")
  HealthPlan: "HealthPlan",

  @doc("Hospital Name.")
  Hospital: "Hospital",

  @doc("Id Number, eg. passport number.")
  @clientName("IdNum", "java")
  IDNum: "IDNum",

  @doc("IP Address.")
  @clientName("IpAddress", "java")
  IPAddress: "IPAddress",

  @doc("License, eg. Driver's license or medical license.")
  License: "License",

  @doc("Location Other, eg. Golden Gate Park.")
  LocationOther: "LocationOther",

  @doc("Medical Record Number.")
  MedicalRecord: "MedicalRecord",

  @doc("Organization, eg. Microsoft.")
  Organization: "Organization",

  @doc("Patient Name.")
  Patient: "Patient",

  @doc("Phone Number.")
  Phone: "Phone",

  @doc("Profession.")
  Profession: "Profession",

  @doc("Social Security Number.")
  SocialSecurity: "SocialSecurity",

  @doc("State.")
  State: "State",

  @doc("Street.")
  Street: "Street",

  @doc("Web URL.")
  Url: "Url",

  @doc("Usernames, eg. a social media handle.")
  Username: "Username",

  @doc("Vehicle IDs, eg. license plate or VIN number.")
  Vehicle: "Vehicle",

  @doc("Zip Code.")
  Zip: "Zip",

  string,
}
