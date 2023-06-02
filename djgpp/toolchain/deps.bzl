load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
)

def toolchain_deps():
    http_archive(
        name = "djgpp_toolchain",
        build_file = "@com_github_wpieterse-me_bazel-toolchain-djgpp//toolchain:djgpp.BUILD",
        urls = [
            "https://github.com/andrewwutw/build-djgpp/releases/download/v3.3/djgpp-linux64-gcc1210.tar.bz2",
        ],
        sha256 = "46e8221e4de356c2e6ca50d93f1485184a2d310d933ffc0f5e3d5de16be9ca54",
        strip_prefix = "djgpp",
    )

def toolchain_register():
    native.register_toolchains(
        "@com_github_wpieterse-me_bazel-toolchain-djgpp//toolchain",
    )
