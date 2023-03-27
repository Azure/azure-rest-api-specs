namespace DeveloperServicesApi.Models;

@doc("User profile.")
model User {
  @doc("User id.")
  id: string;

  @doc("User email.")
  email: string;

  @doc("User first name.")
  firstName: string;

  @doc("User last name.")
  lastName: string;

  @doc("User state.")
  state: UserState;

  @doc("Date of user registration.")
  registrationDate: zonedDateTime;
}

@doc("User creation object.")
model UserCreate {
  @doc("User email.")
  @format("email")
  email: string;

  @doc("User password.")
  password: string;

  @doc("User first name.")
  firstName: string;

  @doc("User last name.")
  lastName: string;

  @doc("User state.")
  state?: UserState;

  @doc("User note.")
  note: string;

  @doc("User confirmation type.")
  confirmation: string;

  @doc("Collection of user identities.")
  identities: IdentityResult[];
}

@doc("User update object.")
model UserUpdate {
  @doc("User password.")
  password: string;

  @doc("User first name.")
  firstName: string;

  @doc("User last name.")
  lastName: string;

  @doc("User state.")
  state: UserState;
}

@doc("User state.")
enum UserState {
  @doc("User is active.")
  Active: "active",

  @doc("User is blocked. Blocked users cannot authenticate at developer portal or call API.")
  Blocked: "blocked",

  @doc("User account is pending. Requires identity confirmation")
  Pending: "pending",

  @doc("User account is closed. All identities and related entities are removed.")
  Deleted: "deleted",
}
