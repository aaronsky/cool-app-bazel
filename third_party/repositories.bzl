"""
third party repositories
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _firebase_repositories(version, sha256):
    http_archive(
        name = "firebase",
        build_file = "@//third_party:firebase.bazel",
        sha256 = sha256,
        strip_prefix = "Firebase",
        url = "https://github.com/firebase/firebase-ios-sdk/releases/download/{}/Firebase.zip".format(version),
    )

def _all_repositories(_ctx):
    _firebase_repositories(version = "10.14.0", sha256 = "6946169ab14716ea6ab00f6ffa4f23f25e4d81cf216ed2ecc90229c19428f281")

ext_xplat_repositories = module_extension(implementation = _all_repositories)
