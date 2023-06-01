def djgpp_toolchain_deps():
    native.new_local_repository(
        name = "djgpp_toolchain",
        path = "/usr/local/my-djgpp",
        build_file = "@com_github_wpieterse-me_bazel-toolchain-djgpp//toolchain:djgpp.BUILD",
    )

def djgpp_toolchain_register():
    native.register_toolchains(
        "@com_github_wpieterse-me_bazel-toolchain-djgpp//toolchain",
    )
