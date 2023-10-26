namespace ApiCenter.DataApi.Models;

@doc("API contract")
model Api {
  @doc("The resource name.")
  @maxLength(50)
  name: string;

  @doc("The name of the API.")
  @maxLength(50)
  title: string;

  @doc("Short descrption of the API.")
  @maxLength(200)
  summary?: string;

  @doc("The description of the API")
  @maxLength(1000)
  description?: string;

  @doc("Kind of API. For example, REST or GraphQL.")
  kind: string;

  @doc("Current lifecycle stage of the API.")
  lifeCycleStage?: ApiLifecycleStage;

  @doc("Terms of service for the API.")
  termsOfService?: ApiTermsOfService;

  @doc("The license information for the API.")
  license?: ApiLicenseModel;

  @doc("External documentation")
  externalDocumentation?: Array<ApiExternalDocumentation>;

  @doc("Points of contact for the API.")
  contacts?: Array<ApiContact>;

  @doc("The custom metadata defined for API entries.")
  customProperties?: Record<string>;

  @doc("Last updated date and time.")
  lastUpdated: utcDateTime;
}

@doc("Api External Documentation Model") 
  model ApiExternalDocumentation {
    @doc("Title of the documentation.")
    @maxLength(50)
    title: string;

		@doc("Description of the documentation.")
    @maxLength(1000)
		description: string;

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

@doc("API Terms of Service")
model ApiTermsOfService {
  @doc("URL pointing to the terms of service.")
  @maxLength(200)
  url: string;
}

@doc("API License Model")
model ApiLicenseModel {
  @doc("Name of the license.")
  @maxLength(50)
  name: string;
  
  @doc("URL pointing to the license details. The URL field is mutually exclusive of the identifier field.")
  @maxLength(200)
  url: string;

  @doc("SPDX license information for the API. The identifier field is mutually exclusive of the URL field.")
  @maxLength(200)
  identifier: string;
}
