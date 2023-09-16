"""
third party repositories
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def _all_repositories(_ctx):
    maybe(
        http_archive,
        name = "firebase",
        url = "https://github.com/firebase/firebase-ios-sdk/releases/download/{version}/Firebase.zip".format(
            version = "10.14.0",
        ),
        sha256 = "6946169ab14716ea6ab00f6ffa4f23f25e4d81cf216ed2ecc90229c19428f281",
        strip_prefix = "Firebase",
        build_file = "@//third_party:BUILD.firebase.bazel",
    )

ext_xplat_repositories = module_extension(implementation = _all_repositories)
