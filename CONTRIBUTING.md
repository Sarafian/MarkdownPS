# Intoduction

The repository is based on the [PowerShellTemplate]. Suggestions and contributions are very much welcome. 

# Functional changes

When adding or modifying existing functionality of the module, please consider the following:

- All cmdlets are fully tested, so please make sure to adjust or add the respected tests.
- When implementing a new cmdlet, locate one that is the most similar and copy that structure. Some parameters will be the same.
- Take special notice to the `NoNewLine` parameter for all cmdlets. Please keep it's functionality and implementation consistent.
- Cmdlets are not meant to be pipelined because the expectation is that some text will be required between different blocks and because the `-NoNewLine` parameter wouldn't make sense anyhow. For this reason the `Begin` block holds code only for stable values and everything else in the `Process` block.
- The cmdlets are reasonably well documented and this level is expected to maintained. If the function refers to a specific non-standard function like the `New-MDAlert` then please do make sure to provide the link in the `Description` that would also help explain what the parameters do. In this case, you can also use those examples as text with the cmdlet's examples.
- There is a `Demo.ps1` file that demonstrates the usage of the cmdlets and its output is also added as quote in the [README.md]. Please make sure to reflect the cmdlet changes in those files. If the code is about a new cmdlet, please add the right section in those files.
- Make sure to include your changes in the [CHANGELOG.md] under the `In progress` section at the top. Please mention your name/id as the contributor. The versioning and publishing scheme is explained further below.

# Non functional changes

The repository follows the structure and CI/CD codebase from the [PowerShellTemplate]. Before making any changes, please consider visiting the template and either here or there discuss the issue first. My other PowerShell repositories rely into this pipeline.

# Coding conventions

Not much here except that I prefer **Pascalcase** for all cmdlets and parameter names and **Camelcase** for all internal variables. Simplest is to copy an existing set of cmdlet+test.
There is no manifest file. All the respected data is in the `.psm1` file which helps generate the manifest during the publish flow. Consult the [PowerShellGallery] for this function.

# CI/CD pipeline

1. For every commit or PR, run the Pester tests and report results back to github.
2. Only for the `master` branch, execute the publish. The publish will only happen if the module's version is higher than the one in the PowerShell Gallery.

# Versioning scheme

If there are no breaking changes then the minor version will increment. The version is in the module's `.psm1` file and should not be changed as part of the pull request. All changes are mentioned in the [CHANGELOG.md] under the `In progress` version.

# Publishing a new version

When the new version is ready

1. Create new branch with respected pull request.
2. Modify the version and [CHANGELOG.md] to align with the new version. Make sure that there is a `**v1.Next Minor** *In progress*` section in the top empty.
3. Merge to `master`. This trigger the automatic execution of the publish function from AppVeyor.
4. Tag and create a new release by copying the section from the [CHANGELOG.md].


[CHANGELOG.md]: CHANGELOG.md
[README.md]: README.md
[PowerShellTemplate]: https://github.com/Sarafian/PowerShellTemplate
