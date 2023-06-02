load(
    "@com_github_wpieterse-me_bazel-toolchain-shared//rules:platform_transition.bzl",
    _platform_transition = "platform_transition",
)

def _msdos_binary_impl(ctx):
    executable_src = ctx.executable.binary
    executable_dst = ctx.actions.declare_file(ctx.label.name + ".exe")

    ctx.actions.run_shell(
        tools = [
            executable_src,
        ],
        outputs = [
            executable_dst,
        ],
        command = "cp %s %s" % (
            executable_src.path,
            executable_dst.path,
        ),
    )

    runfiles = ctx.attr.binary[0][DefaultInfo].default_runfiles

    return [
        DefaultInfo(
            executable = executable_dst,
            runfiles = runfiles,
        ),
    ]

msdos_binary = rule(
    implementation = _msdos_binary_impl,
    provides = [
        DefaultInfo,
    ],
    attrs = {
        "binary": attr.label(
            mandatory = True,
            executable = True,
            cfg = _platform_transition,
        ),
        "_target_platform": attr.label(
            default = "@com_github_wpieterse-me_bazel-platforms//:x86-32_msdos",
        ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
)
