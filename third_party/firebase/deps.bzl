"""
Repositoriy for firebase
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

DEFAULT_VERSION = "10.14.0"
DEFAULT_SHA256 = "6946169ab14716ea6ab00f6ffa4f23f25e4d81cf216ed2ecc90229c19428f281"

def _firebase_repositories(version = DEFAULT_VERSION, sha256 = DEFAULT_SHA256):
    http_archive(
        name = "firebase",
        build_file = "@//third_party/firebase:frameworks.bazel",
        sha256 = sha256,
        strip_prefix = "Firebase",
        url = "https://github.com/firebase/firebase-ios-sdk/releases/download/{}/Firebase.zip".format(version),
    )

firebase = module_extension(implementation = lambda _: _firebase_repositories())
