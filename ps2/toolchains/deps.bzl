def ps2_toolchain_deps():
    native.new_local_repository(
        name = "ps2_toolchain",
        path = "/usr/local/ps2dev",
        build_file = "@com_github_wpieterse-me_bazel-toolchain-ps2//toolchains:ps2.BUILD",
    )

def ps2_toolchain_register():
    native.register_toolchains(
        "@com_github_wpieterse-me_bazel-toolchain-ps2//toolchains:mips64r5900-ps2-elf-toolchain",
    )

    native.register_toolchains(
        "@com_github_wpieterse-me_bazel-toolchain-ps2//toolchains:mipsel-ps2-elf-toolchain",
    )
