namespace DeveloperServicesApi.Models;

@doc("Payload or parameter example object.")
model ExampleObject {
  @doc("example details.")
  default: Example;
}

@doc("Payload or parameter example.")
model Example {
  @doc("Short description for the example.")
  summary: string;

  @doc("Long description for the example.")
  description: string;

  @doc("Embedded literal example. The `value` field and `externalValue` field are mutually exclusive. To represent examples of media types that cannot naturally represented in JSON or YAML, use a string value to contain the example, escaping where necessary.")
  value: object;

  @doc("A URL that points to the literal example.")
  externalValue: string;
}
