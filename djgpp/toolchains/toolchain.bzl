load(
    "@bazel_tools//tools/build_defs/cc:action_names.bzl",
    "ACTION_NAMES",
)
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "artifact_name_pattern",
    "feature",
    "tool",
)
load(
    "@com_github_wpieterse-me_bazel-toolchain-shared-gnu//toolchains:features.bzl",
    "FEATURES",
)

def _cc_toolchain_config_impl(ctx):
    features = [
        feature(
            name = "supports_pic",
            enabled = False,
        ),
        feature(
            name = "supports_dynamic_linker",
            enabled = False,
        ),
        feature(
            name = "supports_start_end_lib",
            enabled = False,
        ),
        FEATURES.disable_legacy,
        FEATURES.compiler_input,
        FEATURES.compiler_output,
        FEATURES.compiler_dependency_file,
        FEATURES.compiler_random_seed,
        FEATURES.compiler_no_canonical_prefixes,
        FEATURES.compiler_no_canonical_system_headers,
        FEATURES.compiler_include_preprocessor,
        FEATURES.compiler_include_general,
        FEATURES.compiler_include_quote,
        FEATURES.compiler_include_system,
        FEATURES.compiler_defines,
        FEATURES.compiler_user_flags,
        FEATURES.archive_common_options,
        FEATURES.archive_output,
        FEATURES.archive_input,
        FEATURES.linker_configuration_file,
        FEATURES.linker_input,
        FEATURES.linker_output,
        FEATURES.linker_link_stamp,
        FEATURES.linker_user_flags,
        feature(
            name = "opt",
        ),
        feature(
            name = "dbg",
        ),
    ]

    action_configs = [
        action_config(
            action_name = ACTION_NAMES.assemble,
            tools = [
                tool(
                    path = "wrappers/i586-pc-msdosdjgpp/as.sh",
                ),
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.preprocess_assemble,
            tools = [
                tool(
                    path = "wrappers/i586-pc-msdosdjgpp/as.sh",
                ),
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.c_compile,
            tools = [
                tool(
                    path = "wrappers/i586-pc-msdosdjgpp/gcc.sh",
                ),
            ],
            implies = [
                "compiler_dependency_file",
                "compiler_output",
                "compiler_input",
                "compiler_random_seed",
                "compiler_no_canonical_prefixes",
                "compiler_no_canonical_system_headers",
                "compiler_include_preprocessor",
                "compiler_include_general",
                "compiler_include_quote",
                "compiler_include_system",
                "compiler_defines",
                "compiler_user_flags",
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_compile,
            tools = [
                tool(
                    path = "wrappers/i586-pc-msdosdjgpp/g++.sh",
                ),
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_static_library,
            tools = [
                tool(
                    path = "wrappers/i586-pc-msdosdjgpp/ar.sh",
                ),
            ],
            implies = [
                "archive_common_options",
                "archive_output",
                "archive_input",
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.cpp_link_executable,
            tools = [
                tool(
                    path = "wrappers/i586-pc-msdosdjgpp/ld.sh",
                ),
            ],
            implies = [
                "linker_configuration_file",
                "linker_input",
                "linker_output",
                "linker_link_stamp",
                "linker_user_flags",
            ],
        ),
        action_config(
            action_name = ACTION_NAMES.strip,
            tools = [
                tool(
                    path = "wrappers/i586-pc-msdosdjgpp/strip.sh",
                ),
            ],
        ),
    ]

    artifact_name_patterns = [
        artifact_name_pattern(
            category_name = "executable",
            prefix = "",
            extension = ".exe",
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        action_configs = action_configs,
        artifact_name_patterns = artifact_name_patterns,
        toolchain_identifier = "fill_me",
        target_system_name = "fill_me",
        target_cpu = "fill_me",
        target_libc = "fill_me",
        compiler = "fill_me",
    )

cc_toolchain_config = rule(
    implementation = _cc_toolchain_config_impl,
    attrs = {
    },
    provides = [
        CcToolchainConfigInfo,
    ],
)
