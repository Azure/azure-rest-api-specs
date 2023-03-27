namespace DeveloperServicesApi.Models;

@doc("Tag definition.")
model Tag {
  @doc("Tag ID.")
  id: string;

  @doc("Tag name.")
  name: string;
}
