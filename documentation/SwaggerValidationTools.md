There are some tools that can help you make sure your specifications conform to the accepted guidelines. Better upfront validation before the final pull request is sent will result in quicker turnaround time.

# Validation tools available locally

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






