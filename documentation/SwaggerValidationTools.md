There are some tools that can help you make sure your specifications conform to the accepted guidelines. Better upfront validation before the final pull request is sent will result in quicker turnaround time.

## Validation tools available online (for MS FTEs)

The [`OpenAPI Hub`](https://aka.ms/openapihub) is a great online website to find your workflow and get access to online validation tools.

Available tools:
- [**`OpenAPI Hub Linter validation tool`**](https://portal.azure-devex-tools.com/app/tools/linter)
- [**`OpenAPI Hub Static validation tool`**](https://portal.azure-devex-tools.com/app/tools/static-validation/static/errors/default)
- [**`OpenAPI Hub Swagger diff tool`**](https://portal.azure-devex-tools.com/app/tools/diff)

## Swagger Authoring ##

VS code extension is our recommendation for authoring swaggers. In addition to having a trivial GUI, it also provides the same functionalities as the Linter tool explained below.

Installation instructions available [here](https://marketplace.visualstudio.com/items?itemName=ms-vscode.autorest).

An alternative to this is the [OpenAPI Initiative Swagger editor](http://editor.swagger.io/#/). This will help find basic issues in a Swagger file. However, we apply a higher bar than this validator, if this site doesn't show errors doesn't mean that your specification is ready to merge.

## Validation tools available locally

The various tools mentioned above are also available for local download.

- Install <a href="https://nodejs.org/en/">Node.js</a> (7.10.0 or greater)
    

**Linter Validator:**

     - `npm install -g autorest`
     -  `autoRest <path to readme.md> --azure-validator=true`

   
**Static Validator (Semantic):**

     - `npm install -g oav`
     - `bash-3.2$ oav validate-spec <spec-path>`

**Static Validator (Model):**

     - `npm install -g oav`
     - `bash-3.2$ oav validate-example <spec-path>`

**Swagger diff tool**

     - `npm install -g oad@0.1.7`
     - `bash-3.2$ oad compare <old-spec> <new-spec>`

## I don't agree with the reported errors, how do I suppress them? (for MS FTEs)

If you believe that the errors reported are false positives or don't apply for your specs, you might consider reviewing the validation errors [suppression process](https://github.com/Azure/adx-documentation-pr/wiki/Swagger-Validation-Errors-Suppression) and request suppression of these errors.






