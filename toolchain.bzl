load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "artifact_name_pattern",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
    "with_feature_set",
)

def _wpieterse_cc_toolchain_config_impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "wrappers/i586-pc-msdosdjgpp-gcc.sh",
        ),
        tool_path(
            name = "ar",
            path = "wrappers/i586-pc-msdosdjgpp-ar.sh",
        ),
        tool_path(
            name = "cpp",
            path = "/usr/bin/false",
        ),
        tool_path(
            name = "ld",
            path = "wrappers/i586-pc-msdosdjgpp-ld.sh",
        ),
        tool_path(
            name = "nm",
            path = "/usr/bin/false",
        ),
        tool_path(
            name = "objdump",
            path = "/usr/bin/false",
        ),
        tool_path(
            name = "strip",
            path = "/usr/bin/false",
        ),
    ]

    all_compile_actions = [
        ACTION_NAMES.assemble,
        ACTION_NAMES.c_compile,
        ACTION_NAMES.clif_match,
        ACTION_NAMES.cpp_compile,
        ACTION_NAMES.cpp_header_parsing,
        ACTION_NAMES.cpp_module_codegen,
        ACTION_NAMES.cpp_module_compile,
        ACTION_NAMES.linkstamp_compile,
        ACTION_NAMES.lto_backend,
        ACTION_NAMES.preprocess_assemble,
    ]

    feature_compiler_flags = feature(
        name = "compiler_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-no-canonical-prefixes",
                            "-fno-canonical-system-headers",
                        ],
                    ),
                ],
            ),
        ],
    )

    feature_supports_pic = feature("supports_pic", enabled = False)
    feature_supports_dynamic_linker = feature("supports_dynamic_linker", enabled = False)

    features = [
        feature_compiler_flags,
        feature_supports_pic,
        feature_supports_dynamic_linker,
    ]

    artifact_names = [
        artifact_name_pattern(
            category_name = "executable",
            prefix = "",
            extension = ".exe",
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        artifact_name_patterns = artifact_names,
        toolchain_identifier = ctx.attr.toolchain_name,
        target_system_name = "fill_me",
        target_cpu = "fill_me",
        target_libc = "fill_me",
        compiler = "fill_me",
        tool_paths = tool_paths,
    )

wpieterse_cc_toolchain_config = rule(
    implementation = _wpieterse_cc_toolchain_config_impl,
    attrs = {
        "toolchain_name": attr.string(
            mandatory = True,
            doc = "Fill me",
        ),
    },
    provides = [
        CcToolchainConfigInfo,
    ],
)
