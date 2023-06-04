def _platform_transition_impl(settings, attr):
    _ignore = (settings, attr)

    return {
        "//command_line_option:platforms": [
            "@com_github_wpieterse-me_bazel-platforms//:arm_gba",
        ],
    }

_platform_transition = transition(
    implementation = _platform_transition_impl,
    inputs = [
    ],
    outputs = [
        "//command_line_option:platforms",
    ],
)

def _gba_binary_impl(ctx):
    fixer = ctx.executable._fixer
    executable_src = ctx.executable.binary
    executable_dst = ctx.actions.declare_file(ctx.label.name + ".gba")

    args = [
        executable_src.path,
        executable_dst.path,
    ]

    ctx.actions.run(
        executable = fixer,
        inputs = [
            executable_src,
        ],
        outputs = [
            executable_dst,
        ],
        arguments = args,
        progress_message = "Fixing %s" % executable_dst.path,
    )

    runfiles = ctx.attr.binary[0][DefaultInfo].default_runfiles

    return [
        DefaultInfo(
            executable = executable_dst,
            runfiles = runfiles,
        ),
    ]

gba_binary = rule(
    implementation = _gba_binary_impl,
    provides = [
        DefaultInfo,
    ],
    attrs = {
        "binary": attr.label(
            mandatory = True,
            cfg = _platform_transition,
            executable = True,
        ),
        "_fixer": attr.label(
            default = Label("@com_github_wpieterse-me_bazel-toolchain-gba//rules:fixer"),
            cfg = "exec",
            executable = True,
        ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
)
