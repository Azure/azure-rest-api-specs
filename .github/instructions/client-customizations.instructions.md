## Client Customizations in TypeSpec

This document outlines how to customize client names, method names, parameter names, and other client-specific configurations using the `@clientName` decorator.

### Client Customizations General Guidelines

- DO make all client customizations in a `client.tsp` file
- DO import the client generator core library. Example:

```tsp
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
```

- AVOID importing or using `@azure-tools/typespec-client-generator-core` in other files aside from client.tsp
- DO ensure that customized names follow the naming conventions of the target language
- DO document any non-standard naming customizations with comments in the client.tsp file

#### Language-Specific Naming Conventions
- **C#**: PascalCase for types and methods, camelCase for parameters
- **Java**: PascalCase for types, camelCase for methods and parameters
- **Python**: snake_case for methods and parameters, PascalCase for types
- **JavaScript/TypeScript**: camelCase for methods and parameters, PascalCase for types

#### Client/Method/Parameter/Union/Model/Enum/Model Property/Etc. Name Customization

Syntax: `@@clientName(target, "newName", "language");`

- **target**: The TypeSpec element to rename
- **newName**: The desired name in the target language
- **language**: Optional language specifier (csharp, java, python, javascript)

#### Namespace Customization
- DO use the `@@clientNamespace` decorator to change the namespace of clients, models, enums, or unions in the generated client SDK
- DO customize namespaces for specific languages when needed. Example:

```tsp
@@clientNamespace(MyNamespace, "MyCustomNamespace", "python");
```

#### Example client.tsp Structure

```tsp
import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Client name customization
@@clientName(Contoso.WidgetManager, "WidgetManagerClient");

// Operation name customizations
@@clientName(Contoso.WidgetManager.getWidget, "get_widget", "python");

//// Model property name customizations
@@clientName(Contoso.WidgetManager.Widget.widgetId, "Id", "csharp");

//// Parameter name customizations
@@clientName(Contoso.WidgetManager.getWidget::parameters.widgetId, "id", "python");

//// Namespace customizations
// Rename namespace
@@clientNamespace(Contoso, "ContosoOperations", "csharp");
// Move model to a different namespace
@@clientNamespace(Contoso.WidgetManager.Widget, "ContosoWidgetManager.Models", "python");
```

<!-- LINKS -->
[typespec-client-generator-core client customization decorators]: https://www.npmjs.com/package/@azure-tools/typespec-client-generator-core#decorators