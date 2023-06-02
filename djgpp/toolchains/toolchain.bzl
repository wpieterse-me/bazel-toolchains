load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "artifact_name_pattern",
    "feature",
)
load(
    "@com_github_wpieterse-me_bazel-toolchain-shared-gnu//toolchains:features.bzl",
    "FEATURES",
)
load(
    "@com_github_wpieterse-me_bazel-toolchain-shared-gnu//toolchains:action_configs.bzl",
    "generate_action_configs",
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

    action_configs = generate_action_configs(
        wrapper_path = "wrappers/i586-pc-msdosdjgpp",
        c_compile_features = [
            "compiler_no_canonical_system_headers",
        ],
    )

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
