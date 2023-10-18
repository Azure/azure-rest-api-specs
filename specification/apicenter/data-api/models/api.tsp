namespace ApiCenter.DataApi.Models;

@doc("API contract")
model Api {
  @doc("The name of the API.")
  @maxLength(50)
  title: string;

  @doc("The description of the API")
  @maxLength(1000)
  description: string;

  @doc("Kind of API. For example, REST or GraphQL.")
  type: string;

  @doc("Current lifecycle stage of the API.")
  lifeCycleStage?: ApiLifecycleStage;

  @doc("URL pointing to the terms of service.")
  termsOfServiceUrl: string;

  @doc("URL pointing to the license details.")
  licenseUrl: string;

  @doc("External documentation")
  externalDocumentation?: Array<ApiExternalDocumentation>;

  @doc("Points of contact for the API.")
  contact?: Array<ApiContact>;

  @doc("The custom metadata defined for API entries.")
  customProperties: Record<string>;

  @doc("Created by.")
  createdBy: string;

  @doc("Last updated date and time.")
  lastUpdated: utcDateTime;
}

@doc("Api External Documentation Model") 
  model ApiExternalDocumentation {
    @doc("Title of the documentation.")
    @maxLength(50)
    title: string;

    @doc("URL pointing to the documentation.")
    @maxLength(200)
    url: string;
}


@doc("API Lifecycle Stage")
enum ApiLifecycleStage {
  @doc("API is in the design stage")
  Design: "design",

  @doc("API is in the development stage")
  Development: "development",

  @doc("API is in the testing stage")
  Testing: "testing",

  @doc("API is in the preview stage")
  Preview: "preview",

  @doc("API is in the production stage")
  Production: "production",

  @doc("API is in the deprecated stage")
  Deprecated: "deprecated",

  @doc("API is in the retired stage")
  Retired: "retired",
}

@doc("API contact information")
model ApiContact {
  @doc("Name of the contact.")
  @maxLength(100)
  name: string;

  @doc("URL for the contact.")
  @maxLength(200)
  url: string;

  @doc("Email address for the contact.")
  @maxLength(100)
  email: string;
}

