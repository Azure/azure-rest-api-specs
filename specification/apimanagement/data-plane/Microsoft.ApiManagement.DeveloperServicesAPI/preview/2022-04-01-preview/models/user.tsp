namespace DeveloperServicesAPI.Models;

model User {
    id: string;
    email: string;
    firstName: string;
    lastName: string;
    state: UserState;
    registrationDate: zonedDateTime;
}

model UserCreate {
    email: string;
    password: string;
    firstName: string;
    lastName: string;
    state: UserState;
    note: string;
    confirmation: string;
    identities: IdentityResult[];
}

model UserUpdate {
    password: string;
    firstName: string;
    lastName: string;
    state: UserState;
}

enum UserState {
    Active: "active",
    Blocked: "blocked",
    Pending: "pending",
    Deleted: "deleted",
}
