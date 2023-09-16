# Adding a new external library

1. Add a repository to [repositories.bzl](./repositories.bzl) in the form of an `http_archive` rule target.
   1. If the repository does not contain a `BUILD` or `BUILD.bazel` file, provide the `build_file` argument and point it to a `[name].bazel` file in the same directory.
2. Bring the repository into module space by adding its name (the one you gave to the `http_archive` target) to the arguments of `use_repo(ext_xplat_repositories, ...)` in [MODULE.bazel](/MODULE.bazel).
3. Reference the dependency in your own targets using the format `@[name]//:[target]` where `[name]` is the name of your repository and `[target]` is the name of some rule target declared in either your designated build file or the one provided by the vendor.
