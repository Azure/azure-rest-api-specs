# TypeSpec Client Customization Decorators Reference

Core decorators from `@azure-tools/typespec-client-generator-core` for SDK customization in `client.tsp`.

All decorators accept an optional `scope` parameter as the final argument to target specific languages (e.g., `"python"`, `"!csharp"`, `"java, go"`).

---

## @client

Define root clients in the SDK. Must be used on types defined in `client.tsp` (not as augmentation `@@`). Cannot be combined with `@clientLocation`.

```typespec
@client({ service: MyService })
interface MyClient {}

@client({ service: MyService, name: "CustomClient" })
interface CustomClient {}
```

## @operationGroup

Define sub-clients (operation groups). Must be used on types defined in `client.tsp` (not as augmentation `@@`). Cannot be combined with `@clientLocation`.

```typespec
@operationGroup
interface Pets {
  list is MyService.listPets;
  get is MyService.getPet;
}
```

## @clientLocation

Move operations between clients without restructuring. Cannot be combined with `@client` or `@operationGroup`.

```typespec
@@clientLocation(MyService.upload, AdminOperations);
@@clientLocation(MyService.archive, "ArchiveClient");
@@clientLocation(MyService.SubClient.health, MyService);
@@clientLocation(MyService.upload.subscriptionId, MyService);
```

## @clientName

Override generated names for SDK elements. Use PascalCase or camelCase; SDKs apply language conventions automatically.

```typespec
@@clientName(PetStore, "PetStoreClient");
@@clientName(foo, "pythonicFoo", "python");
@@clientName(foo, "CSharpFoo", "csharp");
```

## @access

Control visibility of types and operations. Internal operations propagate internal access to their models.

```typespec
@@access(getFoo, Access.internal);
@@access(Foo, Access.public);
@@access(getFoo, Access.internal, "csharp");
```

## @scope

Include or exclude operations from specific language SDKs.

```typespec
@@scope(Foo.create, "!csharp");       // All languages except C#
@@scope(Foo.create, "python");        // Python only
@@scope(Foo.create, "java, go");      // Java and Go only
```

## @override

Customize method signatures in generated clients. Only operation parameter signatures can be customized.

```typespec
model MyOperationOptions {
  foo: string;
  bar: string;
}
op myOperationCustom(options: MyOperationOptions): void;

@@override(myOperation, myOperationCustom);
```

## @alternateType

Replace types in generated clients.

```typespec
@@alternateType(Foo.date, string);
@@alternateType(Foo.date, string, "python");
@@alternateType(uri, { identity: "System.Uri", package: "System" }, "csharp");
```

## @clientInitialization

Add custom parameters to client initialization.

```typespec
model MyServiceOptions {
  subscriptionId: string;
  resourceGroup: string;
}
@@clientInitialization(MyService, { parameters: MyServiceOptions });
```

## @clientNamespace

Change the namespace/package of generated types in the client SDK.

```typespec
@@clientNamespace(MyService, "MyClient");
@@clientNamespace(MyService.MyModel, "MyClient.Models");
```

## @usage

Add usage information to models and enums. Values are additive.

```typespec
@@usage(MyModel, Usage.input | Usage.output);
```

Values: `Usage.input`, `Usage.output`, `Usage.json`, `Usage.xml`

## @clientDoc

Override documentation for client libraries.

```typespec
@@clientDoc(myOperation, "Client-specific documentation", DocumentationMode.replace);
@@clientDoc(myModel, "Additional client notes", DocumentationMode.append, "python");
```
