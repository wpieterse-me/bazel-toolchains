def toolchain_deps():
    native.new_local_repository(
        name = "com_github_wpieterse-me_bazel-toolchain-ps2dev-archive",
        path = "/usr/local/ps2dev",
        build_file = "@com_github_wpieterse-me_bazel-toolchain-ps2dev//toolchains:archive.BUILD",
    )

def toolchain_register():
    native.register_toolchains(
        "@com_github_wpieterse-me_bazel-toolchain-ps2dev//toolchains:mips64r5900-ps2-elf-toolchain",
        "@com_github_wpieterse-me_bazel-toolchain-ps2dev//toolchains:mipsel-ps2-elf-toolchain",
    )
