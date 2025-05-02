I've recently converted my swagger specification to typespec, can you go through the files of my project and make sure they're following the best practices when doing a data-plane migration?


- DO use the [standard Typespec Azure operation templates and data-types][https://azure.github.io/typespec-azure/docs/libraries/azure-core/reference] wherever possible. Standard operation templates should be used as much as possible
- DO review model definitions and add the `@resource` decorator over models that represent resources in your service and the `@key` decorator for the resource identifier property on the model. Example:

```tsp
/** A widget. */
@resource("widgets")
model Widget {
  /** The widget name. */
  @key("widgetName")
  @visibility(Lifecycle.Read)
  name: string;

  /** The widget color. */
  color: WidgetColor;

  /** The ID of the widget's manufacturer. */
  manufacturerId: string;
}
```
